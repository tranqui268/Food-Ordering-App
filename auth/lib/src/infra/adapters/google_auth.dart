import 'package:async/src/result/result.dart';
import 'package:auth/src/domain/auth_service_contract.dart';
import 'package:auth/src/domain/credential.dart';
import 'package:auth/src/domain/token.dart';
import 'package:auth/src/infra/api/auth_api_contract.dart';
import 'package:google_sign_in/google_sign_in.dart';


class GoogleAuth implements IAuthService{
  final IAuthApi _api;
  late GoogleSignIn _googleSignIn;
  late GoogleSignInAccount _currentUser;

  GoogleAuth(this._api, [GoogleSignIn? googleSignIn]) : this._googleSignIn = googleSignIn ?? 
  GoogleSignIn(
    scopes: ['email','profile'],
  );

  
  @override
  Future<Result<Token>> signIn() async{
    await _handleGoogleSignIn();
    if (_currentUser == null) return Result.error('Failed to signin with Google');
    Credential credential = Credential(
      type: AuthType.google, 
      name: _currentUser.displayName ?? '', 
      email: _currentUser.email, 
      password: ''
    );
     var result = await _api.signIn(credential);
    if (result.isError) {
     return Result<Token>.error(result.asError as Object);
    }
   return Result.error(Token(result.asValue!.value));
  }

  @override
  Future<void> signOut() async {
    _googleSignIn.disconnect();
  }

  _handleGoogleSignIn() async{
    try {
      _currentUser = (await _googleSignIn.signIn())!;
    } catch (e) {
      return;
    }
  }
  
}
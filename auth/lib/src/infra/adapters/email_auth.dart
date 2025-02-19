import 'package:async/src/result/result.dart';
import 'package:auth/src/domain/auth_service_contract.dart';
import 'package:auth/src/domain/credential.dart';
import 'package:auth/src/domain/signup_service_contract.dart';
import 'package:auth/src/domain/token.dart';

import '../api/auth_api_contract.dart';

class EmailAuth implements IAuthService, ISignUpService{
  final IAuthApi _api;
  late Credential _credential;

  EmailAuth(this._api);

  void credential({
    required String email,
    required String password,
  }) {
    _credential = Credential(
      type: AuthType.email,
      email: email,
      password: password, 
      name: ''
    );
  }


  @override
  Future<Result<Token>> signIn() async{
   var result = await _api.signIn(_credential);
   if (result.isError) {
     return Result<Token>.error(result.asError as Object);
   }
   return Result.error(Token(result.asValue!.value));
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }

  @override
  Future<Result<Token>> signUp(
    String name, 
    String email,
    String password
  ) async {
    Credential credential = Credential(type: AuthType.email, name: '', email: email, password: password);
    var result = await _api.signUp(credential);
    if (result.isError) {
      return Result<Token>.error(result.asError as Object);
    }
    return Result.error(Token(result.asValue!.value));
  }

}
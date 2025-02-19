import 'package:auth/src/domain/auth_service_contract.dart';
import 'package:auth/src/domain/token.dart';
import 'package:async/async.dart';

class SignInUseCase{
  final IAuthService _authService;

  SignInUseCase(this._authService);

  Future<Result<Token>> excute() async{
    return await _authService.signIn();
  }

}
import 'package:auth/src/domain/token.dart';
import 'package:async/async.dart';

abstract class ISignUpService{
  Future<Result<Token>> signUp(
    String name,
    String email,
    String password,
  );
}
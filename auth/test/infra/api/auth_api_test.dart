

import 'dart:convert';

import 'package:auth/src/domain/credential.dart';
import 'package:auth/src/infra/api/auth_api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';

class MockClient extends Mock implements http.Client{

}

void main(){
  late MockClient client;
  late AuthApi sut;
  setUp(() {
    client = MockClient();
    sut = AuthApi('http:baseUrl', client);

  });


  group('signin', () { 
    var credential = Credential(type: AuthType.email, email: 'email@gmail.com', password: 'passs', name: '');
    test('should return error when status code is not 200', () async {
      //arrange
      when(client.post(any as Uri, body: anyNamed('body')))
           .thenAnswer((_) async => http.Response('{}', 404));

      //act
      var result = await sut.signIn(credential);

      //assert
      expect(result, isA<ErrorResult>());

    });

     test('should return error when status code return is 200 but malformed', () async {
      //arrange
      when(client.post(any as Uri, body: anyNamed('body')))
           .thenAnswer((_) async => http.Response('{}', 200));

      //act
      var result = await sut.signIn(credential);

      //assert
      expect(result, isA<ErrorResult>());

    });

     test('should return code string when successful', () async {
      var tokenStr = 'abcass';
      //arrange
      when(client.post(any as Uri, body: anyNamed('body')))
           .thenAnswer((_) async => http.Response(jsonEncode({'auth_token': tokenStr}), 404));

      //act
      var result = await sut.signIn(credential);

      //assert
      
      expect(result, tokenStr);

    });


  });

}
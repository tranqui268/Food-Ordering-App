import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:restaurent/src/api/restaurent_api.dart';
import 'package:async/async.dart';
class HttpClient extends Mock implements http.Client{}
void main(){
  late RestaurentApi sut;
  late HttpClient client;

  setUp(() {
    client = HttpClient();
    sut = RestaurentApi('baseUrl', client);
  });

  group('getAllRestaurents', () {
    test('returns an empty list when no restaurants are found', () async{
      // arrange 
      when(client.get(Uri(path: 'http'))).thenAnswer(
        (_) async => http.Response(jsonEncode({"restaurants" : []}), 200));
      
      // act
      final results = await sut.getAllRestaurents(page: 1);


      // assert
      expect(results, []);

    });

    test('returns list of restaurants when success', () async{
      // arrange 
      when(client.get(Uri(path: 'http'))).thenAnswer(
        (_) async => http.Response(jsonEncode({"restaurants" : _restaurantsJson()}), 200));
      
      // act
      final results = await sut.getAllRestaurents(page: 1);


      // assert
      expect(results, isNotEmpty);

    });

  });

}

_restaurantsJson() {
  return {
    "metadata": {"page": 1, "totalPages": 2},
    "restaurants": [
      {
        "id": "12345",
        "name": "Restuarant Name",
        "type": "Fast Food",
        "image_url": "restaurant.jpg",
        "location": {"longitude": 345.33, "latitude": 345.23},
        "address": {
          "street": "Road 1",
          "city": "City",
          "parish": "Parish",
          "zone": "Zone"
        }
      },
      {
        "id": "12666",
        "name": "Restuarant Name",
        "type": "Fast Food",
        "imageUrl": "restaurant.jpg",
        "location": {"longitude": 345.33, "latitude": 345.23},
        "address": {
          "street": "Road 1",
          "city": "City",
          "parish": "Parish",
          "zone": "Zone"
        }
      }
    ]
  };
}

_restaurantMenuJson() {
  return [
    {
      "id": "12345",
      "name": "Lunch",
      "description": "a fun menu",
      "image_url": "menu.jpg",
      "items": [
        {
          "name": "nuff food",
          "description": "awasome!!",
          "image_urls": ["url1", "url2"],
          "unit_price": 12.99
        },
        {
          "name": "nuff food",
          "description": "awasome!!",
          "image_urls": ["url1", "url2"],
          "unit_price": 12.99
        }
      ]
    }
  ];
}
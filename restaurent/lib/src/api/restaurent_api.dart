import 'dart:convert';

import 'package:http/http.dart';

import 'package:restaurent/src/api/api_contract.dart';
import 'package:restaurent/src/api/mapper.dart';
import 'package:restaurent/src/domain/menu.dart';
import 'package:restaurent/src/domain/restaurent.dart';


class RestaurentApi implements IRestaurentApi{
  final Client httpClient;
  final baseUrl;
  RestaurentApi(this.baseUrl, this.httpClient);
  @override
  Future<List<Restaurent>> findRestaurents({required int page, required String searchTerm}) {
    // TODO: implement findRestaurents
    throw UnimplementedError();
  }

  @override
  Future<List<Restaurent>> getAllRestaurents({required int page}) async{
    final endpoint = baseUrl + '/restaurants/page=$page';
    final response = httpClient.get(endpoint);
    return _parseRestaurantsJson(response as Response);
  }

  @override
  Future<Restaurent> getRestaurent({required String id}) {
    // TODO: implement getRestaurent
    throw UnimplementedError();
  }

  @override
  Future<List<Restaurent>> getRestaurentByLocation({required int page, required Location location}) {
    // TODO: implement getRestaurentByLocation
    throw UnimplementedError();
  }

  @override
  Future<Menu> getRestaurentMenu({required String restaurentId}) {
    // TODO: implement getRestaurentMenu
    throw UnimplementedError();
  }

  _parseRestaurantsJson(Response response){
    if (response.statusCode != 200) return [];
    final json = jsonDecode(response.body);
    return json['restaurants'] != null ? _restaurantFromJson(json) : [];
  }

  List _restaurantFromJson(Map<String, dynamic> json){
    final List restaurants = json['restaurants'];
    return restaurants.map((ele) => Mapper.fromJson(ele)).toList();
  }

}
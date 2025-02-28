
import 'package:restaurent/src/domain/menu.dart';
import 'package:restaurent/src/domain/restaurent.dart';

abstract class IRestaurentApi{
  Future<List<Restaurent>> getAllRestaurents({required int page});
  Future<List<Restaurent>> getRestaurentByLocation({required int page, required Location location});
  Future<List<Restaurent>> findRestaurents({required int page, required String searchTerm});
  Future<Restaurent> getRestaurent({required String id});
  Future<Menu> getRestaurentMenu({required String restaurentId});
}

import '../domain/menu.dart';
import '../domain/restaurent.dart';


class Mapper {
  static fromJson(Map<String, dynamic> json) {
    return Restaurent(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      displayImgUrl: json['displayImageUrl'] ?? '',
      location: Location(
        longtitude: json['location']['longitude'],
        latitude: json['location']['latitude'],
      ),
      address: Address(
        street: json['address']['street'],
        city: json['address']['city'],
        parish: json['address']['parish'],
        zone: json['address']['zone'] ?? '',
      ),
    );
  }

  static Menu menuFromJson(Map<String, dynamic> json) {
    return Menu(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      displayImgUrl: json['image_url'],
      items: json['items'] != null
          ? json['items']
              .map<MenuItem>(
                (item) => MenuItem(
                    name: item['name'],
                    imageUrls: item['imageUrls'].cast<String>(),
                    description: item['description'],
                    unitPrice: item['unitPrice'].toDouble()),
              )
              .toList()
          : [],
    );
  }
}

class RestaurantModel {
  String id;
  int userId;
  String? planId;
  String? subscriptionId;
  String name;
  String cnpj;
  String? levelsActive;
  String? photo;
  String? phone;
  int? distanceDelivery;
  double? distancePrice;
  int? distanceStart;
  String? open;
  String? openProgramally;
  double? lat;
  double? lng;
  String? street;
  String? zipCode;
  String? district;
  String? city;
  String? estate;
  String? complement;
  String? referencePoint;
  String? number;
  String? expiredTrial;
  String? address;

  RestaurantModel(
      {required this.id,
      required this.userId,
      required this.name,
      required this.cnpj});

  RestaurantModel.fromJson(Map<String, dynamic> json)
      : id = json['id'].toString(),
        userId = json['user_id'],
        name = json['name'],
        cnpj = json['cnpj'],
        phone = json['phone'],
        distanceDelivery = json['distance_delivery'],
        distancePrice = json['distance_price'] != null
            ? json['distance_price'] is String
                ? double.parse(json['distance_price'])
                : json['distance_price'].toDouble()
            : null,
        distanceStart = json['distance_start'],
        address = json['formatted_address'],
        lat = json['lat'] is String ? double.parse(json['lat']) : json['lat'],
        lng = json['lng'] is String ? double.parse(json['lng']) : json['lng'],
        street = json['street'],
        zipCode = json['zip_code'],
        district = json['district'],
        city = json['city'],
        estate = json['estate'],
        complement = json['complement'],
        referencePoint = json['reference_point'],
        number = json['number'];

  static List<RestaurantModel> toList(List js) =>
      js.map((e) => RestaurantModel.fromJson(e)).toList();
}

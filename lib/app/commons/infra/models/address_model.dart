class AddressModel {
  String postalCode;
  String street;
  String neighborhood;
  String city;
  String state;
  String? complement;
  String? referencePoint;
  String? number;
  double longitude;
  double latitude;

  String get formatted =>
      "$street, ${number ?? ''}, $postalCode, ${neighborhood.isEmpty ? 'Bairro não encontrado' : neighborhood}, $city - $state";

  AddressModel(
      {required this.street,
      required this.neighborhood,
      required this.postalCode,
      this.complement,
      this.referencePoint,
      required this.latitude,
      required this.longitude,
      this.number,
      required this.city,
      required this.state});

  Map<String, dynamic> toJson() => {
        "zip_code": postalCode,
        "street": street,
        "district": neighborhood,
        "city": city,
        "estate": state,
        "complement": complement,
        "reference_point": referencePoint,
        "number": number,
        "lat": latitude,
        "lng": longitude
      };
}

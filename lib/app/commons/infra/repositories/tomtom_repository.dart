import 'dart:convert';

import 'package:eatagain/app/commons/infra/models/address_model.dart';
import 'package:eatagain/app/commons/utils/map_client.dart';
import 'package:http/http.dart' as http;

class TomTomRepository implements MapClient {
  final String _host = "api.tomtom.com";
  final String _apiKey = "IgJQf83utiIPvaVoGR01r0b12kqR8MJw";
  @override
  Future<AddressModel?> getAddressByGeopoint(
      {required double latitude, required double longitude}) async {
    Uri uri = Uri.https(_host,
        "/search/2/reverseGeocode/$latitude,$longitude.json", {"key": _apiKey});
    http.Response result = await http.get(uri);
    Map<String, dynamic> json = jsonDecode(result.body);

    var addressBody = json['addresses'][0]['address'];
    return AddressModel(
        street: utf8.decode(
            ((addressBody['streetName'] ?? addressBody['street']) ?? '')
                .codeUnits),
        neighborhood:
            utf8.decode(addressBody['municipalitySubdivision'].codeUnits),
        postalCode: utf8.decode(
            (addressBody['extendedPostalCode'] ?? addressBody['postalCode'])
                .codeUnits),
        city: utf8.decode(addressBody['municipality'].codeUnits),
        state: utf8.decode(addressBody['countrySubdivision'].codeUnits),
        latitude: latitude,
        longitude: longitude);
  }
}

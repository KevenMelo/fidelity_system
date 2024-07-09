import 'package:eatagain/app/commons/infra/models/address_model.dart';

abstract class MapClient {
  Future<AddressModel?> getAddressByGeopoint(
      {required double latitude, required double longitude});
}

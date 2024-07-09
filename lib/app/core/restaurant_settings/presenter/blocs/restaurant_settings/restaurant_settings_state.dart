part of 'restaurant_settings_cubit.dart';

class RestaurantSettingsState {
  bool isLoading = false;
  bool isBusy;
  String? failedError;
  bool isLevelsActive;
  String? photo;
  AddressModel? activeAddress;
  int? activeDistanceDelivery;
  String? restaurantId;

  TextEditingController nameController;
  TextEditingController cnpjController;
  TextEditingController distanceDeliveryController;
  TextEditingController distancePriceController;
  TextEditingController distanceStartController;
  TextEditingController phoneController;
  TextEditingController numberController;
  TextEditingController referenceController;
  TextEditingController complementController;

  MapController mapDeliveryController;
  MapController mapAddressController;

  RestaurantSettingsState copyWith(
      {bool? isLoading,
      bool? isBusy,
      String? failedError,
      int? activeDistanceDelivery,
      AddressModel? activeAddress,
      String? restaurantId,
      String? photo,
      bool? isLevelsActive}) {
    return RestaurantSettingsState(
        failedError: failedError ?? this.failedError,
        isLoading: isLoading ?? this.isLoading,
        isBusy: isBusy ?? this.isBusy,
        isLevelsActive: isLevelsActive ?? this.isLevelsActive,
        restaurantId: restaurantId ?? this.restaurantId,
        photo: photo ?? this.photo,
        activeAddress: activeAddress ?? this.activeAddress,
        activeDistanceDelivery:
            activeDistanceDelivery ?? this.activeDistanceDelivery,
        nameController: nameController,
        cnpjController: cnpjController,
        distanceDeliveryController: distanceDeliveryController,
        distancePriceController: distancePriceController,
        distanceStartController: distanceStartController,
        phoneController: phoneController,
        complementController: complementController,
        numberController: numberController,
        referenceController: referenceController,
        mapDeliveryController: mapDeliveryController,
        mapAddressController: mapAddressController);
  }

  RestaurantSettingsState({
    this.failedError,
    this.isLoading = false,
    this.isBusy = false,
    this.isLevelsActive = false,
    this.activeDistanceDelivery,
    this.activeAddress,
    this.restaurantId,
    this.photo,
    TextEditingController? nameController,
    TextEditingController? cnpjController,
    TextEditingController? distanceDeliveryController,
    TextEditingController? distancePriceController,
    TextEditingController? distanceStartController,
    TextEditingController? phoneController,
    TextEditingController? numberController,
    TextEditingController? referenceController,
    TextEditingController? complementController,
    MapController? mapDeliveryController,
    MapController? mapAddressController,
  })  : nameController = nameController ?? TextEditingController(),
        cnpjController = cnpjController ?? TextEditingController(),
        distanceDeliveryController =
            distanceDeliveryController ?? TextEditingController(),
        distancePriceController =
            distancePriceController ?? TextEditingController(),
        distanceStartController =
            distanceStartController ?? TextEditingController(),
        phoneController = phoneController ?? TextEditingController(),
        numberController = numberController ?? TextEditingController(),
        referenceController = referenceController ?? TextEditingController(),
        complementController = complementController ?? TextEditingController(),
        mapAddressController = mapAddressController ?? MapController(),
        mapDeliveryController = mapDeliveryController ?? MapController();
}

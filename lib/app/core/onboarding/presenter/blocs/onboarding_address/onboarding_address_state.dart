part of 'onboarding_address_cubit.dart';

class OnboardingAddressState {
  bool isLoading = false;
  String? failedError;
  RestaurantModel? restaurant;
  AddressModel? location;
  AddressModel? activeAddress;

  MapController mapController;
  TextEditingController numberController;
  TextEditingController referenceController;
  TextEditingController complementController;
  bool isBusy;

  OnboardingAddressState copyWith(
      {bool? isLoading,
      bool? isBusy,
      String? failedError,
      RestaurantModel? restaurant,
      AddressModel? location,
      AddressModel? activeAddress}) {
    return OnboardingAddressState(
      failedError: failedError ?? this.failedError,
      isLoading: isLoading ?? this.isLoading,
      restaurant: restaurant ?? this.restaurant,
      location: location ?? this.location,
      activeAddress: activeAddress ?? this.activeAddress,
      isBusy: isBusy ?? this.isBusy,
      mapController: mapController,
      numberController: numberController,
      referenceController: referenceController,
      complementController: complementController,
    );
  }

  OnboardingAddressState(
      {this.failedError,
      this.isLoading = false,
      this.restaurant,
      this.location,
      this.activeAddress,
      this.isBusy = false,
      MapController? mapController,
      TextEditingController? numberController,
      TextEditingController? referenceController,
      TextEditingController? complementController})
      : mapController = mapController ?? MapController(),
        numberController = numberController ?? TextEditingController(),
        referenceController = referenceController ?? TextEditingController(),
        complementController = complementController ?? TextEditingController();
}

part of 'onboarding_delivery_cubit.dart';

class OnboardingDeliveryState {
  bool isBusy;
  TextEditingController distanceDeliveryController;
  TextEditingController distancePriceController;
  TextEditingController distanceStartController;
  double distanceDelivery;

  OnboardingDeliveryState copyWith({bool? isBusy, double? distanceDelivery}) {
    return OnboardingDeliveryState(
        isBusy: isBusy ?? this.isBusy,
        distanceDelivery: distanceDelivery ?? this.distanceDelivery,
        distanceDeliveryController: distanceDeliveryController,
        distancePriceController: distancePriceController,
        distanceStartController: distanceStartController);
  }

  OnboardingDeliveryState(
      {this.isBusy = false,
      this.distanceDelivery = 0,
      TextEditingController? distanceDeliveryController,
      TextEditingController? distancePriceController,
      TextEditingController? distanceStartController})
      : distanceDeliveryController =
            distanceDeliveryController ?? TextEditingController(),
        distancePriceController =
            distancePriceController ?? TextEditingController(),
        distanceStartController =
            distanceStartController ?? TextEditingController();
}

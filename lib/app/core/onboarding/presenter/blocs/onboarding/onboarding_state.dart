part of 'onboarding_cubit.dart';

class OnboardingState {
  bool isLoading = false;
  String? failedError;
  int currentStep = 0;
  RestaurantModel? restaurant;
  PageController pageViewController;
  AddressModel? activeAddress;

  OnboardingState copyWith(
      {bool? isLoading,
      String? failedError,
      int? currentStep,
      RestaurantModel? restaurant,
      AddressModel? activeAddress}) {
    return OnboardingState(
        failedError: failedError ?? this.failedError,
        isLoading: isLoading ?? this.isLoading,
        currentStep: currentStep ?? this.currentStep,
        restaurant: restaurant ?? this.restaurant,
        activeAddress: activeAddress ?? this.activeAddress,
        pageViewController: pageViewController);
  }

  OnboardingState(
      {this.failedError,
      this.isLoading = false,
      this.currentStep = 0,
      this.restaurant,
      this.activeAddress,
      PageController? pageViewController})
      : pageViewController = pageViewController ?? PageController();

  List<StepTagv2> get steps => [
        StepTagv2(
            variant: currentStep == 0
                ? StepVariantV2.current
                : currentStep > 0
                    ? StepVariantV2.complete
                    : StepVariantV2.disabled),
        StepTagv2(
            variant: currentStep == 1
                ? StepVariantV2.current
                : currentStep > 1
                    ? StepVariantV2.complete
                    : StepVariantV2.disabled),
        StepTagv2(
            variant: currentStep == 2
                ? StepVariantV2.current
                : currentStep > 2
                    ? StepVariantV2.complete
                    : StepVariantV2.disabled),
        StepTagv2(
            variant: currentStep == 3
                ? StepVariantV2.current
                : currentStep > 3
                    ? StepVariantV2.complete
                    : StepVariantV2.disabled),
        StepTagv2(
            variant: currentStep == 4
                ? StepVariantV2.current
                : currentStep > 4
                    ? StepVariantV2.complete
                    : StepVariantV2.disabled),
      ];
}

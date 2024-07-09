part of 'onboarding_data_cubit.dart';

class OnboardingDataState {
  bool isBusy = false;
  XFile? image;
  TextEditingController nameController = TextEditingController(text: '');
  TextEditingController documentController = TextEditingController(text: '');
  TextEditingController phoneController = TextEditingController(text: '');
  List<MeloUIHttpErrorFieldModel> errors = [];
  String? restaurantId;

  OnboardingDataState copyWith(
      {bool? isBusy,
      XFile? image,
      List<MeloUIHttpErrorFieldModel>? errors,
      String? restaurantId}) {
    return OnboardingDataState(
      image: image ?? this.image,
      isBusy: isBusy ?? this.isBusy,
      errors: errors ?? this.errors,
      documentController: documentController,
      nameController: nameController,
      phoneController: phoneController,
      restaurantId: restaurantId ?? this.restaurantId,
    );
  }

  OnboardingDataState({
    this.image,
    this.isBusy = false,
    this.restaurantId,
    TextEditingController? nameController,
    TextEditingController? documentController,
    TextEditingController? phoneController,
    List<MeloUIHttpErrorFieldModel>? errors,
  })  : nameController = nameController ?? TextEditingController(),
        documentController = documentController ?? TextEditingController(),
        phoneController = phoneController ?? TextEditingController(),
        errors = errors ?? [];
}

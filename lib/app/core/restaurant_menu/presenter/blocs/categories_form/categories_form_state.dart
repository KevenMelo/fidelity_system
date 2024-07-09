part of 'categories_form_cubit.dart';

class CategoriesFormState {
  bool isLoading;
  bool isBusy;
  String? id;
  TextEditingController nameController;
  TextEditingController nameComplementController;
  PageController pageController;
  List<CategoryComplementModel> complements;
  List<MeloUIHttpErrorFieldModel> errors;
  String? error;
  ComplementType? complementType;
  CategoriesFormState copyWith(
      {bool? isLoading,
      bool? isBusy,
      String? id,
      String? error,
      ComplementType? complementType,
      List<MeloUIHttpErrorFieldModel>? errors,
      List<CategoryComplementModel>? complements}) {
    return CategoriesFormState(
        id: id ?? this.id,
        complementType: complementType ?? this.complementType,
        isLoading: isLoading ?? this.isLoading,
        isBusy: isBusy ?? this.isBusy,
        errors: errors ?? this.errors,
        error: error,
        complements: complements ?? this.complements,
        pageController: pageController,
        nameController: nameController,
        nameComplementController: nameComplementController);
  }

  CategoriesFormState({
    this.isLoading = false,
    this.isBusy = false,
    this.id,
    this.error,
    this.complementType,
    this.errors = const [],
    List<CategoryComplementModel>? complements,
    TextEditingController? nameController,
    TextEditingController? nameComplementController,
    PageController? pageController,
  })  : complements = complements ?? [],
        nameController = nameController ?? TextEditingController(),
        pageController = pageController ?? PageController(),
        nameComplementController =
            nameComplementController ?? TextEditingController();
}

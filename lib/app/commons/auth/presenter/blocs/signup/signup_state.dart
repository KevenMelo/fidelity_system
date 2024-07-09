part of 'signup_cubit.dart';

class SignUpState {
  bool isBusy = false;
  List<MeloUIHttpErrorFieldModel> errors = [];
  String? failedError;
  TextEditingController nameController = TextEditingController(text: '');
  TextEditingController emailController = TextEditingController(text: '');
  TextEditingController passwordController = TextEditingController(text: '');
  User? user;

  SignUpState copyWith(
      {bool? isBusy,
      List<MeloUIHttpErrorFieldModel>? errors,
      String? failedError,
      User? user}) {
    return SignUpState(
        isBusy: isBusy ?? this.isBusy,
        errors: errors ?? this.errors,
        failedError: failedError ?? this.failedError,
        user: user ?? this.user,
        passwordController: passwordController,
        emailController: emailController,
        nameController: nameController);
  }

  SignUpState({
    this.isBusy = false,
    List<MeloUIHttpErrorFieldModel>? errors,
    this.failedError,
    this.user,
    TextEditingController? nameController,
    TextEditingController? emailController,
    TextEditingController? passwordController,
  })  : errors = errors ?? [],
        nameController = nameController ?? TextEditingController(),
        emailController = emailController ?? TextEditingController(),
        passwordController = passwordController ?? TextEditingController();
}

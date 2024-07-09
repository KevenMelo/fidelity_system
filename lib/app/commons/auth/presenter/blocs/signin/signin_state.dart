part of 'signin_cubit.dart';

class SignInState {
  bool isBusy = false;
  List<MeloUIHttpErrorFieldModel> errors = [];
  String? failedError;
  TextEditingController emailController = TextEditingController(text: '');
  TextEditingController passwordController = TextEditingController(text: '');
  UserModel? user;

  SignInState copyWith(
      {bool? isBusy,
      List<MeloUIHttpErrorFieldModel>? errors,
      String? failedError,
      UserModel? user}) {
    return SignInState(
      isBusy: isBusy ?? this.isBusy,
      errors: errors ?? this.errors,
      failedError: failedError ?? this.failedError,
      user: user ?? this.user,
      passwordController: passwordController,
      emailController: emailController,
    );
  }

  SignInState({
    this.isBusy = false,
    List<MeloUIHttpErrorFieldModel>? errors,
    this.failedError,
    this.user,
    TextEditingController? nameController,
    TextEditingController? emailController,
    TextEditingController? passwordController,
  })  : errors = errors ?? [],
        emailController = emailController ?? TextEditingController(),
        passwordController = passwordController ?? TextEditingController();
}

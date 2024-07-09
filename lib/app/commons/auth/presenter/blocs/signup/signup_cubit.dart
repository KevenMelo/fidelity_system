import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:melo_ui/melo_ui.dart';

import '../../../../../core/restaurants/restaurant_routes.dart';
import '../../../infra/repositories/auth_repository.dart';
part 'signup_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final AuthRepository _repository;
  SignUpCubit(this._repository) : super(SignUpState());

  Future<void> createUserWithEmailAndPassword() async {
    emit(state.copyWith(isBusy: true));
    List<MeloUIHttpErrorFieldModel> errors = [];
    if (state.nameController.text.isEmpty) {
      errors.add(MeloUIHttpErrorFieldModel(
          key: 'name', errors: ['Nome é uma informação obrigatória']));
    }
    if (state.emailController.text.isEmpty) {
      errors.add(MeloUIHttpErrorFieldModel(
          key: 'email', errors: ['E-mail é uma informação obrigatória']));
    }
    if (state.passwordController.text.isEmpty) {
      errors.add(MeloUIHttpErrorFieldModel(
          key: 'password', errors: ['Senha é uma informação obrigatória']));
    }
    if (errors.isNotEmpty) {
      emit(state.copyWith(isBusy: false, errors: errors));
      return;
    }
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: state.emailController.text,
        password: state.passwordController.text,
      );
      await userCredential.user!.updateDisplayName(state.nameController.text);
      // await _repository.verifyToken();
      Modular.to.pushNamedAndRemoveUntil(
        RestaurantRoutes.root.complete,
        (p0) => false,
      );
      emit(
          state.copyWith(isBusy: false, errors: [], user: userCredential.user));
    } on FirebaseAuthException catch (e) {
      List<MeloUIHttpErrorFieldModel> errors = [];
      if (e.code == 'weak-password') {
        errors.add(MeloUIHttpErrorFieldModel(key: 'password', errors: [
          'Sua senha está fraquinha, ela precisa ter 6 dígitos no mínimo'
        ]));
      } else if (e.code == 'email-already-in-use') {
        errors.add(MeloUIHttpErrorFieldModel(
            key: 'email',
            errors: ['Esse e-mail já está em uso! Você não é um hacker né?']));
      } else if (e.code == 'invalid-email') {
        errors.add(MeloUIHttpErrorFieldModel(
            key: 'email', errors: ['Seu e-mail está mal digitado']));
      }
      emit(state.copyWith(isBusy: false, errors: errors));
    } catch (e) {
      emit(state.copyWith(isBusy: false, failedError: e.toString()));
    }
  }
}

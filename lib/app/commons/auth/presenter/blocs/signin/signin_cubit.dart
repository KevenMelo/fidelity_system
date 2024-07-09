import 'package:eatagain/app/commons/auth/infra/models/user_model.dart';
import 'package:eatagain/app/core/restaurants/restaurant_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:melo_ui/melo_ui.dart';

import '../../../infra/repositories/auth_repository.dart';
part 'signin_state.dart';

class SignInCubit extends Cubit<SignInState> {
  final AuthRepository _repository;

  SignInCubit(this._repository) : super(SignInState());

  Future<void> signInWithEmailAndPassword() async {
    emit(state.copyWith(isBusy: true));
    List<MeloUIHttpErrorFieldModel> errors = [];

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
      final req = await _repository.login(
          email: state.emailController.text,
          password: state.passwordController.text);
      if (req.errors != null) {
        emit(state.copyWith(errors: req.errors, isBusy: false));
        return;
      }

      Modular.to.pushNamedAndRemoveUntil(
        RestaurantRoutes.root.complete,
        (p0) => false,
      );
      emit(state.copyWith(isBusy: false, errors: [], user: req.data));
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

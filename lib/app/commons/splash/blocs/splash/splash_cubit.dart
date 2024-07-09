import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/restaurants/restaurant_routes.dart';
import '../../../auth/infra/repositories/auth_repository.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final AuthRepository _repository;
  SplashCubit(this._repository) : super(SplashState());

  Future<void> isAuthenticated() async {
    emit(state.copyWith(isLoading: true));
    await _repository.verifyToken().then((value) {
      if (value.data != null) {
        Modular.to.navigate(RestaurantRoutes.root.complete);
      } else {
        Modular.to.navigate('/auth/signin');
        // Navigator.pushNamedAndRemoveUntil(
        //     context, AuthRoutes.signIn, (route) => false);
      }
      emit(state.copyWith(isLoading: false));
    }).catchError((err) {
      emit(state.copyWith(isLoading: false, error: err.toString()));
    });
  }
}

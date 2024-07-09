part of 'splash_cubit.dart';

class SplashState {
  bool isLoading = false;
  String? error;

  SplashState copyWith({bool? isLoading, String? error}) {
    return SplashState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  SplashState({this.isLoading = false, this.error});
}

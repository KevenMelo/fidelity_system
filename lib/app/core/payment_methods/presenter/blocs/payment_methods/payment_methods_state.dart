part of 'payment_methods_cubit.dart';

class PaymentMethodsState {
  bool isLoading = false;
  bool isBusy;
  List<PaymentMethodModel> methods;
  String? failedError;
  int activeMethod;
  List<PaymentOptionCardModel> options;

  PaymentMethodsState copyWith({
    bool? isLoading,
    bool? isBusy,
    String? failedError,
    List<PaymentMethodModel>? methods,
    List<PaymentOptionCardModel>? options,
    int? activeMethod,
  }) {
    return PaymentMethodsState(
        failedError: failedError ?? this.failedError,
        isLoading: isLoading ?? this.isLoading,
        isBusy: isBusy ?? this.isBusy,
        activeMethod: activeMethod ?? this.activeMethod,
        options: options ?? this.options,
        methods: methods ?? this.methods);
  }

  PaymentMethodsState(
      {this.failedError,
      this.isLoading = false,
      this.isBusy = false,
      this.activeMethod = 0,
      List<PaymentMethodModel>? methods,
      List<PaymentOptionCardModel>? options})
      : methods = methods ?? [],
        options = options ?? [];
}

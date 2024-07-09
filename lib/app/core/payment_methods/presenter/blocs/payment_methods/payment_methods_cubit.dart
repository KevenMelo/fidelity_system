import 'package:eatagain/app/core/payment_methods/infra/models/payment_method_model.dart';
import 'package:eatagain/app/core/payment_methods/infra/models/payment_option_card_model.dart';
import 'package:eatagain/app/core/payment_methods/infra/repositories/payment_methods_repository.dart';
import 'package:eatagain/app/core/working_days/infra/models/api/update_working_days_body_model.dart';
import 'package:eatagain/app/core/working_days/infra/models/working_day_card_model.dart';
import 'package:eatagain/app/core/working_days/infra/repositories/working_days_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'payment_methods_state.dart';

class PaymentMethodsCubit extends Cubit<PaymentMethodsState> {
  final PaymentMethodsRepository _repository;
  PaymentMethodsCubit(this._repository) : super(PaymentMethodsState());

  void handleChangeActiveMethod(int index) {
    if (state.methods.elementAtOrNull(index) == null) return;
    emit(state.copyWith(
        activeMethod: index,
        options: state.methods[index].options
            .map((e) => PaymentOptionCardModel.fromSuper(e))
            .toList()));
  }

  void hancleChangeIsActiveOption(int option, bool? value) {
    if (value == null) return;
    var options = state.options;
    options[option].isActive = value;
    emit(state.copyWith(options: options));
  }

  void hancleChangeIsPercentOption(int option, bool? value) {
    if (value == null) return;
    var options = state.options;
    options[option].isPercentTax = value;
    emit(state.copyWith(options: options));
  }

  Future<void> getPaymentMethods() async {
    emit(state.copyWith(isLoading: true));
    var response = await _repository.findAll();
    emit(state.copyWith(
        isLoading: false, failedError: response.error, methods: response.data));
    handleChangeActiveMethod(0);
  }

  Future<void> save() async {
    emit(state.copyWith(isBusy: true));
    List<PaymentMethodModel> methods = state.methods;
    methods[state.activeMethod].options =
        state.options.map((e) => e.toSuper()).toList();
    var response = await _repository.update(methods);
    emit(state.copyWith(
      isBusy: false,
      failedError: response.error,
    ));
  }
}

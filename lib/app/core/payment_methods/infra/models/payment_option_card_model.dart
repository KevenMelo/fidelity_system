import 'package:brasil_fields/brasil_fields.dart';
import 'package:eatagain/app/core/payment_methods/infra/models/payment_option_model.dart';
import 'package:flutter/material.dart';

class PaymentOptionCardModel extends PaymentOptionModel {
  TextEditingController taxController;
  PaymentOptionCardModel(
      {required super.id,
      required super.methodId,
      required super.name,
      required super.photo,
      required super.isActive,
      required super.tax,
      required super.isPercentTax,
      TextEditingController? taxController})
      : taxController = taxController ?? TextEditingController();

  factory PaymentOptionCardModel.fromSuper(PaymentOptionModel paymentOption) =>
      PaymentOptionCardModel(
          id: paymentOption.id,
          methodId: paymentOption.methodId,
          name: paymentOption.name,
          photo: paymentOption.photo,
          isActive: paymentOption.isActive,
          isPercentTax: paymentOption.isPercentTax,
          tax: paymentOption.tax,
          taxController: TextEditingController(
              text: paymentOption.isPercentTax
                  ? paymentOption.tax.toString()
                  : UtilBrasilFields.obterReal(paymentOption.tax)));

  PaymentOptionModel toSuper() => PaymentOptionModel(
        id: id,
        methodId: methodId,
        name: name,
        photo: photo,
        isActive: isActive,
        isPercentTax: isPercentTax,
        tax: double.parse(
            UtilBrasilFields.removerSimboloMoeda(taxController.text)
                .replaceAll(",", ".")),
      );
}

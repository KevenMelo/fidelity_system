import 'package:eatagain/app/core/payment_methods/infra/enums/payment_method_type.dart';
import 'package:flutter/material.dart';

extension PaymentMethodTypeExtension on PaymentMethodType {
  IconData getIcon() {
    switch (this) {
      case PaymentMethodType.cash:
        return Icons.money;
      case PaymentMethodType.creditCard:
        return Icons.credit_card;
      case PaymentMethodType.debitCard:
        return Icons.credit_card;
      case PaymentMethodType.transfer:
        return Icons.pix;
      case PaymentMethodType.ticket:
        return Icons.card_giftcard;
      default:
        return Icons.question_mark;
    }
  }
}

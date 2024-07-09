enum PaymentMethodType {
  creditCard,
  debitCard,
  cash,
  transfer,
  ticket;

  static PaymentMethodType fromName(String name) {
    switch (name.toUpperCase()) {
      case 'CRÉDITO':
        return PaymentMethodType.creditCard;
      case 'DÉBITO':
        return PaymentMethodType.debitCard;
      case 'DINHEIRO':
        return PaymentMethodType.cash;
      case 'TRANSFERÊNCIA':
        return PaymentMethodType.transfer;
      case 'VALE REFEIÇÃO':
        return PaymentMethodType.ticket;
      default:
        return PaymentMethodType.creditCard;
    }
  }
}

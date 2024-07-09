import 'package:brasil_fields/brasil_fields.dart';
import 'package:eatagain/app/commons/utils/app_utils.dart';
import 'package:eatagain/app/commons/widgets/toggle_button_widget.dart';
import 'package:eatagain/app/core/payment_methods/infra/models/payment_option_card_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:melo_ui/melo_ui.dart';

class PaymentOptionCard extends StatefulWidget {
  const PaymentOptionCard(
      {super.key,
      required this.paymentOption,
      required this.onChangedActive,
      required this.onChangedPercent});
  final PaymentOptionCardModel paymentOption;
  final ValueChanged<bool?> onChangedActive;
  final ValueChanged<bool?> onChangedPercent;

  @override
  State<PaymentOptionCard> createState() => _PaymentOptionCardState();
}

class _PaymentOptionCardState extends State<PaymentOptionCard> {
  @override
  void initState() {
    super.initState();
    widget.paymentOption.taxController.addListener(() {
      if (widget.paymentOption.taxController.text.isNotEmpty) {
        widget.onChangedActive(true);
      }
    });
  }

  @override
  void dispose() {
    widget.paymentOption.taxController.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MeloUICard(
      width: 280,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 24,
                  height: 24,
                  margin: const EdgeInsets.only(right: 8),
                  child: Image.network(widget.paymentOption.photo),
                ),
                MeloUIText(
                  widget.paymentOption.name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            )),
            ToggleButtonWidget(
              height: 48,
              value: widget.paymentOption.isActive,
              trueText: 'Ativo',
              falseText: 'Desativado',
              onChanged: widget.onChangedActive,
            ),
          ],
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MeloUITextField(
                label: 'Taxa de uso',
                margin: EdgeInsets.zero,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                formatters: widget.paymentOption.isPercentTax
                    ? []
                    : [
                        FilteringTextInputFormatter.digitsOnly,
                        CentavosInputFormatter(moeda: true)
                      ],
                controller: widget.paymentOption.taxController,
              ),
              Row(
                children: [
                  const MeloUIText('Valor é porcentagem'),
                  Checkbox(
                      activeColor: Theme.of(context).primaryColor,
                      value: widget.paymentOption.isPercentTax,
                      onChanged: (value) {
                        widget.paymentOption.taxController.clear();
                        widget.onChangedPercent(value);
                      })
                ],
              )
            ],
          ),
        ),
      ]),
    );
  }
}

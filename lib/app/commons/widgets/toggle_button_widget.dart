import 'package:flutter/material.dart';
import 'package:melo_ui/melo_ui.dart';

class ToggleButtonWidget extends StatelessWidget {
  const ToggleButtonWidget(
      {super.key,
      required this.value,
      this.label,
      this.trueText,
      this.falseText,
      this.width,
      this.height = 72,
      this.alignText = CrossAxisAlignment.start,
      this.onChanged});
  final bool value;
  final String? label;
  final double height;
  final double? width;
  final ValueChanged<bool>? onChanged;
  final CrossAxisAlignment alignText;
  final String? trueText;
  final String? falseText;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Column(
        crossAxisAlignment: alignText,
        children: [
          if (label != null)
            MeloUIText(
              label!,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          if (label != null)
            const SizedBox(
              height: 8,
            ),
          ToggleButtons(
            direction: Axis.horizontal,
            onPressed: (int clickedIndex) {
              if (onChanged != null) onChanged!(clickedIndex == 0);
            },
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            selectedBorderColor: Theme.of(context).primaryColor,
            selectedColor: Colors.white,
            fillColor: Theme.of(context).primaryColor.withOpacity(0.2),
            color: Theme.of(context).primaryColor.withOpacity(0.4),
            borderColor: Colors.grey,
            constraints: const BoxConstraints(
              minHeight: 40.0,
              minWidth: 80.0,
            ),
            isSelected: [value, !value],
            children: [
              MeloUIText(trueText ?? 'Sim'),
              MeloUIText(falseText ?? 'Não')
            ],
          ),
        ],
      ),
    );
  }
}

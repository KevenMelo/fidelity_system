import 'package:flutter/material.dart';
import 'package:melo_ui/melo_ui.dart';

class PaymentMethodCard extends StatelessWidget {
  const PaymentMethodCard(
      {super.key,
      required this.title,
      required this.icon,
      this.onTap,
      this.isActive = false});
  final String title;
  final IconData icon;
  final bool isActive;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 260,
        height: double.infinity,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: isActive ? Theme.of(context).primaryColor : null,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          MeloUIText(
            title,
            color: isActive ? Colors.white : null,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Icon(icon, size: 64, color: isActive ? Colors.white : null)
        ]),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:melo_ui/melo_ui.dart';

class CustomCardWithIcon extends StatelessWidget {
  const CustomCardWithIcon(
      {super.key,
      this.onClick,
      required this.title,
      required this.subTitle,
      required this.icon,
      this.height = 120,
      this.suffixIcon,
      this.border});

  final VoidCallback? onClick;
  final IconData icon;
  final String title;
  final String subTitle;
  final Border? border;
  final double height;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: MouseRegion(
        cursor: onClick == null ? MouseCursor.defer : SystemMouseCursors.click,
        child: Container(
          decoration: BoxDecoration(
              border: border,
              color: Colors.white,
              borderRadius: BorderRadius.circular(16)),
          padding: const EdgeInsets.all(32),
          height: height,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon),
              const SizedBox(
                width: 24,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MeloUIText(
                    title,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  MeloUIText(
                    subTitle,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              )),
              if (suffixIcon != null) suffixIcon!
            ],
          ),
        ),
      ),
    );
  }
}

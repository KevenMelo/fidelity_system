import 'package:flutter/material.dart';
import 'package:melo_ui/melo_ui.dart';

class ComplementsCard extends StatefulWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final bool isActive;
  const ComplementsCard(
      {super.key,
      required this.label,
      this.isActive = false,
      required this.icon,
      required this.onTap});

  @override
  State<ComplementsCard> createState() => ComplementsCardState();
}

class ComplementsCardState extends State<ComplementsCard> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (event) {
          setState(() {
            isHover = true;
          });
        },
        onExit: (event) {
          setState(() {
            isHover = false;
          });
        },
        child: MeloUICard(
          backgroundColor: widget.isActive || isHover ? Colors.grey : null,
          padding: const EdgeInsets.all(16),
          border: Border.all(color: Colors.black),
          width: 140,
          height: 140,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(
              widget.icon,
              size: context.height * 0.05,
              color: isHover || widget.isActive ? Colors.white : Colors.black,
            ),
            const SizedBox(
              height: 8,
            ),
            MeloUIText(
              widget.label,
              textAlign: TextAlign.center,
              color: isHover || widget.isActive ? Colors.white : Colors.black,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

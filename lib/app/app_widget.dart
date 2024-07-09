import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:melo_ui/melo_ui.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: Modular.routerConfig,
      title: 'EatAgain - Delivery',
      debugShowCheckedModeBanner: false,
      theme: MeloUITheme.generateTheme(
          colors: MeloUIColors(highlight: const Color(0xFF053225))),
    );
  }
}

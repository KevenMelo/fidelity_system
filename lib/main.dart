import 'package:eatagain/app/app_module.dart';
import 'package:eatagain/app/app_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();
  Intl.defaultLocale = 'pt_BR';
  runApp(ModularApp(
    module: AppModule(),
    child: const AppWidget(),
  ));
}

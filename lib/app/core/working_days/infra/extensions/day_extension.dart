import 'package:eatagain/app/core/working_days/infra/models/working_day_model.dart';

extension DayExtension on Day {
  String translate() {
    switch (this) {
      case Day.monday:
        return "Segunda-feira";
      case Day.tuesday:
        return "Terça-feira";
      case Day.wednesday:
        return "Quarta-feira";
      case Day.thursday:
        return "Quinta-feira";
      case Day.friday:
        return "Sexta-feira";
      case Day.saturday:
        return "Sábado";
      case Day.sunday:
        return "Domingo";
      default:
        return "Inválido";
    }
  }
}

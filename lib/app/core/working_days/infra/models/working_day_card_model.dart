import 'package:eatagain/app/core/working_days/infra/models/working_day_model.dart';
import 'package:flutter/material.dart';

class WorkingDayCardModel extends WorkingDayModel {
  TextEditingController startController;
  TextEditingController endController;

  WorkingDayCardModel(
      {required super.id,
      required super.day,
      required super.start,
      required super.end,
      required this.startController,
      required super.notOpenThisDay,
      required this.endController});

  factory WorkingDayCardModel.fromSuper(WorkingDayModel workingDay) =>
      WorkingDayCardModel(
          id: workingDay.id,
          day: workingDay.day,
          start: workingDay.start,
          end: workingDay.end,
          notOpenThisDay: workingDay.notOpenThisDay,
          startController: TextEditingController(text: workingDay.start),
          endController: TextEditingController(text: workingDay.end));

  WorkingDayModel toSuper() => WorkingDayModel(
      id: id,
      day: day,
      notOpenThisDay: notOpenThisDay,
      start: startController.text,
      end: endController.text);
}

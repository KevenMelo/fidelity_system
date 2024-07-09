import 'package:eatagain/app/core/working_days/infra/models/working_day_model.dart';

class GetWorkingDaysResponseModel {
  bool isOpened;
  bool isOpenProgramally;
  List<WorkingDayModel> days;

  GetWorkingDaysResponseModel(
      {required this.isOpened,
      required this.isOpenProgramally,
      required this.days});

  factory GetWorkingDaysResponseModel.fromJson(Map<String, dynamic> json) =>
      GetWorkingDaysResponseModel(
          isOpened:
              json['opened'] is bool ? json['opened'] : json['opened'] == 1,
          isOpenProgramally: json['open_programally'] is bool
              ? json['open_programally']
              : json['open_programally'] == 1,
          days: (json['days'] as List)
              .map((e) => WorkingDayModel.fromJson(e))
              .toList());
}

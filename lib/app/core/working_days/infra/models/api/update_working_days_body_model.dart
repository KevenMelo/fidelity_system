import 'package:eatagain/app/core/working_days/infra/models/working_day_model.dart';

class UpdateWorkingDaysBodyModel {
  bool isOpened;
  bool isOpenProgramally;
  List<WorkingDayModel> days;

  UpdateWorkingDaysBodyModel(
      {required this.isOpened,
      required this.isOpenProgramally,
      required this.days});

  Map<String, dynamic> toJson() => {
        "opened": isOpened,
        "open_programally": isOpenProgramally,
        "days": days.map((e) => e.toJson()).toList()
      };
}

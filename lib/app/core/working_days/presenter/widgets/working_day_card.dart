import 'package:eatagain/app/commons/utils/app_utils.dart';
import 'package:eatagain/app/commons/widgets/toggle_button_widget.dart';
import 'package:eatagain/app/core/working_days/infra/extensions/day_extension.dart';
import 'package:eatagain/app/core/working_days/infra/models/working_day_card_model.dart';
import 'package:flutter/material.dart';
import 'package:melo_ui/melo_ui.dart';

class WorkingDayCard extends StatefulWidget {
  const WorkingDayCard(
      {super.key, required this.workingDay, this.onChangedNotOpen});
  final WorkingDayCardModel workingDay;
  final ValueChanged<bool>? onChangedNotOpen;

  @override
  State<WorkingDayCard> createState() => _WorkingDayCardState();
}

class _WorkingDayCardState extends State<WorkingDayCard> {
  @override
  void initState() {
    super.initState();
    widget.workingDay.startController.addListener(() {
      _updateByValue();
    });
    widget.workingDay.endController.addListener(() {
      _updateByValue();
    });
  }

  void _updateByValue() {
    if (widget.onChangedNotOpen == null) return;
    if (widget.workingDay.startController.text.isNotEmpty &&
        widget.workingDay.endController.text.isNotEmpty) {
      widget.onChangedNotOpen!(false);
    } else if (widget.workingDay.startController.text.isEmpty &&
        widget.workingDay.endController.text.isEmpty) {
      widget.onChangedNotOpen!(true);
    }
  }

  @override
  void dispose() {
    widget.workingDay.startController.removeListener(() {});
    widget.workingDay.endController.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MeloUICard(
      width: double.infinity,
      height: double.infinity,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        MeloUIText(
          widget.workingDay.day.translate(),
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ToggleButtonWidget(
                value: !widget.workingDay.notOpenThisDay,
                label: 'Abre nesse dia?',
                onChanged: (value) {
                  if (widget.onChangedNotOpen != null) {
                    widget.onChangedNotOpen!(!value);
                  }
                },
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 120,
                      height: double.infinity,
                      child: MeloUIHourField(
                        label: 'Abre ás',
                        margin: EdgeInsets.zero,
                        mainAxisAlignment: MainAxisAlignment.end,
                        controller: widget.workingDay.startController,
                        initialTime: AppUtils.getTimeByString(
                            widget.workingDay.startController.text),
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    SizedBox(
                      width: 120,
                      child: MeloUIHourField(
                        label: 'Fecha ás',
                        mainAxisAlignment: MainAxisAlignment.end,
                        margin: EdgeInsets.zero,
                        controller: widget.workingDay.endController,
                        initialTime: AppUtils.getTimeByString(
                            widget.workingDay.endController.text),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}

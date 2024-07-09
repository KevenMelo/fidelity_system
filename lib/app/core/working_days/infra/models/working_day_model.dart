class WorkingDayModel {
  int id;
  Day day;
  String start;
  String end;
  bool notOpenThisDay;

  WorkingDayModel({
    required this.id,
    required this.day,
    required this.start,
    required this.end,
    required this.notOpenThisDay,
  });

  factory WorkingDayModel.fromJson(Map<String, dynamic> json) =>
      WorkingDayModel(
          id: json['id'],
          day: Day.values.firstWhere((element) => element.name == json['day']),
          start: json['start'],
          end: json['end'],
          notOpenThisDay: json['not_open'] is bool
              ? json['not_open']
              : json['not_open'] == 1);

  Map<String, dynamic> toJson() => {
        "id": id,
        "day": day.name,
        "start": start,
        "end": end,
        "not_open": notOpenThisDay
      };
}

enum Day { monday, tuesday, wednesday, thursday, friday, saturday, sunday }

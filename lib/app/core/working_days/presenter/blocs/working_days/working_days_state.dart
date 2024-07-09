part of 'working_days_cubit.dart';

class WorkingDaysState {
  bool isLoading = false;
  bool isBusy;
  List<WorkingDayCardModel> days;
  String? failedError;
  bool isOpened;
  bool isOpenProgramally;

  WorkingDaysState copyWith(
      {bool? isLoading,
      bool? isBusy,
      String? failedError,
      List<WorkingDayCardModel>? days,
      bool? isOpened,
      bool? isOpenProgramally}) {
    return WorkingDaysState(
        failedError: failedError ?? this.failedError,
        isLoading: isLoading ?? this.isLoading,
        isBusy: isBusy ?? this.isBusy,
        isOpenProgramally: isOpenProgramally ?? this.isOpenProgramally,
        isOpened: isOpened ?? this.isOpened,
        days: days ?? this.days);
  }

  WorkingDaysState(
      {this.failedError,
      this.isLoading = false,
      this.isBusy = false,
      this.isOpenProgramally = false,
      this.isOpened = false,
      List<WorkingDayCardModel>? days})
      : days = days ?? [];
}

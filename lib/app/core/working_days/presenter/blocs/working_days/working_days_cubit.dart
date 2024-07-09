import 'package:eatagain/app/core/working_days/infra/models/api/update_working_days_body_model.dart';
import 'package:eatagain/app/core/working_days/infra/models/working_day_card_model.dart';
import 'package:eatagain/app/core/working_days/infra/repositories/working_days_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'working_days_state.dart';

class WorkingDaysCubit extends Cubit<WorkingDaysState> {
  final WorkingDaysRepository _repository;
  WorkingDaysCubit(this._repository) : super(WorkingDaysState());

  void handleChangeNotOpen(int index, bool notOpen) {
    var days = state.days;
    days[index].notOpenThisDay = notOpen;
    emit(state.copyWith(days: days));
  }

  void handleChangeIsOpenProgramally(bool? value) =>
      emit(state.copyWith(isOpenProgramally: value));

  void handleChangeIsOpened(bool? value) =>
      emit(state.copyWith(isOpened: value));

  Future<void> getWorkingDays() async {
    emit(state.copyWith(isLoading: true));
    var response = await _repository.findAll();
    emit(state.copyWith(
        isLoading: false,
        failedError: response.error,
        days: response.data?.days
            .map((e) => WorkingDayCardModel.fromSuper(e))
            .toList(),
        isOpenProgramally: response.data?.isOpenProgramally,
        isOpened: response.data?.isOpened));
  }

  Future<void> save() async {
    emit(state.copyWith(isBusy: true));
    var response = await _repository.update(UpdateWorkingDaysBodyModel(
        isOpened: state.isOpened,
        isOpenProgramally: state.isOpenProgramally,
        days: state.days.map((e) => e.toSuper()).toList()));
    emit(state.copyWith(
        isBusy: false,
        failedError: response.error,
        isOpened: response.data?.isOpened,
        isOpenProgramally: response.data?.isOpenProgramally,
        days: response.data?.days
            .map((e) => WorkingDayCardModel.fromSuper(e))
            .toList()));
  }
}

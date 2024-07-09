import 'package:eatagain/app/core/working_days/infra/repositories/working_days_repository.dart';
import 'package:eatagain/app/core/working_days/presenter/blocs/working_days/working_days_cubit.dart';
import 'package:eatagain/app/core/working_days/presenter/pages/working_days_page.dart';
import 'package:eatagain/app/core/working_days/working_days_routes.dart';
import 'package:flutter_modular/flutter_modular.dart';

class WorkingDaysModule extends Module {
  @override
  void binds(i) {
    i.add<WorkingDaysRepository>(WorkingDaysRepositoryImplementation.new);
    i.addLazySingleton<WorkingDaysCubit>(WorkingDaysCubit.new);
  }

  @override
  void routes(r) {
    r.child(
      WorkingDaysRoutes.root.path,
      child: (context) => const WorkingDaysPage(),
    );
  }
}

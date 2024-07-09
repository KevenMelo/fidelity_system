import 'package:eatagain/app/commons/splash/blocs/splash/splash_cubit.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../auth/infra/repositories/auth_repository.dart';
import 'presenter/splash_page.dart';

class SplashModule extends Module {
  @override
  void binds(i) {
    i.add<AuthRepository>(AuthRepositoryImplementation.new);
    i.addLazySingleton<SplashCubit>(SplashCubit.new);
  }

  @override
  void routes(r) {
    r.child(
      '/',
      child: (context) => const SplashPage(),
    );
  }
}

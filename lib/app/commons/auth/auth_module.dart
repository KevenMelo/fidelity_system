import 'package:eatagain/app/commons/auth/infra/repositories/auth_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'presenter/blocs/signin/signin_cubit.dart';
import 'presenter/blocs/signup/signup_cubit.dart';
import 'presenter/pages/web/signin_page.dart';
import 'presenter/pages/web/signup_page.dart';

class AuthModule extends Module {
  @override
  void binds(i) {
    i.addLazySingleton<SignInCubit>(SignInCubit.new);
    i.addLazySingleton<SignUpCubit>(SignUpCubit.new);
    i.addInstance<AuthRepository>(AuthRepositoryImplementation());
  }

  @override
  void routes(r) {
    r.child(
      '/signin',
      child: (context) => const SignInWebPage(),
    );
    r.child(
      '/signup',
      child: (context) => const SignUpWebPage(),
    );
  }
}

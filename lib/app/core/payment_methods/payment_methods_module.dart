import 'package:eatagain/app/core/payment_methods/infra/repositories/payment_methods_repository.dart';
import 'package:eatagain/app/core/payment_methods/payment_methods_routes.dart';
import 'package:eatagain/app/core/payment_methods/presenter/blocs/payment_methods/payment_methods_cubit.dart';
import 'package:eatagain/app/core/payment_methods/presenter/pages/payment_methods_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class PaymentMethodsModule extends Module {
  @override
  void binds(i) {
    i.add<PaymentMethodsRepository>(PaymentMethodsRepositoryImplementation.new);
    i.addLazySingleton<PaymentMethodsCubit>(PaymentMethodsCubit.new);
  }

  @override
  void routes(r) {
    r.child(
      PaymentMethodsRoutes.root.path,
      child: (context) => const PaymentMethodsPage(),
    );
  }
}

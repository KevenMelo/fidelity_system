import 'package:eatagain/app/core/restaurant_menu/constants/restaurant_menu_routes.dart';
import 'package:eatagain/app/core/restaurant_menu/infra/repositories/categories_repository.dart';
import 'package:eatagain/app/core/restaurant_menu/presenter/blocs/categories_form/categories_form_cubit.dart';
import 'package:eatagain/app/core/restaurant_menu/presenter/blocs/categories_list/categories_list_cubit.dart';
import 'package:eatagain/app/core/restaurant_menu/presenter/pages/categories_form_page.dart';
import 'package:eatagain/app/core/restaurant_menu/presenter/pages/categories_list_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class RestaurantMenuModule extends Module {
  @override
  void binds(i) {
    //Repositories
    i.add<CategoriesRepository>(CategoriesRepositoryImplementation.new);
    //Cubits
    i.addLazySingleton<CategoriesListCubit>(CategoriesListCubit.new);
    i.addLazySingleton<CategoriesFormCubit>(CategoriesFormCubit.new);
  }

  @override
  void routes(r) {
    r.child(
      RestaurantMenuRoutes.categoriesList.path,
      child: (context) => const CategoriesListPage(),
    );
    r.child(
      RestaurantMenuRoutes.categoriesForm.path,
      child: (context) => const CategoriesFormPage(),
    );
  }
}

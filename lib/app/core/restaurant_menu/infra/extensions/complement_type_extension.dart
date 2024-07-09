import 'package:eatagain/app/core/restaurant_menu/infra/models/category_complement_model.dart';

import '../models/complement_type.dart';

extension ComplementTypeExtension on ComplementType {
  List<CategoryComplementModel> getComplements() {
    switch (this) {
      case ComplementType.custom:
        return [];
      case ComplementType.berry:
        return [
          CategoryComplementModel(
            name: 'Acompanhamentos',
          ),
          CategoryComplementModel(name: 'Cobertura'),
          CategoryComplementModel(name: 'Cremes'),
          CategoryComplementModel(name: 'Frutas'),
          CategoryComplementModel(name: 'Adicionais'),
        ];
      case ComplementType.pizza:
        return [
          CategoryComplementModel(
            name: '1° Sabor',
          ),
          CategoryComplementModel(name: '2° Sabor'),
          CategoryComplementModel(name: 'Bordas'),
        ];
      default:
        return [];
    }
  }
}

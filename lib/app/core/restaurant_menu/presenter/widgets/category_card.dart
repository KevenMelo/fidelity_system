import 'package:eatagain/app/core/restaurant_menu/infra/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:melo_ui/melo_ui.dart';

import '../blocs/categories_list/categories_list_cubit.dart';

class CategoryCard extends StatelessWidget {
  final CategoriesListCubit bloc;
  const CategoryCard({super.key, required this.category, required this.bloc});
  final CategoryModel category;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesListCubit, CategoriesListState>(
        bloc: bloc,
        builder: (context, state) {
          return Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.grey,
            ),
            child: Column(children: [
              Row(
                children: [
                  Expanded(
                      child: MeloUIText(
                    category.name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    color: Colors.white,
                  )),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: const Color(0xFFC4C4C4),
                      ),
                      child: const Icon(Icons.edit),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  InkWell(
                    onTap: state.deleteCat?.id == category.id
                        ? null
                        : () {
                            if (category.id == null) {
                              DialogHelp.error(
                                  title: 'Ocorreu um erro',
                                  message:
                                      'Não foi possivel encontrar a categoria\nContate o Suporte',
                                  context: context);
                              return;
                            }
                            bloc.handleClickDeleteCategory(category.id!);
                          },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: const Color(0xFFC4C4C4),
                      ),
                      child: state.deleteCat?.id == category.id
                          ? const CircularProgressIndicator()
                          : const Icon(Icons.delete),
                    ),
                  )
                ],
              )
            ]),
          );
        });
  }
}

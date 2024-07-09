import 'package:eatagain/app/commons/blocs/sidebar/sidebar_cubit.dart';
import 'package:eatagain/app/core/restaurant_menu/presenter/blocs/categories_list/categories_list_cubit.dart';
import 'package:eatagain/app/core/restaurant_menu/presenter/widgets/category_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:melo_ui/melo_ui.dart';

class CategoriesListPage extends StatefulWidget {
  const CategoriesListPage({super.key});

  @override
  State<CategoriesListPage> createState() => _CategoriesListPageState();
}

class _CategoriesListPageState extends State<CategoriesListPage> {
  final _sidebarBloc = Modular.get<SidebarCubit>();
  final _bloc = Modular.get<CategoriesListCubit>();

  @override
  void initState() {
    super.initState();
    _bloc.getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(children: [
      BlocBuilder<SidebarCubit, SidebarState>(
          bloc: _sidebarBloc,
          builder: (context, state) {
            return MeloUISidebar(
              logo: MeloUILogo(
                child: Image.asset('assets/logo.png'),
              ),
              onNavigateTo: _sidebarBloc.onNavigateTo,
              width: 300,
              active: state.active,
              menus: state.menus,
            );
          }),
      Expanded(
          child: BlocConsumer<CategoriesListCubit, CategoriesListState>(
              bloc: _bloc,
              listener: (context, state) {
                if (state.error != null) {
                  DialogHelp.error(
                      title: 'Ocorreu um erro',
                      message: state.error!,
                      context: context);
                }
              },
              builder: (context, state) {
                if (state.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Padding(
                  padding: const EdgeInsets.all(48),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MeloUIButton(
                            width: 220,
                            height: 48,
                            margin: EdgeInsets.zero,
                            title: 'Adicionar categoria',
                            onPressed: _bloc.handleClickGoToForm,
                            icon: Icons.add,
                          ),
                          Row(
                            children: [
                              Container(
                                width: 220,
                                margin: const EdgeInsets.only(right: 16),
                                child: MeloUIDropdown(
                                    label: '',
                                    list: ['Todas categorias'],
                                    onChanged: (value) {},
                                    value: 'Todas categorias'),
                              ),
                              const Expanded(
                                  child: MeloUITextField(
                                margin: EdgeInsets.zero,
                                label: '',
                                placeholder: 'Buscar nas categorias',
                                prefixIcon: Icon(Icons.search),
                              ))
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      Expanded(
                          child: state.categories.isEmpty
                              ? Center(
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const MeloUIText(
                                            'Você ainda não tem nenhuma Categoria cadastrada',
                                            style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold)),
                                        MeloUIButton(
                                            width: 220,
                                            title: 'Criar uma categoria',
                                            onPressed:
                                                _bloc.handleClickGoToForm)
                                      ]),
                                )
                              : DefaultTabController(
                                  length: state.categories.length,
                                  child: Scaffold(
                                    appBar: TabBar(
                                      isScrollable: true,
                                      tabs: state.categories
                                          .map((e) => Tab(
                                                text: e.name,
                                              ))
                                          .toList(),
                                    ),
                                    body: TabBarView(
                                      children: [
                                        TabBar(tabs: [
                                          Tab(
                                            text: 'Produtos',
                                          ),
                                          Tab(
                                            text: 'Complementos',
                                          ),
                                        ]),
                                      ],
                                    ),
                                  ))
                          // ListView.separated(
                          //     itemBuilder: (context, index) => CategoryCard(
                          //           bloc: _bloc,
                          //           category: state.categories[index],
                          //         ),
                          //     separatorBuilder: (context, index) =>
                          //         const SizedBox(
                          //           height: 16,
                          //         ),
                          //     itemCount: state.categories.length),
                          )
                    ],
                  ),
                );
              }))
    ]));
  }
}

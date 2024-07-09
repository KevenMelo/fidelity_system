import 'package:eatagain/app/commons/blocs/sidebar/sidebar_cubit.dart';
import 'package:eatagain/app/core/products/presenter/blocs/products_list/products_list_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:melo_ui/melo_ui.dart';

class ProductsListWebPage extends StatefulWidget {
  const ProductsListWebPage({super.key});

  @override
  State<ProductsListWebPage> createState() => _ProductsListWebPageState();
}

class _ProductsListWebPageState extends State<ProductsListWebPage> {
  final _bloc = Modular.get<ProductsListCubit>();
  final _sidebarBloc = Modular.get<SidebarCubit>();

  @override
  void initState() {
    super.initState();
    _bloc.getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
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
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: BlocBuilder<ProductsListCubit, ProductsListState>(
                bloc: _bloc,
                builder: (context, state) {
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const MeloUIText(
                            'Produtos',
                            style: TextStyle(fontSize: 32),
                          ),
                          Expanded(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              MeloUIButton(
                                margin: EdgeInsets.zero,
                                title: 'Criar produto',
                                onPressed: () {},
                                width: 200,
                                height: 48,
                              )
                            ],
                          ))
                        ],
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Row(
                        children: [
                          const Expanded(
                              child: MeloUITextField(label: 'Pesquisa')),
                          const Spacer(),
                          SizedBox(
                            width: 200,
                            child: MeloUIDropdown(
                                label: 'Status',
                                list: const ['Abertos'],
                                onChanged: (value) {},
                                value: 'Abertos'),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Expanded(child: Builder(builder: (context) {
                        if (state.isLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        return MeloUITable(
                          columns: const [
                            DataColumn(label: MeloUIText('Produto ID')),
                            DataColumn(label: MeloUIText('Nome')),
                            DataColumn(label: MeloUIText('Preço'))
                          ],
                          rows: state.products
                              .map((element) => DataRow(cells: [
                                    DataCell(MeloUIText(element.id.toString())),
                                    DataCell(MeloUIText(element.name)),
                                    DataCell(
                                        MeloUIText(element.price.toString())),
                                  ]))
                              .toList(),
                          currentPage: 1,
                          nextPage: () {},
                          prevPage: () {},
                          totalPages: 1,
                        );
                      }))
                    ],
                  );
                }),
          ))
        ],
      ),
    );
  }
}

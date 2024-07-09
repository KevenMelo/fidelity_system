import 'package:eatagain/app/commons/blocs/sidebar/sidebar_cubit.dart';
import 'package:eatagain/app/core/orders/presenter/blocs/orders_list/orders_list_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:melo_ui/melo_ui.dart';

class OrdersListWebPage extends StatefulWidget {
  const OrdersListWebPage({super.key});

  @override
  State<OrdersListWebPage> createState() => _OrdersListWebPageState();
}

class _OrdersListWebPageState extends State<OrdersListWebPage> {
  final _bloc = Modular.get<OrdersListCubit>();
  final _sidebarBloc = Modular.get<SidebarCubit>();

  @override
  void initState() {
    super.initState();
    _bloc.getOrders();
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
            child: BlocBuilder<OrdersListCubit, OrdersListState>(
                bloc: _bloc,
                builder: (context, state) {
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const MeloUIText(
                            'Pedidos',
                            style: TextStyle(fontSize: 32),
                          ),
                          Expanded(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              MeloUIButton(
                                margin: EdgeInsets.zero,
                                title: 'Criar pedido',
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
                            DataColumn(label: MeloUIText('Pedido ID')),
                            DataColumn(label: MeloUIText('Cliente')),
                            DataColumn(label: MeloUIText('Endereço')),
                            DataColumn(label: MeloUIText('Preço')),
                            DataColumn(label: MeloUIText('Status'))
                          ],
                          rows: state.orders
                              .map((order) => DataRow(cells: [
                                    DataCell(MeloUIText(order.id.toString())),
                                    DataCell(MeloUIText(order.customer)),
                                    DataCell(MeloUIText(order.address)),
                                    DataCell(
                                        MeloUIText(order.price.toString())),
                                    DataCell(MeloUIText(order.status)),
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

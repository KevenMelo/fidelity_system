import 'package:eatagain/app/core/products/presenter/blocs/products_list/products_list_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:melo_ui/melo_ui.dart';

class ProductsFormWebPage extends StatefulWidget {
  const ProductsFormWebPage({super.key});

  @override
  State<ProductsFormWebPage> createState() => _ProductsFormWebPageState();
}

class _ProductsFormWebPageState extends State<ProductsFormWebPage> {
  final _bloc = Modular.get<ProductsListCubit>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          MeloUISidebar(
            logo: MeloUILogo(
              child: Image.asset('assets/logo.png'),
            ),
            onNavigateTo: (page) {},
            width: 300,
            active: 1,
            menus: [
              MeloUINavItemModel(
                  icon: Icons.storefront_rounded,
                  name: 'Pedidos',
                  isActived: false),
              MeloUINavItemModel(
                  icon: Icons.menu_book, name: 'Produtos', isActived: true),
            ],
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: BlocBuilder<ProductsListCubit, ProductsListState>(
                bloc: _bloc,
                builder: (context, state) {
                  return Column(
                    children: [
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(Icons.arrow_back)),
                          const MeloUIText(
                            'Criar produto',
                            style: TextStyle(fontSize: 32),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      const Expanded(
                          child: Column(
                        children: [],
                      ))
                    ],
                  );
                }),
          ))
        ],
      ),
    );
  }
}

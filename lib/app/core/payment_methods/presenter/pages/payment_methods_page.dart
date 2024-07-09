import 'package:eatagain/app/commons/blocs/sidebar/sidebar_cubit.dart';
import 'package:eatagain/app/core/payment_methods/infra/extensions/payment_method_type_extension.dart';
import 'package:eatagain/app/core/payment_methods/presenter/blocs/payment_methods/payment_methods_cubit.dart';
import 'package:eatagain/app/core/payment_methods/presenter/widgets/payment_method_card.dart';
import 'package:eatagain/app/core/payment_methods/presenter/widgets/payment_option_card.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:melo_ui/melo_ui.dart';

class PaymentMethodsPage extends StatefulWidget {
  const PaymentMethodsPage({super.key});

  @override
  State<PaymentMethodsPage> createState() => _PaymentMethodsPageState();
}

class _PaymentMethodsPageState extends State<PaymentMethodsPage> {
  final _sidebarBloc = Modular.get<SidebarCubit>();
  final _bloc = Modular.get<PaymentMethodsCubit>();

  @override
  void initState() {
    super.initState();
    _bloc.getPaymentMethods();
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
              child: BlocBuilder<PaymentMethodsCubit, PaymentMethodsState>(
                  bloc: _bloc,
                  builder: (context, state) {
                    if (state.isLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (state.failedError != null) {
                      return Center(
                        child: Text(
                            state.failedError ?? "Falha ao buscar horários"),
                      );
                    }
                    return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MeloUICard(
                                width: double.infinity,
                                height: 200,
                                child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) =>
                                        PaymentMethodCard(
                                          onTap: () {
                                            _bloc.handleChangeActiveMethod(
                                                index);
                                          },
                                          title: state.methods[index].name,
                                          icon: state.methods[index].type
                                              .getIcon(),
                                          isActive: state.activeMethod == index,
                                        ),
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(
                                          width: 16,
                                        ),
                                    itemCount: state.methods.length)),
                            const SizedBox(
                              height: 16,
                            ),
                            const MeloUIText(
                              'Opções de pagamentos',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 24),
                            ),
                            const Divider(),
                            Expanded(
                              child: GridView.builder(
                                itemCount: state.options.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        childAspectRatio: 2.5,
                                        crossAxisSpacing: 16,
                                        mainAxisSpacing: 16),
                                itemBuilder: (context, index) =>
                                    PaymentOptionCard(
                                  onChangedActive: (value) {
                                    _bloc.hancleChangeIsActiveOption(
                                        index, value);
                                  },
                                  onChangedPercent: (value) {
                                    _bloc.hancleChangeIsPercentOption(
                                        index, value);
                                  },
                                  paymentOption: state.options[index],
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                const Spacer(),
                                MeloUIButton(
                                    width: 350,
                                    height: 48,
                                    title: 'Salvar',
                                    isLoading: state.isBusy,
                                    onPressed: _bloc.save),
                              ],
                            ),
                            const SizedBox(
                              height: 80,
                            )
                          ],
                        ));
                  }))
        ],
      ),
    );
  }
}

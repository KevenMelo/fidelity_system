import 'package:eatagain/app/commons/infra/models/address_model.dart';
import 'package:eatagain/app/commons/widgets/dialogs/select_address_map_dialog.dart';
import 'package:eatagain/app/core/onboarding/presenter/blocs/onboarding/onboarding_cubit.dart';
import 'package:eatagain/app/core/onboarding/presenter/blocs/onboarding_address/onboarding_address_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:melo_ui/melo_ui.dart';

import '../../../../../commons/widgets/step_progress_v2.dart';

class OnboardingAddressWebPage extends StatefulWidget {
  const OnboardingAddressWebPage({super.key});

  @override
  State<OnboardingAddressWebPage> createState() =>
      _OnboardingAddressWebPageState();
}

class _OnboardingAddressWebPageState extends State<OnboardingAddressWebPage> {
  final _blocOnboarding = Modular.get<OnboardingCubit>();
  final _bloc = Modular.get<OnboardingAddressCubit>();

  @override
  void initState() {
    super.initState();
    _blocOnboarding.initialize();
    _bloc.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: BlocBuilder<OnboardingCubit, OnboardingState>(
            bloc: _blocOnboarding,
            builder: (context, stateOnboarding) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StepProgressv2(
                    currentStep: stateOnboarding.currentStep + 1,
                    steps: stateOnboarding.steps,
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(top: 24),
                      child: BlocBuilder<OnboardingAddressCubit,
                              OnboardingAddressState>(
                          bloc: _bloc,
                          builder: (context, state) {
                            return Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            IconButton(
                                                onPressed: () {},
                                                icon: const Icon(
                                                    Icons.arrow_back)),
                                            const MeloUIText(
                                              "Selecione o seu endereço",
                                              style: TextStyle(fontSize: 24),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 16,
                                        ),
                                        if (state.location != null)
                                          GestureDetector(
                                            onTap: () {
                                              _bloc.onChangeActiveAddress(
                                                  state.location!);
                                            },
                                            child: MouseRegion(
                                              cursor: SystemMouseCursors.click,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16)),
                                                padding:
                                                    const EdgeInsets.all(32),
                                                height: 120,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    const Icon(Icons.gps_fixed),
                                                    const SizedBox(
                                                      width: 24,
                                                    ),
                                                    Expanded(
                                                        child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        const MeloUIText(
                                                          "Usar minha localização atual",
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        const SizedBox(
                                                          height: 8,
                                                        ),
                                                        MeloUIText(
                                                          state.location!
                                                              .formatted,
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 16),
                                                        )
                                                      ],
                                                    ))
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        MeloUIButton(
                                            title:
                                                "Encontrar endereço usando mapa",
                                            icon: Icons.map,
                                            margin:
                                                const EdgeInsets.only(top: 24),
                                            onPressed: () {
                                              showDialog<AddressModel?>(
                                                context: context,
                                                builder: (context) =>
                                                    const SelectAddressMapDialog(
                                                        latitude: -9.66625,
                                                        longitude: -35.7351),
                                              ).then((value) {
                                                if (value != null) {
                                                  _bloc.onChangeActiveAddress(
                                                      value);
                                                }
                                              });
                                            }),
                                        MeloUIButton(
                                            title: "Pesquisar meu endereço",
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 16),
                                            icon: Icons.location_searching,
                                            onPressed: () {}),
                                        const Spacer(),
                                        SizedBox(
                                          height: 120,
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: MeloUIButton(
                                                  title: 'Voltar',
                                                  onPressed: () {},
                                                  variant: MeloUIButtonVariant
                                                      .outlined,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 16,
                                              ),
                                              Expanded(
                                                  child: MeloUIButton(
                                                      title: 'Continuar',
                                                      onPressed: () {})),
                                            ],
                                          ),
                                        )
                                      ]),
                                ),
                                const Spacer(
                                  flex: 3,
                                ),
                              ],
                            );
                          }),
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}

import 'package:eatagain/app/commons/widgets/custom_card_with_icon.dart';
import 'package:eatagain/app/commons/widgets/map_widget.dart';
import 'package:eatagain/app/core/onboarding/presenter/blocs/onboarding/onboarding_cubit.dart';
import 'package:eatagain/app/core/onboarding/presenter/blocs/onboarding_address/onboarding_address_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:latlong2/latlong.dart';
import 'package:melo_ui/melo_ui.dart';

import '../../../../../commons/widgets/step_progress_v2.dart';

class OnboardingConfirmAddressWebPage extends StatefulWidget {
  const OnboardingConfirmAddressWebPage({super.key});

  @override
  State<OnboardingConfirmAddressWebPage> createState() =>
      _OnboardingConfirmAddressWebPageState();
}

class _OnboardingConfirmAddressWebPageState
    extends State<OnboardingConfirmAddressWebPage> {
  final _blocOnboarding = Modular.get<OnboardingCubit>();
  final _bloc = Modular.get<OnboardingAddressCubit>();

  @override
  void initState() {
    super.initState();
    _blocOnboarding.initialize();
    _bloc.hasAddressToConfirm();
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
              if (stateOnboarding.isLoading ||
                  stateOnboarding.restaurant == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
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
                      child: BlocConsumer<OnboardingAddressCubit,
                              OnboardingAddressState>(
                          bloc: _bloc,
                          listener: (context, state) {
                            if (state.failedError != null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  MeloUIErrorSnackbar(
                                      context: context,
                                      content: MeloUIText(state.failedError!)));
                            }
                          },
                          builder: (context, state) {
                            if (state.activeAddress == null) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            return Row(
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 32),
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
                                                "Confirme o seu endereço",
                                                style: TextStyle(fontSize: 24),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 24,
                                          ),
                                          Expanded(
                                              child: Row(
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: const Color(
                                                              0xFFC4C4C4)),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16)),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16),
                                                    child: Scaffold(
                                                      body: MapWidget(
                                                        controller:
                                                            state.mapController,
                                                        center: MapWidgetMarker(
                                                            latitude: state
                                                                .activeAddress!
                                                                .latitude,
                                                            longitude: state
                                                                .activeAddress!
                                                                .longitude),
                                                        zoom: 15,
                                                        markers: [
                                                          MapWidgetMarker(
                                                              latitude: state
                                                                  .activeAddress!
                                                                  .latitude,
                                                              longitude: state
                                                                  .activeAddress!
                                                                  .longitude,
                                                              width: 60,
                                                              height: 60,
                                                              child: Icon(
                                                                  Icons
                                                                      .location_on,
                                                                  size: 48,
                                                                  color: Theme.of(
                                                                          context)
                                                                      .colorScheme
                                                                      .primary))
                                                        ],
                                                      ),
                                                      floatingActionButton:
                                                          FloatingActionButton(
                                                        onPressed: () {
                                                          state.mapController.move(
                                                              LatLng(
                                                                  state
                                                                      .activeAddress!
                                                                      .latitude,
                                                                  state
                                                                      .activeAddress!
                                                                      .longitude),
                                                              15);
                                                        },
                                                        child: Icon(
                                                            Icons.my_location,
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .primary),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 32,
                                              ),
                                              Expanded(
                                                  child: Column(
                                                children: [
                                                  CustomCardWithIcon(
                                                    icon: Icons.place,
                                                    title: 'Endereço escolhido',
                                                    subTitle: state
                                                        .activeAddress!
                                                        .formatted,
                                                  ),
                                                  const SizedBox(
                                                    height: 16,
                                                  ),
                                                  MeloUITextField(
                                                    label: 'Número',
                                                    placeholder:
                                                        'Digite o número',
                                                    controller:
                                                        state.numberController,
                                                    keyboardType:
                                                        TextInputType.number,
                                                  ),
                                                  MeloUITextField(
                                                    label:
                                                        'Ponto de referência',
                                                    placeholder:
                                                        'Digite o ponto de referência',
                                                    controller: state
                                                        .referenceController,
                                                  ),
                                                  MeloUITextField(
                                                    label: 'Complemento',
                                                    placeholder:
                                                        'Digite o complemento',
                                                    controller: state
                                                        .complementController,
                                                  ),
                                                  const SizedBox(
                                                    height: 16,
                                                  ),
                                                  const Spacer(),
                                                  SizedBox(
                                                    height: 120,
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        Expanded(
                                                          child: MeloUIButton(
                                                            title: 'Voltar',
                                                            margin:
                                                                EdgeInsets.zero,
                                                            onPressed: () {},
                                                            variant:
                                                                MeloUIButtonVariant
                                                                    .outlined,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 16,
                                                        ),
                                                        Expanded(
                                                            child: MeloUIButton(
                                                                margin:
                                                                    EdgeInsets
                                                                        .zero,
                                                                title:
                                                                    'Continuar',
                                                                isLoading: state
                                                                    .isBusy,
                                                                onPressed: () {
                                                                  _bloc.save(
                                                                      stateOnboarding
                                                                          .restaurant!
                                                                          .id);
                                                                })),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ))
                                            ],
                                          )),
                                        ]),
                                  ),
                                ),
                                const Spacer(
                                  flex: 1,
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

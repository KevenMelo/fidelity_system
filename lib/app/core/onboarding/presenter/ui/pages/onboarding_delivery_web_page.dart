import 'package:brasil_fields/brasil_fields.dart';
import 'package:eatagain/app/core/onboarding/presenter/blocs/onboarding/onboarding_cubit.dart';
import 'package:eatagain/app/core/onboarding/presenter/blocs/onboarding_delivery/onboarding_delivery_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:latlong2/latlong.dart';
import 'package:melo_ui/melo_ui.dart';

import '../../../../../commons/widgets/step_progress_v2.dart';

class OnboardingDeliveryWebPage extends StatefulWidget {
  const OnboardingDeliveryWebPage({super.key});

  @override
  State<OnboardingDeliveryWebPage> createState() =>
      _OnboardingDeliveryWebPageState();
}

class _OnboardingDeliveryWebPageState extends State<OnboardingDeliveryWebPage> {
  final _blocOnboarding = Modular.get<OnboardingCubit>();
  final _bloc = Modular.get<OnboardingDeliveryCubit>();

  @override
  void initState() {
    super.initState();
    _blocOnboarding.initialize();
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
                return Center(
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
                      child: BlocBuilder<OnboardingDeliveryCubit,
                              OnboardingDeliveryState>(
                          bloc: _bloc,
                          builder: (context, state) {
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
                                                          color: Color(
                                                              0xFFC4C4C4)),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16)),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16),
                                                    child: FlutterMap(
                                                      options: MapOptions(
                                                        center: LatLng(
                                                            stateOnboarding
                                                                .restaurant!
                                                                .lat!,
                                                            stateOnboarding
                                                                .restaurant!
                                                                .lng!),
                                                        zoom: 15,
                                                      ),
                                                      children: [
                                                        TileLayer(
                                                          urlTemplate:
                                                              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                                        ),
                                                        CircleLayer(
                                                          circles: [
                                                            CircleMarker(
                                                                point: LatLng(
                                                                    stateOnboarding
                                                                        .restaurant!
                                                                        .lat!,
                                                                    stateOnboarding
                                                                        .restaurant!
                                                                        .lng!),
                                                                radius: state
                                                                        .distanceDelivery *
                                                                    1000,
                                                                color: Colors
                                                                    .red
                                                                    .withOpacity(
                                                                        0.5),
                                                                useRadiusInMeter:
                                                                    true)
                                                          ],
                                                        ),
                                                        MarkerLayer(
                                                          markers: [
                                                            Marker(
                                                              point: LatLng(
                                                                  stateOnboarding
                                                                      .restaurant!
                                                                      .lat!,
                                                                  stateOnboarding
                                                                      .restaurant!
                                                                      .lng!),
                                                              child: const Icon(
                                                                Icons.place,
                                                                size: 32,
                                                                color:
                                                                    Colors.red,
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ],
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
                                                  const SizedBox(
                                                    height: 16,
                                                  ),
                                                  MeloUITextField(
                                                    label:
                                                        'Raio máximo de entrega em KM',
                                                    placeholder: 'Ex: 10 km',
                                                    controller: state
                                                        .distanceDeliveryController,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    onChanged: (value) {
                                                      if (value != null) {
                                                        _bloc.distanceDelivery =
                                                            value.isEmpty
                                                                ? 0
                                                                : double.parse(
                                                                    value);
                                                      }
                                                    },
                                                  ),
                                                  MeloUITextField(
                                                    label: 'Preço por KM',
                                                    placeholder: 'Ex: R\$ 9,99',
                                                    controller: state
                                                        .distancePriceController,
                                                    observationText:
                                                        'Atenção: O valor total após o cálculo será arredondado para cima. (Ex: R\$ 4,49 vai virar R\$ 5,00)',
                                                    formatters: [
                                                      FilteringTextInputFormatter
                                                          .digitsOnly,
                                                      CentavosInputFormatter(
                                                          moeda: true)
                                                    ],
                                                  ),
                                                  MeloUITextField(
                                                    label:
                                                        'Cobrar a partir do KM',
                                                    placeholder:
                                                        'Digite o complemento',
                                                    controller: state
                                                        .distanceStartController,
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
                                                                  _bloc
                                                                      .saveSettingsDistance(stateOnboarding
                                                                          .restaurant!
                                                                          .id)
                                                                      .then(
                                                                          (value) {});
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

import 'package:brasil_fields/brasil_fields.dart';
import 'package:eatagain/app/commons/blocs/sidebar/sidebar_cubit.dart';
import 'package:eatagain/app/commons/infra/models/address_model.dart';
import 'package:eatagain/app/commons/widgets/custom_card_with_icon.dart';
import 'package:eatagain/app/commons/widgets/dialogs/select_address_map_dialog.dart';
import 'package:eatagain/app/commons/widgets/map_widget.dart';
import 'package:eatagain/app/commons/widgets/toggle_button_widget.dart';
import 'package:eatagain/app/core/restaurant_settings/presenter/blocs/restaurant_settings/restaurant_settings_cubit.dart';
import 'package:eatagain/app/core/working_days/presenter/blocs/working_days/working_days_cubit.dart';
import 'package:eatagain/app/core/working_days/presenter/widgets/working_day_card.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:melo_ui/melo_ui.dart';

class RestaurantSettingsPage extends StatefulWidget {
  const RestaurantSettingsPage({super.key});

  @override
  State<RestaurantSettingsPage> createState() => _RestaurantSettingsPageState();
}

class _RestaurantSettingsPageState extends State<RestaurantSettingsPage> {
  final _sidebarBloc = Modular.get<SidebarCubit>();
  final _bloc = Modular.get<RestaurantSettingsCubit>();
  @override
  void initState() {
    super.initState();
    _bloc.getRestaurantById();
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
              child: BlocBuilder<RestaurantSettingsCubit,
                      RestaurantSettingsState>(
                  bloc: _bloc,
                  builder: (context, state) {
                    if (state.isLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (state.failedError != null) {
                      return Center(
                        child:
                            Text(state.failedError ?? "Falha ao restaurante"),
                      );
                    }
                    return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 16),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MeloUICard(
                                  width: double.infinity,
                                  height: 470,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const MeloUIText(
                                        'Configurações',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 24),
                                      ),
                                      const Divider(),
                                      MeloUITextField(
                                          label: 'Nome',
                                          placeholder:
                                              'Digite o nome do restaurante',
                                          controller: state.nameController),
                                      MeloUITextField(
                                          label: 'CNPJ',
                                          placeholder:
                                              'Digite o CNPJ do restaurante',
                                          controller: state.cnpjController,
                                          formatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                            CnpjInputFormatter()
                                          ]),
                                      MeloUITextField(
                                          label: 'Telefone',
                                          placeholder:
                                              'Digite o telefone do restaurante',
                                          controller: state.phoneController,
                                          formatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                            TelefoneInputFormatter()
                                          ]),
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
                                    ],
                                  )),
                              const SizedBox(
                                height: 16,
                              ),
                              MeloUICard(
                                  width: double.infinity,
                                  height: 500,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const MeloUIText(
                                        'Configurações de entrega',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 24),
                                      ),
                                      const Divider(),
                                      Expanded(
                                          child: Row(
                                        children: [
                                          Expanded(
                                              child: Column(
                                            children: [
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
                                                    _bloc.activeDistanceDelivery =
                                                        value.isEmpty
                                                            ? 0
                                                            : int.parse(value);
                                                  }
                                                },
                                              ),
                                              MeloUITextField(
                                                label: 'Preço por KM',
                                                placeholder: 'Ex: R\$ 9,99',
                                                controller: state
                                                    .distancePriceController,
                                                keyboardType:
                                                    TextInputType.number,
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
                                                label: 'Cobrar a partir do KM',
                                                placeholder:
                                                    'Digite o km que deve começar a cobrar',
                                                keyboardType:
                                                    TextInputType.number,
                                                controller: state
                                                    .distanceStartController,
                                                formatters: [
                                                  FilteringTextInputFormatter
                                                      .digitsOnly,
                                                ],
                                              ),
                                            ],
                                          )),
                                          if (state.activeAddress != null)
                                            Container(
                                                width: 400,
                                                margin: const EdgeInsets.only(
                                                    left: 16),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: const Color(
                                                            0xFFC4C4C4)),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16)),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                  child: MapWidget(
                                                    controller: state
                                                        .mapDeliveryController,
                                                    center: MapWidgetMarker(
                                                        latitude: state
                                                            .activeAddress!
                                                            .latitude,
                                                        longitude: state
                                                            .activeAddress!
                                                            .longitude),
                                                    zoom: 12,
                                                    circles: [
                                                      MapWidgetCircle(
                                                          latitude: state
                                                              .activeAddress!
                                                              .latitude,
                                                          longitude: state
                                                              .activeAddress!
                                                              .longitude,
                                                          radius:
                                                              (state.activeDistanceDelivery ??
                                                                      0) *
                                                                  1000,
                                                          color: Colors.red
                                                              .withOpacity(0.5),
                                                          useRadiusInMeter:
                                                              true)
                                                    ],
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
                                                              Icons.location_on,
                                                              size: 48,
                                                              color: Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .primary)),
                                                    ],
                                                  ),
                                                )),
                                        ],
                                      )),
                                      Row(
                                        children: [
                                          const Spacer(),
                                          MeloUIButton(
                                              width: 350,
                                              height: 48,
                                              title: 'Salvar',
                                              isLoading: state.isBusy,
                                              onPressed:
                                                  _bloc.saveDeliverySettings),
                                        ],
                                      ),
                                    ],
                                  )),
                              const SizedBox(
                                height: 16,
                              ),
                              MeloUICard(
                                  width: double.infinity,
                                  height: 605,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const MeloUIText(
                                        'Configurações do endereço',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 24),
                                      ),
                                      const Divider(),
                                      Expanded(
                                          child: Row(
                                        children: [
                                          if (state.activeAddress != null)
                                            Container(
                                                width: 400,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: const Color(
                                                            0xFFC4C4C4)),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16)),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                  child: MapWidget(
                                                    controller: state
                                                        .mapAddressController,
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
                                                              Icons.location_on,
                                                              size: 48,
                                                              color: Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .primary)),
                                                    ],
                                                  ),
                                                )),
                                          const SizedBox(
                                            width: 32,
                                          ),
                                          Expanded(
                                            child: Column(children: [
                                              state.activeAddress == null
                                                  ? MeloUIButton(
                                                      title:
                                                          'Cadastrar endereço',
                                                      onPressed: () {
                                                        showDialog<
                                                            AddressModel?>(
                                                          context: context,
                                                          builder: (context) =>
                                                              const SelectAddressMapDialog(
                                                                  latitude:
                                                                      -9.66625,
                                                                  longitude:
                                                                      -35.7351),
                                                        ).then((value) {
                                                          if (value != null) {
                                                            _bloc
                                                                .handleChangeAddress(
                                                                    value);
                                                          }
                                                        });
                                                      })
                                                  : CustomCardWithIcon(
                                                      height: 140,
                                                      icon: Icons.place,
                                                      title:
                                                          'Endereço escolhido',
                                                      subTitle: state
                                                              .activeAddress
                                                              ?.formatted ??
                                                          "",
                                                      border: Border.all(
                                                          color: Colors.grey),
                                                      suffixIcon: IconButton(
                                                          onPressed: () {
                                                            showDialog<
                                                                AddressModel?>(
                                                              context: context,
                                                              builder: (context) => SelectAddressMapDialog(
                                                                  latitude: state
                                                                      .activeAddress!
                                                                      .latitude,
                                                                  longitude: state
                                                                      .activeAddress!
                                                                      .longitude),
                                                            ).then((value) {
                                                              if (value !=
                                                                  null) {
                                                                _bloc
                                                                    .handleChangeAddress(
                                                                        value);
                                                              }
                                                            });
                                                          },
                                                          icon: const Icon(
                                                              Icons.edit)),
                                                    ),
                                              MeloUITextField(
                                                label: 'Número',
                                                placeholder: 'Digite o número',
                                                controller:
                                                    state.numberController,
                                                keyboardType:
                                                    TextInputType.number,
                                              ),
                                              MeloUITextField(
                                                label: 'Ponto de referência',
                                                placeholder:
                                                    'Digite o ponto de referência',
                                                controller:
                                                    state.referenceController,
                                              ),
                                              MeloUITextField(
                                                label: 'Complemento',
                                                placeholder:
                                                    'Digite o complemento',
                                                controller:
                                                    state.complementController,
                                              ),
                                            ]),
                                          ),
                                        ],
                                      )),
                                      Row(
                                        children: [
                                          const Spacer(),
                                          MeloUIButton(
                                              width: 350,
                                              height: 48,
                                              title: 'Salvar',
                                              isLoading: state.isBusy,
                                              onPressed: _bloc.saveAddress),
                                        ],
                                      ),
                                    ],
                                  )),
                              const SizedBox(
                                height: 80,
                              )
                            ],
                          ),
                        ));
                  }))
        ],
      ),
    );
  }
}

import 'package:brasil_fields/brasil_fields.dart';
import 'package:eatagain/app/core/onboarding/presenter/blocs/onboarding/onboarding_cubit.dart';
import 'package:eatagain/app/core/onboarding/presenter/blocs/onboarding_data/onboarding_data_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:melo_ui/melo_ui.dart';

import '../../../../../commons/widgets/step_progress_v2.dart';
import '../widgets/onboarding_appbar.dart';

class OnboardingDataWebPage extends StatefulWidget {
  const OnboardingDataWebPage({super.key});

  @override
  State<OnboardingDataWebPage> createState() => _OnboardingDataWebPageState();
}

class _OnboardingDataWebPageState extends State<OnboardingDataWebPage> {
  final _blocOnboarding = Modular.get<OnboardingCubit>();
  final _bloc = Modular.get<OnboardingDataCubit>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const AppBarTitle()),
      body: Padding(
        padding: EdgeInsets.all(context.height * 0.05),
        child: BlocBuilder<OnboardingCubit, OnboardingState>(
            bloc: _blocOnboarding,
            builder: (context, stateOnboarding) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(top: context.height * 0.05),
                      decoration: BoxDecoration(border: Border.all()),
                      child: BlocBuilder<OnboardingDataCubit,
                              OnboardingDataState>(
                          bloc: _bloc,
                          builder: (context, state) {
                            return Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    margin: const EdgeInsets.all(50),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          StepProgressv2(
                                            height: context.height * 0.04,
                                            currentStep:
                                                stateOnboarding.currentStep + 1,
                                            steps: stateOnboarding.steps,
                                          ),
                                          Container(
                                            width: context.width * 0.07,
                                            height: context.height * 0.12,
                                            margin: const EdgeInsets.only(
                                                bottom: 16),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: const Color(
                                                        0xFFC4C4C4)),
                                                borderRadius:
                                                    BorderRadius.circular(16)),
                                            child: InkWell(
                                              onTap: () {
                                                _bloc.pickImage();
                                              },
                                              child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                  child: state.image != null
                                                      ? Image.network(
                                                          state.image!.path)
                                                      : stateOnboarding
                                                                      .restaurant !=
                                                                  null &&
                                                              stateOnboarding
                                                                      .restaurant!
                                                                      .photo !=
                                                                  null
                                                          ? Image.network(
                                                              stateOnboarding
                                                                  .restaurant!
                                                                  .photo!)
                                                          : Image.asset(
                                                              fit: BoxFit.fill,
                                                              'assets/no_image.jpg')),
                                            ),
                                          ),
                                          MeloUITextField(
                                            label: 'Nome',
                                            placeholder:
                                                'Digite o nome do restaurante',
                                            controller: state.nameController,
                                            error: state.errors
                                                .getFirstErrorByKey('name'),
                                          ),
                                          MeloUITextField(
                                              label: 'CNPJ',
                                              placeholder:
                                                  'Digite o CNPJ do restaurante',
                                              controller: state.documentController,
                                              error: state.errors.getFirstErrorByKey('document'),
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
                                            error: state.errors
                                                .getFirstErrorByKey('phone'),
                                            formatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly,
                                              TelefoneInputFormatter()
                                            ],
                                          ),
                                          const Spacer(),
                                          SizedBox(
                                            height: context.height * 0.1,
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
                                                        isLoading: state.isBusy,
                                                        title: 'Continuar',
                                                        onPressed: () {
                                                          _bloc
                                                              .save()
                                                              .then((value) {
                                                            if (value != null) {
                                                              _blocOnboarding
                                                                  .saveRestaurant(
                                                                      value);
                                                            }
                                                          });
                                                        })),
                                              ],
                                            ),
                                          )
                                        ]),
                                  ),
                                ),
                                Expanded(
                                    flex: 3,
                                    child: Container(
                                      decoration:
                                          BoxDecoration(color: Colors.green),
                                    ))
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

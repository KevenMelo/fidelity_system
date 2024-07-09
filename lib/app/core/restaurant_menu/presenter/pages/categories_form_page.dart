import 'package:eatagain/app/commons/blocs/sidebar/sidebar_cubit.dart';
import 'package:eatagain/app/core/restaurant_menu/presenter/blocs/categories_form/categories_form_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:melo_ui/melo_ui.dart';

import '../../infra/models/complement_type.dart';
import '../widgets/complements_card.dart';

class CategoriesFormPage extends StatefulWidget {
  const CategoriesFormPage({super.key, this.id});
  final String? id;
  @override
  State<CategoriesFormPage> createState() => _CategoriesFormPageState();
}

class _CategoriesFormPageState extends State<CategoriesFormPage> {
  final _sidebarBloc = Modular.get<SidebarCubit>();
  final _bloc = Modular.get<CategoriesFormCubit>();

  @override
  void initState() {
    super.initState();
    _bloc.getCategoryById(widget.id);
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
          child: BlocConsumer<CategoriesFormCubit, CategoriesFormState>(
              bloc: _bloc,
              listener: (context, state) {
                if (state.error != null) {
                  DialogHelp.error(
                      title: 'Ocorreu um erro',
                      message:
                          state.error ?? 'Erro Desconhecido\nTente novamente',
                      context: context);
                }
              },
              builder: (context, state) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
                  child: MeloUICard(
                    width: double.infinity,
                    height: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                  iconSize: 48,
                                  onPressed: _bloc.handleClickNavigateBack,
                                  icon: const Icon(
                                      Icons.navigate_before_rounded)),
                              const SizedBox(
                                width: 16,
                              ),
                              const MeloUIText(
                                'Cadastre a categoria',
                                style: TextStyle(fontSize: 32),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 22,
                          ),
                          MeloUITextField(
                            label: 'Nome da categoria',
                            placeholder: 'Digite o nome da categoria',
                            controller: state.nameController,
                            error: state.errors.getFirstErrorByKey('name'),
                          ),
                          const Divider(),
                          // const SizedBox(
                          //   height: 16,
                          // ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: PageView(
                                controller: state.pageController,
                                children: [
                                  Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const MeloUIText(
                                          'Selecione o modelo de complemento',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 16,
                                        ),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              ComplementsCard(
                                                isActive:
                                                    state.complementType ==
                                                        ComplementType.custom,
                                                onTap: () {
                                                  _bloc
                                                      .handleSelectComplementType(
                                                          ComplementType
                                                              .custom);
                                                },
                                                label: 'Itens Customizáveis',
                                                icon: MdiIcons
                                                    .silverwareForkKnife,
                                              ),
                                              const SizedBox(
                                                width: 16,
                                              ),
                                              ComplementsCard(
                                                  isActive:
                                                      state.complementType ==
                                                          ComplementType.berry,
                                                  onTap: () {
                                                    _bloc
                                                        .handleSelectComplementType(
                                                            ComplementType
                                                                .berry);
                                                  },
                                                  label: 'Açaí',
                                                  icon: MdiIcons.bowlMix),
                                              const SizedBox(
                                                width: 16,
                                              ),
                                              ComplementsCard(
                                                  isActive:
                                                      state.complementType ==
                                                          ComplementType.pizza,
                                                  onTap: () {
                                                    _bloc
                                                        .handleSelectComplementType(
                                                            ComplementType
                                                                .pizza);
                                                  },
                                                  label: 'Pizza',
                                                  icon: MdiIcons.pizza),
                                            ])
                                      ]),
                                  Column(children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        IconButton(
                                            iconSize: 48,
                                            onPressed:
                                                _bloc.unSelectComplementType,
                                            icon: const Icon(
                                                Icons.navigate_before_rounded)),
                                        const MeloUIText(
                                          'Complementos da categoria',
                                          style: TextStyle(fontSize: 32),
                                        ),
                                        const SizedBox.shrink()
                                      ],
                                    ),
                                    Expanded(
                                        child: Column(
                                      children: [
                                        const SizedBox(
                                          height: 16,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Expanded(
                                              child: MeloUITextField(
                                                label: 'Nome do complemento',
                                                placeholder:
                                                    'Digite o nome do complemento',
                                                controller: state
                                                    .nameComplementController,
                                                margin: EdgeInsets.zero,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 16,
                                            ),
                                            MeloUIButton(
                                                width: 220,
                                                height: 48,
                                                margin: EdgeInsets.zero,
                                                title: 'Adicionar',
                                                onPressed: _bloc
                                                    .handleClickAddComplement)
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 16,
                                        ),
                                        Expanded(
                                            child: Container(
                                          padding: const EdgeInsets.all(16),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              border: Border.all(
                                                  color:
                                                      const Color(0xFFC4C4C4))),
                                          child: ReorderableListView.builder(
                                            itemBuilder: (context, index) =>
                                                ListTile(
                                                    key: Key(index.toString()),
                                                    leading: IconButton(
                                                        onPressed: () {
                                                          _bloc
                                                              .handleClickDeleteComplement(
                                                                  index);
                                                        },
                                                        icon: const Icon(
                                                            Icons.delete)),
                                                    title: Text(state
                                                        .complements[index]
                                                        .name)),
                                            itemCount: state.complements.length,
                                            onReorder:
                                                _bloc.handleReorderComplements,
                                          ),
                                        ))
                                      ],
                                    )),
                                    Row(
                                      children: [
                                        if (state.complements.isNotEmpty) ...{
                                          Row(children: [
                                            MeloUIText(
                                              '(${state.complements.length}) ',
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const MeloUIText(
                                              'Complementos adicionados',
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                          ])
                                        },
                                        const Spacer(),
                                        MeloUIButton(
                                            width: 240,
                                            height: 48,
                                            isLoading: state.isBusy,
                                            title: 'Criar categoria',
                                            onPressed: _bloc.save),
                                      ],
                                    )
                                  ])
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }))
    ]));
  }
}

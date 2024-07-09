import 'package:eatagain/app/commons/blocs/sidebar/sidebar_cubit.dart';
import 'package:eatagain/app/commons/widgets/toggle_button_widget.dart';
import 'package:eatagain/app/core/working_days/infra/extensions/day_extension.dart';
import 'package:eatagain/app/core/working_days/presenter/blocs/working_days/working_days_cubit.dart';
import 'package:eatagain/app/core/working_days/presenter/widgets/working_day_card.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:melo_ui/melo_ui.dart';

class WorkingDaysPage extends StatefulWidget {
  const WorkingDaysPage({super.key});

  @override
  State<WorkingDaysPage> createState() => _WorkingDaysPageState();
}

class _WorkingDaysPageState extends State<WorkingDaysPage> {
  final _sidebarBloc = Modular.get<SidebarCubit>();
  final _bloc = Modular.get<WorkingDaysCubit>();

  @override
  void initState() {
    super.initState();
    _bloc.getWorkingDays();
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
              child: BlocBuilder<WorkingDaysCubit, WorkingDaysState>(
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
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const MeloUIText(
                                      'Configurações',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 24),
                                    ),
                                    const Divider(),
                                    ToggleButtonWidget(
                                      label: 'Aberto',
                                      value: state.isOpened,
                                      onChanged: _bloc.handleChangeIsOpened,
                                    ),
                                    const Spacer(),
                                    Row(
                                      children: [
                                        Checkbox(
                                            value: state.isOpenProgramally,
                                            activeColor:
                                                Theme.of(context).primaryColor,
                                            onChanged: _bloc
                                                .handleChangeIsOpenProgramally),
                                        const MeloUIText(
                                            'Abrir automáticamente'),
                                      ],
                                    ),
                                  ],
                                )),
                            const SizedBox(
                              height: 16,
                            ),
                            const MeloUIText(
                              'Horários de funcionamento',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 24),
                            ),
                            const Divider(),
                            Expanded(
                              child: GridView.builder(
                                itemCount: state.days.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        childAspectRatio: 3,
                                        crossAxisSpacing: 16,
                                        mainAxisSpacing: 16),
                                itemBuilder: (context, index) => WorkingDayCard(
                                  workingDay: state.days[index],
                                  onChangedNotOpen: (value) =>
                                      _bloc.handleChangeNotOpen(index, value),
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

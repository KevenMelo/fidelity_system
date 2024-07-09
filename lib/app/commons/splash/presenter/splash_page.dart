import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:melo_ui/melo_ui.dart';

import '../blocs/splash/splash_cubit.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final _bloc = Modular.get<SplashCubit>();
  @override
  void initState() {
    super.initState();
    _bloc.isAuthenticated();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: BlocBuilder<SplashCubit, SplashState>(
            bloc: _bloc,
            builder: (context, state) {
              if (state.error != null) {
                return Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const MeloUIText("Alguma falha aconteceu",
                            style: TextStyle(fontSize: 24)),
                        const SizedBox(
                          height: 16,
                        ),
                        MeloUIText(
                          state.error!,
                          style: const TextStyle(fontSize: 16),
                        )
                      ]),
                );
              }
              return Center(
                  child: SizedBox(
                      width: size.width * 0.6,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MeloUILogo(
                            child: Image.asset('assets/logo.png'),
                          ),
                          if (state.isLoading)
                            Container(
                                margin: const EdgeInsets.only(top: 16),
                                child: const CircularProgressIndicator()),
                        ],
                      )));
            }));
  }
}

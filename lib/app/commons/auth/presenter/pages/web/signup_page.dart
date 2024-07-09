import 'package:awesome_icons/awesome_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:melo_ui/melo_ui.dart';

import '../../blocs/signup/signup_cubit.dart';

class SignUpWebPage extends StatefulWidget {
  const SignUpWebPage({super.key});

  @override
  State<SignUpWebPage> createState() => _SignUpWebPageState();
}

class _SignUpWebPageState extends State<SignUpWebPage> {
  final _bloc = Modular.get<SignUpCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        body: Row(children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.25,
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: BlocBuilder<SignUpCubit, SignUpState>(
                  bloc: _bloc,
                  builder: (context, state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.arrow_back)),
                        const Spacer(),
                        const MeloUIText(
                          "Crie sua conta agora :)",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const MeloUIText(
                          "E comece a fidelizar cada cliente",
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        MeloUITextField(
                          label: 'Nome',
                          placeholder: 'Digite o seu nome',
                          error: state.errors
                              .getFirstErrorByKey('name')
                              ?.replaceAll('name', 'nome'),
                          controller: state.nameController,
                          isDense: false,
                          contentPadding: const EdgeInsets.all(16),
                        ),
                        MeloUITextField(
                          label: 'E-mail',
                          placeholder: 'Digite o seu e-mail',
                          error: state.errors.getFirstErrorByKey('email'),
                          controller: state.emailController,
                          isDense: false,
                          contentPadding: const EdgeInsets.all(16),
                        ),
                        MeloUITextField(
                          label: 'Senha',
                          placeholder: 'Digite a sua senha',
                          isPassword: true,
                          controller: state.passwordController,
                          error: state.errors
                              .getFirstErrorByKey('password')
                              ?.replaceAll('password', 'senha'),
                          isDense: false,
                          contentPadding: const EdgeInsets.all(16),
                        ),
                        MeloUIButton(
                            margin: const EdgeInsets.only(top: 8, bottom: 16),
                            height: 40,
                            title: 'Criar conta',
                            isLoading: state.isBusy,
                            onPressed: _bloc.createUserWithEmailAndPassword),
                        const Divider(),
                        MeloUIButton(
                            variant: MeloUIButtonVariant.outlined,
                            margin: const EdgeInsets.only(top: 8, bottom: 16),
                            height: 40,
                            icon: FontAwesomeIcons.google,
                            title: 'Entrar com google',
                            isLoading: state.isBusy,
                            onPressed: () {}),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const MeloUIText("Esqueceu sua senha?"),
                            TextButton(
                                onPressed: () {},
                                child: const Text("Clique aqui")),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Center(
                          child: TextButton(
                              onPressed: () {},
                              child:
                                  const Text("Já tem uma conta? Acesse agora")),
                        ),
                        const Spacer(),
                      ],
                    );
                  }),
            ),
          ),
          Expanded(
              child: Container(
            padding: const EdgeInsets.all(16),
            color: Theme.of(context).colorScheme.primary,
            height: double.infinity,
            child: Center(
              child: SizedBox(
                  width: 400,
                  height: 400,
                  child: SvgPicture.asset('assets/restaurant.svg')),
            ),
          )),
        ]));
  }
}

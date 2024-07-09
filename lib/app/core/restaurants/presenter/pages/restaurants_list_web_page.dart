import 'package:eatagain/app/core/restaurants/presenter/blocs/restaurants_list/restaurants_list_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:melo_ui/melo_ui.dart';

class RestaurantsListWebPage extends StatefulWidget {
  const RestaurantsListWebPage({super.key});

  @override
  State<RestaurantsListWebPage> createState() => _RestaurantsListWebPageState();
}

class _RestaurantsListWebPageState extends State<RestaurantsListWebPage> {
  final _bloc = Modular.get<RestaurantsListCubit>();

  @override
  void initState() {
    super.initState();
    _bloc.getRestaurants();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<RestaurantsListCubit, RestaurantsListState>(
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
                    Text(state.failedError ?? "Falha ao buscar restaurantes"),
              );
            }
            return Center(
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(180),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: MeloUIText(
                          "Restaurantes",
                          style: TextStyle(fontSize: 32),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Expanded(
                          child: Wrap(
                        children: state.restaurants
                            .map((restaurant) => InkWell(
                                  onTap: () {
                                    _bloc.selectRestaurant(restaurant);
                                  },
                                  borderRadius: BorderRadius.circular(32),
                                  child: Container(
                                      width: 300,
                                      height: 200,
                                      margin: const EdgeInsets.only(right: 16),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(32),
                                        color: Colors.white,
                                      ),
                                      padding: const EdgeInsets.all(48),
                                      child: Column(
                                        children: [
                                          MeloUIText(restaurant.name),
                                        ],
                                      )),
                                ))
                            .toList(),
                      ))
                    ]),
              ),
            );
          }),
    );
  }
}

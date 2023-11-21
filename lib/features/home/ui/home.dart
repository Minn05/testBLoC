import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/features/home/bloc/home_bloc.dart';
import 'package:test/features/home/ui/product_tile_widget.dart';
import 'package:test/features/wishlist/ui/wishlist.dart';

import '../../cart/ui/cart.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  final HomeBloc homeBloc = HomeBloc();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is HomeNavigateToCartPageActionSate) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const Cart()));
        } else if (state is HomeNavigateToWishListPageActionSate) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const WishList()));
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadingState:
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );

          case HomeLoadedSuccessState:
            final successState = state as HomeLoadedSuccessState;
            return Scaffold(
              appBar: AppBar(
                backgroundColor: const Color.fromARGB(255, 68, 224, 255),
                title: const Text('Demo BLoC'),
                centerTitle: true,
                actions: [
                  //WishList
                  IconButton(
                      onPressed: () {
                        homeBloc.add(HomeWishlistButtonNavigateEvent());
                      },
                      icon: const Icon(Icons.favorite_border)),
                  //Cart
                  IconButton(
                      onPressed: () {
                        homeBloc.add(HomeCartButtonNavigateEvent());
                      },
                      icon: const Icon(Icons.shopping_bag_outlined)),
                ],
              ),
              body: ListView.builder(
                itemCount: successState.products.length,
                itemBuilder: (context, index) {
                return ProDuctTileWidget(
                    productModel: successState.products[index]);
              }),
            );
          case HomeErrorState:
            return const Scaffold(
              body: Center(child: Text('Error')),
            );
          default:
            return const SizedBox();
        }
      },
    );
  }
}

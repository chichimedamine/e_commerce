import 'package:e_commerce/views/CartDetail.dart';
import 'package:e_commerce/views/Home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../bloc/cart/index.dart';
import '../helper/ColorsHelper.dart';
import '../helper/FontsHelper.dart';

class Index extends StatefulWidget {
  const Index({super.key});

  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> {
  int currentIndex = 0;
  List<Widget> screens = [
    const HomePage(),
    const CartDetail(),
    const HomePage(),
    const HomePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle: FontsHelper.bodySmall(
            color: ColorsHelper.black, weight: FontWeight.bold),
        backgroundColor: ColorsHelper.gray200,
        selectedItemColor: ColorsHelper.black,
        unselectedItemColor: ColorsHelper.gray400,
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
            switch (index) {
              case 0:
                break;
              case 1:
                break;
              case 2:

                ///   context.read<CartBloc>().add(ResetCount());
                break;
              case 3:
                break;
            }
          });
        },
        items: [
          const BottomNavigationBarItem(
            icon: Icon(LucideIcons.house),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Stack(
              children: [
                const Icon(LucideIcons.shoppingCart),
                Positioned(
                  top: 0,
                  right: 0,
                  child: BlocBuilder<CartBloc, CartState>(
                    builder: (context, state) {
                        print("state counter now is $state");
                      if (state is CartLoaded || state is CountUpdated) {
                      
                        return NewItemCartCounter(state);
                      }else if(state is CartEmpty){
                        return const SizedBox();
                      }

                      return const SizedBox();
                    },
                  ),
                ),
              ],
            ),
            label: 'Cart',
          ),
         
        ],
      ),
      body: screens[currentIndex],
    );
  }
}

Widget NewItemCartCounter(dynamic state) {
  return Container(
    padding: const EdgeInsets.symmetric(
      horizontal: 4,
      vertical: 1,
    ),
    decoration: const BoxDecoration(
      color: ColorsHelper.red,
      borderRadius: BorderRadius.all(
        Radius.circular(6),
      ),
    ),
    constraints: const BoxConstraints(
      minWidth: 16,
      minHeight: 16,
    ),
    child: Text(
      '${state.count}',
      style: FontsHelper.bodySmall(
        color: ColorsHelper.white,
        weight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    ),
  );
}

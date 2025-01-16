import 'package:e_commerce/helper/ColorsHelper.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../bloc/cart/index.dart';
import '../helper/FontsHelper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../hive/productincart.dart';



class CountCartButton extends StatelessWidget {
  int CartId;
  int productId;
  List<ProductInCart> products = [];

  int minCount;
  int maxCount;
  int initialCount;
  double height;
  double width;

  CountCartButton({
    super.key,
    required this.CartId,
    required this.products,
    required this.productId,
    required this.minCount,
    required this.maxCount,
    required this.initialCount,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: ColorsHelper.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.black,
            blurRadius: 30,
            offset: Offset(0, 3),
          ),
        ],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: ColorsHelper.gray300),
      ),
      child: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          initialCount;
          if (state is CartLoaded || state is CartUpdated) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    if (initialCount > minCount) {
                      initialCount--;

                      context.read<CartBloc>().add(UpdateProductQuantity(
                          CartId, products, productId, initialCount));
                    }
                    
                  },
                  icon: const Icon(
                    LucideIcons.minus,
                    color: ColorsHelper.black,
                    size: 15,
                  ),
                ),
                Text(
                  "$initialCount",
                  style: FontsHelper.bodySmall(
                    weight: FontWeight.bold,
                    color: ColorsHelper.black,
                    height: 1,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    if (initialCount < maxCount) {
                      initialCount++;
                      context.read<CartBloc>().add(UpdateProductQuantity(
                          CartId, products, productId, initialCount));
                    }
                  },
                  icon: const Icon(
                    LucideIcons.plus,
                    color: ColorsHelper.black,
                    size: 15,
                  ),
                ),
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}

import 'package:e_commerce/helper/ColorsHelper.dart';
import 'package:e_commerce/hive/product.dart';
import 'package:e_commerce/hive/productincart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../bloc/Product/index.dart';
import '../bloc/cart/index.dart';
import '../component/count_button.dart';
import '../helper/FontsHelper.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../hive/cart.dart';



class Productview extends StatefulWidget {
  final int id;

  const Productview({super.key, required this.id});

  @override
  State<Productview> createState() => _ProductviewState();
}

class _ProductviewState extends State<Productview> {
  final int quantity = 1;
  @override
  void initState() {
    super.initState();
    // Initialize any required state here
  }

  @override
  void dispose() {
    // Dispose of any controllers or resources here
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProductBloc(const UnProductState())
        ..add(LoadingSingleProductEvent(id: widget.id)),
      child: Scaffold(
        bottomNavigationBar: _buildBottombar(),
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: ColorsHelper.gray200,
              title: Text(
                'Product Details',
                style: FontsHelper.bodyLarge(
                    color: Colors.black,
                    height: 1.5,
                    fontWeight: FontWeight.normal),
              ),
              floating: true,
              // Additional SliverAppBar properties
            ),
            _buildBody(),
          ],
        ),
      ),
    );
  }

  Widget _buildBottombar() {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is LoadingSingleProductState) {
          return const SizedBox();
        } else if (state is LoadedSingleProductState) {
          return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              " \$ ${state.product.price.toString()}",
              style: FontsHelper.bodySmall(
                  color: Colors.black, height: 1, weight: FontWeight.bold),
            ),
            const SizedBox(
              width: 10,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorsHelper.black,
              ),
              onPressed: () {
                context.read<CartBloc>().add(AddToCartEvent(
                      cart: Cart(userId: 1, date: DateTime.now(), products: [
                        ProductInCart(
                            id: state.product.id,
                            title: state.product.title,
                            price: state.product.price,
                            description: state.product.description,
                            category: state.product.category,
                            image: state.product.image,
                            rating: state.product.rating,
                            quantity: quantity),
                      ]),
                    ));
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text(
                        "Product added to cart",
                        style: FontsHelper.bodySmall(
                            color: Colors.white,
                            height: 1,
                            weight: FontWeight.bold),
                      ),
                      duration: const Duration(seconds: 2)),
                );
              },
              child: Row(
                children: [
                  const Icon(LucideIcons.shoppingCart, color: Colors.white),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Add to Cart",
                    style: FontsHelper.bodySmall(
                        color: Colors.white,
                        height: 1,
                        weight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            CountButton(
              width: 110,
              height: 30,
              initialCount: quantity,
              minCount: 1,
              maxCount: 25,
            ),
          ]);
        }

        return const SizedBox();
      },
    );
  }

  Widget _buildBody() {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is LoadingSingleProductState) {
          return SliverFillRemaining(
            child: Center(
              child: LoadingAnimationWidget.staggeredDotsWave(
                color: ColorsHelper.gray200,
                size: 50,
              ),
            ),
          );
        } else if (state is LoadedSingleProductState) {
          return SliverToBoxAdapter(
            child: ProductItem(product: state.product),
          );
        }
        return const SliverFillRemaining(
          child: Center(child: Text('Failed to load product')),
        );
      },
    );
  }
}

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey, width: 1),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 30,
                      offset: Offset(0, 3),
                    ),
                  ],
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(product.image),
                    fit: BoxFit.fill,
                  ))),
          const SizedBox(
            height: 10,
          ),
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            color: Colors.grey[200],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  product.category,
                  style: FontsHelper.caption(
                      color: Colors.grey, height: 1.5, weight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Center(
            child: Text(
              product.title,
              style: FontsHelper.heading2(color: Colors.black, height: 1.5),
              textAlign: TextAlign.center,
            ),
          ),
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            color: Colors.grey[200],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(LucideIcons.star, color: Colors.black, size: 15),
                Text(
                  " ${product.rating.rate.toStringAsFixed(1)}",
                  style: FontsHelper.bodySmall(
                      color: Colors.black,
                      height: 1.5,
                      weight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  " ${product.rating.count.toString()} Reviews",
                  style: FontsHelper.bodySmall(
                      color: Colors.black,
                      height: 1.5,
                      weight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            color: Colors.grey[200],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(LucideIcons.box, color: Colors.black, size: 15),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "In Stock",
                  style: FontsHelper.bodyMedium(
                      color: Colors.black,
                      height: 1.5,
                      weight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            color: Colors.grey[200],
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    " ${product.description.toString()}",
                    style: FontsHelper.caption(),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

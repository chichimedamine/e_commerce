import 'package:e_commerce/helper/FontsHelper.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../bloc/cart/index.dart';
import '../component/countcartButton.dart';
import '../helper/ColorsHelper.dart';
import '../hive/productincart.dart';

class CartDetail extends StatefulWidget {
  const CartDetail({super.key});

  @override
  State<CartDetail> createState() => _CartDetailState();
}

class _CartDetailState extends State<CartDetail> with TickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller!);
  }

  void _addToCart() {
    // Your existing add to cart logic
    _controller!.forward(); // Start the animation
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  Widget _buildAnimation() {
    return FadeTransition(
      opacity: _animation ?? const AlwaysStoppedAnimation(0.0),
      child: const Icon(
        LucideIcons.shoppingCart,
        color: ColorsHelper.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: _buildbody(),
    );
  }
}

PreferredSizeWidget _buildAppbar() {
  return AppBar(
    leading: const SizedBox(),
    backgroundColor: ColorsHelper.gray200,
    title: Text(
      'Cart Details',
      style: FontsHelper.bodyLarge(
          color: Colors.black, height: 1.5, fontWeight: FontWeight.normal),
    ),
  );
}

Widget _buildbody() {
  return BlocProvider(
    create: (context) =>
        CartBloc(const UnCartState())..add(LoadCartEvent(userId: 1)),
    child: BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoading) {
          return Center(
            child: LoadingAnimationWidget.staggeredDotsWave(
              color: ColorsHelper.gray200,
              size: 30,
            ),
          );
        } else if (state is CartLoaded || state is CartUpdated) {
          return BodyCart(state: state);
        } else if (state is CartEmpty) {
          return Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                LucideIcons.box,
                size: 100,
              ),
              const SizedBox(height: 20),
              Text(
                'Cart is empty',
                style: FontsHelper.bodyMedium(weight: FontWeight.bold),
              ),
            ],
          ));
        }
        return const SizedBox();
      },
    ),
  );
}

class BodyCart extends StatelessWidget {
  dynamic state;
  BodyCart({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 300,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: state.data.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                    elevation: 5,
                    child: Column(children: [
                      for (var p in state.data[index].products!)
                        _buildCartItems(context, p!, index),
                      const SizedBox(height: 10),
                    ])),
              );
            },
          ),
        ),
        SizedBox(
            height: 60,
            child: Column(
              children: [
                ListTile(
                  title: Text(
                    'Total',
                    style: FontsHelper.bodyMedium(
                        color: ColorsHelper.gray400, weight: FontWeight.bold),
                  ),
                  trailing: Text(
                    '\$ ${state.totalprice.toStringAsFixed(2)} ',
                    style: FontsHelper.bodyMedium(weight: FontWeight.bold),
                  ),
                ),
              ],
            )),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorsHelper.black,
            ),
            onPressed: () {
              // BlocProvider.of<CartBloc>(context).add(CheckoutEvent());
              // Implement checkout functionality here
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _CartDetailState()._buildAnimation(),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  'Checkout',
                  style: FontsHelper.bodyMedium(
                      color: ColorsHelper.white, weight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

Widget _buildCartItems(
    BuildContext context, ProductInCart products, int index) {
  return StatefulBuilder(
    builder: (context, setState) {
      return Dismissible(
        key: Key(products.cartId.toString()),
        direction: DismissDirection.endToStart,
        onDismissed: (direction) {
        
            context.read<CartBloc>().add(RemoveFromCartEvent(index: index));
        
        },
        background: Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 20.0),
          color: Colors.red,
          child: const Icon(
            LucideIcons.trash2,
            color: Colors.white,
          ),
        ),
        child: ListTile(
          leading: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: CachedNetworkImageProvider(products.image),
                fit: BoxFit.fill,
              ),
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(30),
            ),
            height: 60,
            width: 60,
          ),
          title: Text(
            products.title,
            style: FontsHelper.bodyMedium(weight: FontWeight.bold),
          ),
          subtitle: CountCartButton(
              products: [products],
              CartId: products.cartId,
              productId: products.id,
              width: 10,
              height: 30,
              minCount: 1,
              maxCount: 20,
              initialCount: products.quantity!),
          trailing: Text(
            '\$ ${products.price}',
            style: FontsHelper.bodyMedium(weight: FontWeight.bold),
          ),
        ),
      );
    },
  );
}

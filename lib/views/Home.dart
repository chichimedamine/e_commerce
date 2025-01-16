import 'package:e_commerce/helper/ColorsHelper.dart';
import 'package:e_commerce/helper/FontsHelper.dart';
import 'package:e_commerce/hive/product.dart';
import 'package:e_commerce/views/Login.dart';
import 'package:e_commerce/views/ProductView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../bloc/Product/index.dart';
import '../bloc/home/index.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:cached_network_image/cached_network_image.dart';



class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      leading: const SizedBox(),
      backgroundColor: ColorsHelper.gray200,
      title: Text(
        'E-Commerce',
        style: FontsHelper.bodyLarge(
            color: Colors.black, height: 1.5, fontWeight: FontWeight.normal),
      ),
      actions: [
        IconButton(
          icon: const Icon(LucideIcons.search),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(LucideIcons.shoppingCart),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(LucideIcons.userRound),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginView()),
            );
          },
        ),
      ],
    );
  }

  Widget _buildBody() {
    String selectedCategory = 'All';
    return CustomScrollView(
      slivers: [
        _buildCategories(selectedCategory),
        _buildFeaturedProducts(selectedCategory),
        // _buildNewArrivals(),
      ],
    );
  }

  Widget _buildCategories(String selectedCategory) {
    List<String> categories = [];
    int selectedindex = 0;
    return StatefulBuilder(builder: (context, setState) {
      return BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is LoadedHomeState) {
            categories = ["All", ...state.categories];

            return SliverToBoxAdapter(
              child: SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            context.read<ProductBloc>().add(
                                  LoadProductEvent(
                                    category: categories[index],
                                  ),
                                );

                            selectedindex = index;
                            selectedCategory = categories[index];
                          });
                        },
                        child: Chip(
                          shape: const StadiumBorder(),
                          side: const BorderSide(color: ColorsHelper.gray300),
                          label: Text(
                            categories[index],
                            style: FontsHelper.bodySmall(
                              weight: FontWeight.bold,
                              color: index == selectedindex
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                          backgroundColor: index == selectedindex
                              ? ColorsHelper.gray200
                              : Colors.transparent,
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          }

          return SliverToBoxAdapter(
            child: Skeletonizer(
              enabled: true,
              child: SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 7,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: GestureDetector(
                        onTap: () {},
                        child: Chip(
                          label: Container(
                            width: 50,
                            height: 20,
                            color: Colors.grey[300],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      );
    });
  }

  Widget _buildFeaturedProducts(String selectedCategory) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        print("state now $state");
        if (state is LoadedProductState) {
          return SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16.0,
                crossAxisSpacing: 16.0,
                childAspectRatio: 0.75,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final product = state.Products[index];

                  return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Productview(
                              id: product.id,
                            ),
                          ),
                        );
                      },
                      child: _buildProductCard(product));
                },
                childCount: state.Products.length,
              ),
            ),
          );
        }
        return SliverFillRemaining(
          child: Center(
            child: LoadingAnimationWidget.staggeredDotsWave(
              color: ColorsHelper.gray200,
              size: 50,
            ),
          ),
        );
      },
    );
  }

  Widget _buildProductCard(Product product) {
    return Card(
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(4)),
              ),
              child: Center(
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  height: double.infinity,
                  width: double.infinity,
                  imageUrl: product.image,
                  placeholder: (context, url) =>
                      LoadingAnimationWidget.staggeredDotsWave(
                    color: ColorsHelper.gray200,
                    size: 50,
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title,
                  style: FontsHelper.bodySmall(),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Chip(
                  backgroundColor: ColorsHelper.black,
                  label: Text(
                    '\$${product.price}',
                    style: FontsHelper.bodyLarge(
                      color: ColorsHelper.gray200,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNewArrivals() {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'New Arrivals',
              style: FontsHelper.bodyLarge(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) {
                return Container(
                  width: 160,
                  margin: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Icon(
                      LucideIcons.image,
                      size: 40,
                      color: Colors.grey[400],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      backgroundColor: ColorsHelper.gray200,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(LucideIcons.house),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(LucideIcons.squareStack),
          label: 'Categories',
        ),
        BottomNavigationBarItem(
          icon: Icon(LucideIcons.heart),
          label: 'Wishlist',
        ),
        BottomNavigationBarItem(
          icon: Icon(LucideIcons.user),
          label: 'Profile',
        ),
      ],
    );
  }
}

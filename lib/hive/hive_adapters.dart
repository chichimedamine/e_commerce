import 'package:e_commerce/hive/product.dart';
import 'package:e_commerce/hive/productincart.dart';
import 'package:e_commerce/hive/rating.dart';
import 'package:hive_ce/hive.dart';

import 'cart.dart';

part 'hive_adapters.g.dart';

@GenerateAdapters([AdapterSpec<Cart>() , AdapterSpec<ProductInCart>() , AdapterSpec<Rating>() , AdapterSpec<Product>()])
// Annotations must be on some element
// ignore: unused_element
void _() {}
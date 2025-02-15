// Generated by Hive CE
// Do not modify
// Check in to version control

import 'package:hive_ce/hive.dart';
import 'package:e_commerce/hive/hive_adapters.dart';

extension HiveRegistrar on HiveInterface {
  void registerAdapters() {
    registerAdapter(CartAdapter());
    registerAdapter(ProductAdapter());
    registerAdapter(ProductInCartAdapter());
    registerAdapter(RatingAdapter());
  }
}

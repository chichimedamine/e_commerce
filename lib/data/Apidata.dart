import 'dart:convert';
import 'package:e_commerce/hive/product.dart';
import 'package:e_commerce/models/cartuser.dart';
import 'package:e_commerce/models/productIncart.dart';
import 'package:http/http.dart' as http;

import '../models/cart.dart';

import '../models/user.dart';



class ApiService {
  static const String baseUrl = 'https://fakestoreapi.com';

  Future<List<Product>> getAllProducts() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/products'));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<List<String>> getCategories() async {
    try {
      final response =
          await http.get(Uri.parse('$baseUrl/products/categories'));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((category) => category.toString()).toList();
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<List<Product>> getProductsByCategory(String category) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/products/category/$category'),
      );

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load products for category');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<ProductInCart> getProductByIdCart(int id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/products/$id'));

      if (response.statusCode == 200) {
        return ProductInCart.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load product');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<Product> getProductById(int id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/products/$id'));

      if (response.statusCode == 200) {
        return Product.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load product');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<List<Cart>> getCart() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/carts'));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((json) => Cart.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load cart');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<List<CartUser>> getUserCarts(int userId) async {
    print("userid $userId");
    final response = await http.get(Uri.parse('$baseUrl/carts/user/$userId'));

    if (response.statusCode == 200) {
      print(response.body);
      List<dynamic> data = json.decode(response.body);

      return data.map((json) => CartUser.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load user carts');
    }
  }

  Future<Cart> addToCart(int userId, int productId) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/carts'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'userId': userId,
          'date': '${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}',
          'products': [{'productId': productId, 'quantity': 1}],
          
        }),
      );

      if (response.statusCode == 200) {
        print("response body add to cart ${response.body}");
        return Cart.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to add to cart');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<Cart> updateCart(int cartId, int productId, int quantity) async {
    try {
      final response = await http.patch(
        Uri.parse('$baseUrl/carts/$cartId'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'userId': 1,
          'date':
              '${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}',
          'products': [
            {'productId': productId, 'quantity': quantity}
          ]
        }),
      );

      if (response.statusCode == 200) {
        return Cart.fromJson(json.decode(response.body));
            } else {
        throw Exception('Failed to update cart');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<User> getUserById(int id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/users/$id'));

      if (response.statusCode == 200) {
        return User.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load user');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<User> login(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/login'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'username': username,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        return User.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to login');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}

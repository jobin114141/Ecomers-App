// ignore_for_file: unused_import

import 'dart:convert';
import 'dart:developer';

import 'package:api_pgms/loginpage.dart';
import 'package:api_pgms/models/categorymodels.dart';
import 'package:api_pgms/models/catproductmodel.dart';
import 'package:api_pgms/models/offerproductsmodel.dart';
import 'package:api_pgms/models/orderDetailsModel.dart';
import 'package:api_pgms/models/userModel.dart';
import 'package:api_pgms/orderdetails.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../homepage.dart';

class webservice {
   final imageurl = 'http://bootcamp.cyralearnings.com/products/';
  static final mainurl = 'http://bootcamp.cyralearnings.com/';

  // ignore: body_might_complete_normally_nullable
  Future<List<categoryModel>?> fetchCategory() async {
    try {
      final response = await http.get(
        Uri.parse("http://bootcamp.cyralearnings.com/getcategories.php"),
      );
      if (response.statusCode == 200) {
        final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

        return parsed
            .map<categoryModel>((json) => categoryModel.fromjson(json))
            .toList();
      } else {
        throw Exception("Failed to load category");
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<List<offermodel>?> fetchofferproducts() async {
    try {
      final response = await http.get(
        Uri.parse("http://bootcamp.cyralearnings.com/view_offerproducts.php"),
      );

      if (response.statusCode == 200) {
        final parsed = json.decode(response.body);
        /*  print("API Response: $parsed"); */ // Add this line to log the response

        final List<offermodel> offerProducts = parsed
            .map<offermodel>((json) => offermodel.fromjson(json))
            .toList();

        return offerProducts;
      } else {
        throw Exception("Failed to fetch offer products");
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<List<Catproductmodel>?> fetchcatproducts() async {
    try {
      final response = await http.get(
        Uri.parse(
            "http://bootcamp.cyralearnings.com/get_category_products.php"),
      );

      if (response.statusCode == 200) {
        final List<dynamic> parsed = json.decode(response.body);
        print("Parsed JSON: $parsed");

        final List<Catproductmodel> catProducts = parsed
            .map<Catproductmodel>((json) => Catproductmodel.fromjson(json))
            .toList();

        print("CatProducts: $catProducts");

        return catProducts;
      } else {
        throw Exception(
            "Failed to fetch cat products. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error in fetchcatproducts: $e");
      return null;
    }
  }

  Future<userModel?> fetchUser() async {
    try {
      String? username = loggedInUsername;
      final response = await http.post(
        Uri.parse("http://bootcamp.cyralearnings.com/get_user.php"),
        body: {'username': username},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> parsed = json.decode(response.body);
        userModel user = userModel.fromJson(parsed);
        return user;
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<List<OrderModel>?> orderDetails() async {
    String? username = loggedInUsername;
    try {
      final response = await http.post(
          Uri.parse("http://bootcamp.cyralearnings.com/get_orderdetails.php"),
          body: {'username': username});
      if (response.statusCode == 200) {
        final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
        return parsed
            .map<OrderModel>((json) => OrderModel.fromJson(json))
            .toList();
            
      } else {
        throw Exception('Failed to load order details');
      }
    } catch (e) {
      log("order details ==" + e.toString());
    }
  }
}

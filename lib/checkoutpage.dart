// ignore_for_file: unused_import

import 'dart:convert';

import 'package:api_pgms/homepage.dart';
import 'package:api_pgms/loginpage.dart';
import 'package:api_pgms/models/cartmodel.dart';
import 'package:api_pgms/models/userModel.dart';
import 'package:api_pgms/webservices/webservices.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class CheckOutPage extends StatefulWidget {
  final List<CartItem> cartItems;
  final double totalPrice;

  CheckOutPage({required this.cartItems, required this.totalPrice});

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  int selectedValue = 1;
  String? name, address, phone;
  String? paymentmethod;

  String? username = loggedInUsername;

  orderPlace(
    List<CartItem> cartItems,
    String totalprice,
    String paymentmethod,
    String date,
    String name,
    String address,
    String phone,
  ) async {
    try {
      print("+++++++++++++++ivide ethi++++++++++++++++");
      String jsondata = jsonEncode(cartItems);
      // final vm = Provider.of<cartItems>(context, listen: false);

      
      final response = await http.post(
          Uri.parse("http://bootcamp.cyralearnings.com/order.php"),
          body: {
            "amount": totalprice,
            "quantity":totalprice.toString(),
            "cart": jsondata,
            "username": username,
            "paymentmethod": paymentmethod,
            "date": date,
            'name': name,
            "address": address,
            "phone": phone,
          });
      if (response.statusCode == 200) {
        if (response.body.contains("Success")) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            duration: Duration(seconds: 3),
            behavior: SnackBarBehavior.floating,
            padding: EdgeInsets.all(15.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            content: Text("YOUR ORDER SUCCESSFULLY COMPLETED",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                )),
          ));
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return Homepage();
            },
          ));
        }
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout Page'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
              future: webservice().fetchUser(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  name = snapshot.data!.name;
                  phone = snapshot.data!.phone;
                  address = snapshot.data!.address;
                  return Center(
                    child: Container(
                      height: 80,
                      width: 250,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color.fromARGB(255, 145, 150, 155)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              child: Text(
                                "NAME: ${snapshot.data!.name.toString()}",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 15),
                              ),
                            ),
                            Container(
                              child: Text(
                                  "PHONE: ${snapshot.data!.phone.toString()}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15)),
                            ),
                            Container(
                              child: Text(
                                  "ADDRESS: ${snapshot.data!.address.toString()}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
            RadioListTile(
              value: 1,
              groupValue: selectedValue,
              onChanged: (int? value) {
                setState(
                  () {
                    selectedValue = value!;
                    paymentmethod = 'Cash on delivery';
                  },
                );
              },
              title: const Text(
                'Cash On Delivery',
                style: TextStyle(fontFamily: "muli"),
              ),
              subtitle: const Text(
                'Pay Cash At Home',
                style: TextStyle(fontFamily: "muli"),
              ),
            ),
            RadioListTile(
              activeColor: Colors.blue.shade900,
              value: 2,
              groupValue: selectedValue,
              onChanged: (int? value) {
                setState(() {
                  selectedValue = value!;
                  paymentmethod = 'Online';
                });
              },
              title: const Text(
                'Pay Now',
              ),
              subtitle: const Text(
                'Online Payment',
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 455),
              child: ElevatedButton(
                  style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(Size(350, 50))),
                  onPressed: () {
                    String? Datetime = DateTime.now().toString();
                    print("++++++++++");
                    print(widget.cartItems);
                    print(widget.totalPrice.toString());
                    print(Datetime);
                    print(name.toString());
                    print(address.toString());
                    print(phone.toString());
                    print(paymentmethod.toString());

                    if (paymentmethod != null &&
                        name != null &&
                        address != null &&
                        phone != null) {
                      orderPlace(
                        widget.cartItems,
                        widget.totalPrice.toString(),
                        paymentmethod.toString(),
                        Datetime,
                        name.toString(),
                        address.toString(),
                        phone.toString(),
                      );
                    } else {
                      // Handle the case where any of these variables is null
                      print("Error: Some required values are null");
                    }
                  },
                  child: Text(
                    "BUY",
                    style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                  )),
            )
          ],
        ),
      ),
    );
  }
}

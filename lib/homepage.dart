import 'package:api_pgms/cart.dart';
import 'package:api_pgms/categoryproductpage.dart';
import 'package:api_pgms/loginpage.dart';
import 'package:api_pgms/offerpage.dart';
import 'package:api_pgms/orderdetails.dart';

import 'package:api_pgms/webservices/webservices.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late SharedPreferences _prefs;
  bool isloggedin = false;

  @override
  void initState() {
    super.initState();
    initPreferences();
  }

  Future<void> initPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    isloggedin = _prefs.getBool('isloggedin') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.lightGreen,
        foregroundColor: Colors.black,
        title: Padding(
          padding: const EdgeInsets.only(left: 50),
          child: Text(
            "E-COMMERCE",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            SizedBox(
              height: 20,
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Home"),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (ctd) {
                  return MyCart();
                }));
              },
              child: ListTile(
                leading: Icon(Icons.card_travel_rounded),
                title: Text("Cart Page"),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (ctd) {
                  return OrderDetailsPage();
                }));
              },
              child: ListTile(
                leading: Icon(Icons.on_device_training_outlined),
                title: Text("Order Details"),
              ),
            ),
            ListTile(
              onTap: () {
                _prefs.setBool("isloggedin", false);
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return MyLoginPage();
                }));
              },
              leading: Icon(Icons.logout_rounded),
              title: Text("Log Out"),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.only(left: 16),
              child: Text(
                "Category",
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 25),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            FutureBuilder(
              future: webservice().fetchCategory(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    height: 70,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.all(9.0),
                          child: InkWell(
                            onTap: () {
                              {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (ctd) {
                                  return CategoryProductPage(
                                      catid: snapshot.data![index].id);
                                }));
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.black26,
                              ),
                              child: Center(
                                child: Text(
                                  snapshot.data![index].category!,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
            OfferPage()
          ],
        ),
      ),
    );
  }
}

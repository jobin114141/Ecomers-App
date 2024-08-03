import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CategoryProductPage extends StatefulWidget {
  final int? catid;
  const CategoryProductPage({Key? key, this.catid}) : super(key: key);
  @override
  State<CategoryProductPage> createState() => _CategoryProductPageState();
}

class _CategoryProductPageState extends State<CategoryProductPage> {
  List<Map<String, dynamic>> products = [];

  Future<void> displayCatPrds() async {
    final response = await http.post(
      Uri.parse("http://bootcamp.cyralearnings.com/get_category_products.php"),
      body: {'catid': widget.catid.toString()},
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      products.clear();
      for (var product in jsonResponse) {
        products.add(product);
      }
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    displayCatPrds();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Category Products"),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        scrollDirection: Axis.vertical,
        itemCount: products.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 35),
                  child: Image.network(
                    "http://bootcamp.cyralearnings.com/products/${products[index]['image']}",
                    height: 100.0, // Adjust as needed
                    width: 100.0, // Adjust as needed
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(
                  height: 35,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text('${products[index]['productname']}',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 15, 0, 0),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text('RS. : ${products[index]['price']}',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 204, 0, 0),
                      )),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

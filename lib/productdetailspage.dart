import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/cartmodel.dart';

class productpage extends StatefulWidget {
  const productpage({
    super.key,
    this.id,
    this.catid,
    this.productname,
    this.description,
    this.imagenm,
    this.price,
  });
  final int? id;
  final int? catid;
  final double? price;
  final String? productname;
  final String? description;
  final String? imagenm;
  @override
  State<productpage> createState() => _productpageState();
}

class _productpageState extends State<productpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Product Page ")),
      body: Column(
        children: [
          Container(
            child: widget.imagenm != null
                ? Image.network(
                    widget.imagenm!,
                    width: 270,
                    height: 250,
                    fit: BoxFit.cover,
                  )
                : Container(
                    child: Text("empty"),
                  ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 450.5,
            width: double.maxFinite,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30), color: Colors.black12),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Text(
                    " ${widget.productname ?? ""}",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
                  ),
                  Text(
                    "RS. ${widget.price ?? ""}",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w900,
                        color: Colors.red),
                  ),
                  Text("${widget.description ?? ""}"),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                      height: 50,
                      width: 450,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 32, 32, 32)),
                          onPressed: () {
                            // Access the CartModel and add the current item to the cart
                            final CartModel cart = context.read<CartModel>();
                            
                            
                            // Using Provider
                            // Check if the item is already in the cart
                            bool isItemAlreadyInCart = cart.cartItems
                                .any((item) => item.id == widget.id);

                            if (isItemAlreadyInCart) {
                              // If the item is already in the cart, show a SnackBar
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Item already added to cart'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            } else {
                              // If the item is not in the cart, add it and show a SnackBar
                              cart.addItemToCart(CartItem(
                                id: widget.id,
                                catid: widget.catid,
                                productname: widget.productname,
                                price: widget.price,
                                imageUrl: widget.imagenm,
                              ));

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Item added to cart'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            }
                          },
                          child: Text(
                            "Add to Cart",
                            style: TextStyle(color: Colors.white),
                          )))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

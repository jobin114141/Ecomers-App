import 'package:api_pgms/checkoutpage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/cartmodel.dart';

class MyCart extends StatelessWidget {
  const MyCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('My Cart'),
            InkWell(
                onTap: () {
                  final CartModel cart =
                      context.read<CartModel>(); // Using Provider
                  cart.clearCart();
                },
                child: Icon(Icons.delete))
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<CartModel>(
          builder: (context, cart, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                if (cart.cartItems.isNotEmpty)
                  Expanded(
                    child: ListView.builder(
                      itemCount: cart.cartItems.length,
                      itemBuilder: (context, index) {
                        final CartItem item = cart.cartItems[index];
                        return Card(
                          color: Colors.white,
                          child: ListTile(
                            leading: Container(
                              height: 70,
                              width: 70,
                              child: item.imageUrl != null
                                  ? Image.network(
                                      item.imageUrl!,
                                      width: 270,
                                      height: 250,
                                      fit: BoxFit.fill,
                                    )
                                  : Container(
                                      child: Text("empty"),
                                    ),
                            ),
                            title: Text(item.productname ?? ''),
                            subtitle: Text('RS. ${item.price ?? ""}'),
                            trailing: Wrap(
                              spacing: 15, // space between two icons
                              children: <Widget>[
                                InkWell(
                                    onTap: () {
                                      // Increment quantity
                                      context
                                          .read<CartModel>()
                                          .incrementQuantity(index);
                                    },
                                    child: Icon(Icons.add)),
                                Text("${item.quantity}"),

                                InkWell(
                                    onTap: () {
                                      context
                                          .read<CartModel>()
                                          .decrementQuantity(index);
                                    },
                                    child: Icon(Icons.minimize)), // icon-2
                              ],
                            ),
                            // Add more details as needed
                          ),
                        );
                      },
                    ),
                  )
                else
                  Text('Cart is empty.'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 1),
                      child: Container(
                        child: Text(
                          "TOTAL: ${cart.getTotalPrice()}",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            color: Color.fromARGB(255, 250, 7, 7),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 40),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 0, 0, 0)),
                          onPressed: () {
                            context.read<CartModel>().getTotalPrice();
                          },
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (ctd) {
                                return CheckOutPage(
                                    cartItems: cart.cartItems,
                                    totalPrice: cart.getTotalPrice());
                              }));
                            },
                            child: Text(
                              "Order Now",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w400),
                            ),
                          )),
                    )
                  ],
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

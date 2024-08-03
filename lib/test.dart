Column(
                children: orderDetails.map((order) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Order ID: ${order.id}"),
                      Text("Username: ${order.username}"),
                      Text("Total Amount: ${order.totalamount}"),
                      Text("Payment Method: ${order.paymentmethod}"),
                      Text("Date: ${order.date}"),
                      Text("Products:"),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: order.products.map((product) {
                          return Column(
                            children: [
                              Text("Product Name: ${product.productname}"),
                              Text("Price: ${product.price}"),
                              Text("Image: ${product.image}"),
                              Text("Quantity: ${product.quantity}"),
                              Divider(), // Add a divider between products
                            ],
                          );
                        }).toList(),
                      ),
                      Divider(), // Add a divider between orders
                    ],
                  );
                }).toList(),
              );
              ______________________________________________________________________--
              
                      Text("Order ID: ${order.id}"),
                      Text("Username: ${order.username}"),
                      Text("Total Amount: ${order.totalamount}"),
                      Text("Payment Method: ${order.paymentmethod}"),
                      Text("Date: ${order.date}"),
                      Text("Products:"),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: order.products.map((product) {
                          return Column(
                            children: [
                              Text("Product Name: ${product.productname}"),
                              Text("Price: ${product.price}"),
                              Text("Image: ${product.image}"),
                              Text("Quantity: ${product.quantity}"),
                              Divider(), // Add a divider between products
                            ],
                          );
                        }).toList(),
                      ),
                      Divider(), // Add a divider between orders
                    
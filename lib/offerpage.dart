import 'package:api_pgms/productdetailspage.dart';
import 'package:flutter/material.dart';
import 'package:api_pgms/webservices/webservices.dart';

class OfferPage extends StatefulWidget {
  const OfferPage({Key? key}) : super(key: key);

  @override
  State<OfferPage> createState() => _OfferPageState();
}

class _OfferPageState extends State<OfferPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 0),
          child: Text(
            "Offer Page",
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 25),
          ),
        ),
        FutureBuilder(
          future: webservice().fetchofferproducts(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                height: 600,
                width: double.infinity,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  scrollDirection: Axis.vertical,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    // Use null-aware operator to safely access the image URL
                    final imageUrl = snapshot.data![index].imageUrl;

                    return InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (ctd) {
                          return productpage(
                            id: snapshot.data![index].id,
                            catid: snapshot.data![index].catid,
                            price: snapshot.data![index].price,
                            productname: snapshot.data![index].productname,
                            description: snapshot.data![index].description,
                            imagenm:'http://bootcamp.cyralearnings.com/products/$imageUrl',
                          );
                        }));
                      },
                      child: Card(
                        margin: const EdgeInsets.all(8),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        elevation: 3,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage(
                                  'http://bootcamp.cyralearnings.com/products/$imageUrl'),
                              fit: BoxFit.fill,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ListTile(
                                title: Text(
                                  snapshot.data![index].productname!,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 15, 0, 0),
                                  ),
                                ),
                                subtitle: Text(
                                  'RS. ${snapshot.data![index].price.toString()}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Color.fromARGB(255, 235, 0, 0),
                                  ),
                                ),
                              ),
                            ],
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
      ],
    );
  }
}

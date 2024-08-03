class Catproductmodel {
  int? id;
  int? catid;
  String? productname;
  double? price;
  String? imageUrl;

  Catproductmodel({this.id, this.catid, this.productname, this.price, this.imageUrl});

  factory Catproductmodel.fromjson(Map<String, dynamic> json) {
    return Catproductmodel(
      id: json["id"],
      catid: json["catid"],
      productname: json["productname"],
      price: json["price"]?.toDouble() ?? 0.0,
      imageUrl: json["image"],
    );
  }
}

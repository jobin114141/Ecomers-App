class offermodel {
  int? id;
  int? catid;
  String? productname;
  String? description;
  double? price;
  String? imageUrl;

  offermodel({this.id, this.catid, this.productname, this.price,this.imageUrl,this.description});

  factory offermodel.fromjson(Map<String, dynamic> json) => offermodel(
      id: json["id"],
      catid: json["catid"],
      productname: json["productname"],
      description: json["description"],
      price: json["price"]?.toDouble(),
      imageUrl: json["image"]);
}

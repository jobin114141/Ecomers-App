class userModel {
  String? name;
  String? phone;
  String? address;
  userModel({this.name, this.address, this.phone});

  factory userModel.fromJson(Map<String, dynamic> json) => userModel(
        name: json["name"],
        phone: json["phone"],
        address: json["address"],
     
      );
}

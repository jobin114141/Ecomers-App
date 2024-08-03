class categoryModel {
  int? id;
  String? category;
  categoryModel({this.id, this.category});

  factory categoryModel.fromjson(Map<String, dynamic> json) =>
      categoryModel(id: json["id"], category: json["category"]);
}

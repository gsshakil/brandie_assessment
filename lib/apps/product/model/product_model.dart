class ProductModel {
  ProductModel({this.id, this.name, this.description, this.imageUrl});
  String? id;
  String? name;
  String? imageUrl;
  String? description;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        name: json["name"],
        imageUrl: json["imaheUrl"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "imageUrl": imageUrl,
        "description": description,
      };
}

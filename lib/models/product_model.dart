class ProductModel {
  late int id;
  late String name;
  late String description;
  late String price;
  late String image;

  ProductModel(
      {required this.id,
      required this.name,
      required this.description,
      required this.price,
      required this.image});

  factory ProductModel.fromMap(Map data) {
    return ProductModel(
        id: data["id"],
        name: data["name"],
        description: data["description"],
        price: data["price"],
        image: data["image"]);
  }

  Map<String, dynamic> toJSON() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image': image,
      'price': price,
      'image': image,
    };
  }
}

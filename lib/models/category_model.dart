import 'dart:typed_data';

class CategoryModel {

  int? cat_id;
  String? cat_name;
  Uint8List? cat_img;

  CategoryModel({this.cat_id, required this.cat_name, required this.cat_img});
  factory CategoryModel.fromMap({required Map data}){
    return CategoryModel(cat_name: data["category_name"], cat_img:data["category_image"]);
  }

}
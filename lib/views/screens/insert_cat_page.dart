import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lab_work_9_3/models/category_model.dart';

import '../../db_helper/database_helper.dart';

class InsertCatPage extends StatefulWidget {
  const InsertCatPage({super.key});

  @override
  State<InsertCatPage> createState() => _InsertCatPageState();
}

class _InsertCatPageState extends State<InsertCatPage> {
  TextEditingController nameController = TextEditingController();
  ImagePicker imagePicke = ImagePicker();
  Uint8List? imgFile;
  final GlobalKey<FormState> categoryFromKey = GlobalKey<FormState>();
  String? categoryName = "aa";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Categories"),
        actions: [
          GestureDetector(
            onTap: () async {
              if (categoryFromKey.currentState!.validate()) {
                categoryFromKey.currentState!.save();

                CategoryModel model =
                    CategoryModel(cat_name: categoryName, cat_img: imgFile);
                int id =
                    await DatabaseHelper.dbHelper.insertCategory(model: model);
                if (id >= 1) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Category inserted successfully.."),
                    backgroundColor: Colors.green,
                    behavior: SnackBarBehavior.floating,
                  ));
                  categoryFromKey.currentState!.reset();
                  categoryName = null;
                  nameController.clear();
                  imgFile = null;
                  setState(() {});
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Category insertion failed.."),
                      backgroundColor: Colors.red,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
              }
            },
            child: Container(
                margin: EdgeInsets.only(right: 20),
                child: Text(
                  "SAVE",
                  style: TextStyle(fontSize: 18),
                )),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Form(
          key: categoryFromKey,
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter the category name first...";
                  } else {
                    return null;
                  }
                },
                onSaved: (newValue) {
                  categoryName = newValue;
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      onPressed: () {
                        nameController.clear();
                        categoryName = null;
                      },
                      icon: Icon(Icons.close),
                    ),
                    labelText: "Name",
                    hintText: "Enter category name"),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  OutlinedButton.icon(
                    icon: Icon(Icons.image),
                    label: Text("Pick Image"),
                    onPressed: () async {
                      XFile? xFile = await imagePicke.pickImage(
                          source: ImageSource.camera);
                      imgFile = await xFile!.readAsBytes();
                      setState(() {});
                    },
                  ),
                  IconButton(
                      onPressed: () {
                        imgFile = null;
                        setState(() {});
                      },
                      icon: Icon(Icons.close))
                ],
              ),
              SizedBox(
                height: 400,
                width: 400,
                child: imgFile == null
                    ? Container()
                    : Image.memory(imgFile!),
              )
            ],
          ),
        ),
      ),
    );
  }
}

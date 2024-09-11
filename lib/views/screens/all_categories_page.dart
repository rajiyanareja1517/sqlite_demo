import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lab_work_9_3/models/category_model.dart';

import '../../db_helper/database_helper.dart';

class AllCategoriesPage extends StatefulWidget {
  const AllCategoriesPage({super.key});

  @override
  State<AllCategoriesPage> createState() => _AllCategoriesPageState();
}

class _AllCategoriesPageState extends State<AllCategoriesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Categories"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed("/insert_cat_page");
        },
        child: Icon(Icons.add),
      ),
      body: Container(
        child: FutureBuilder(
          future: DatabaseHelper.dbHelper.fetchAllCategories(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("Error : ${snapshot.error}"),
              );
            } else if (snapshot.hasData) {
              List<CategoryModel>? data = snapshot.data;
              if ((data == null || data.isEmpty)) {
                return Center(
                      child: Text("No any categories availeble..."),
                    );
              } else {
                return Container(
                width: 200,
                height: 400,
                    child: ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              return Container(
                                width: 200,
                                height: 400,
                                child: ListTile(
                                  leading: Text("${index + 1}"),
                                  title: Text("${data[index].cat_name}"),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(onPressed: () {}, icon: Icon(Icons.edit))
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                  );
              }
            } else {
              return Container(
                child: Text("No any categories availeble..."),
              );
            }
          },
        ),
      ),
    );
  }
}

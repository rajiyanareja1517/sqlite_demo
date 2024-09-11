import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lab_work_9_3/db_helper/database_helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Budget Traker"),
        actions: [
          IconButton(
              onPressed: () {
                Get.toNamed("/all_cat_page");
              },
              icon: Icon(Icons.settings))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed("/insert_page");
        },
        child: Icon(Icons.add),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

          ],
        ),
      ),
    );
  }
}

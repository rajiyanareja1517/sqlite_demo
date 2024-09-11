import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lab_work_9_3/views/screens/all_categories_page.dart';
import 'package:lab_work_9_3/views/screens/home_screen.dart';
import 'package:lab_work_9_3/views/screens/insert_cat_page.dart';
import 'package:lab_work_9_3/views/screens/insert_page.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
getPages: [
  GetPage(name: '/', page: () => HomePage()),
  GetPage(name: '/insert_page', page: () => InsertPage()),
  GetPage(name: '/insert_cat_page', page: () => InsertCatPage()),
  GetPage(name: '/all_cat_page', page: () => AllCategoriesPage()),

],
    );
  }
}


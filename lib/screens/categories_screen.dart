import 'package:admin_website_grocery_app/widgets/categories/category_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

import '../services/sidebar.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);
  static const id = "categories-screen";

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final SidebarWidget _sidebarWidget = SidebarWidget();
  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Colors.black87,
        title: const Text(
          'Grocery App Admin Dashboard',
          style: TextStyle(color: Colors.white),
        ),
      ),
      sideBar: _sidebarWidget.sideBarMenus(context, CategoriesScreen.id),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Vendors Screen',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 36,
                ),
              ),
              Text("Add New Categories and Sub Categories"),
              Divider(thickness: 5,),
              // CategoriesUploadWidget(),
              Divider(thickness: 5,),
              CategoryListWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

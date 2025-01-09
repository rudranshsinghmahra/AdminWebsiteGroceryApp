import 'package:admin_website_grocery_app/widgets/vendors/vendors_datatable_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

import '../services/sidebar.dart';

class VendorScreen extends StatefulWidget {
  const VendorScreen({Key? key}) : super(key: key);
  static const id = "vendors-screen";

  @override
  State<VendorScreen> createState() => _VendorScreenState();
}

class _VendorScreenState extends State<VendorScreen> {
  @override
  Widget build(BuildContext context) {
    final SidebarWidget _sidebarWidget = SidebarWidget();
    return AdminScaffold(
      backgroundColor: Colors.white,
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
      sideBar: _sidebarWidget.sideBarMenus(context, VendorScreen.id),
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
              Text("Manage All Banner Activities"),
              Divider(thickness: 5,),
              VendorDataTable(),
              Divider(thickness: 5,),
            ],
          ),
        ),
      ),
    );
  }
}

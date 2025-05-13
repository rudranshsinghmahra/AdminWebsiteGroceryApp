import 'package:admin_website_grocery_app/widgets/deliveryBoy/approved_delivery_boys.dart';
import 'package:admin_website_grocery_app/widgets/deliveryBoy/create_delivery_boy.dart';
import 'package:admin_website_grocery_app/widgets/deliveryBoy/new_delivery_boys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import '../services/sidebar.dart';

class DeliveryBoyScreen extends StatefulWidget {
  const DeliveryBoyScreen({super.key});
  static const String id = "deliveryBoy-screen";

  @override
  State<DeliveryBoyScreen> createState() => _DeliveryBoyScreenState();
}

class _DeliveryBoyScreenState extends State<DeliveryBoyScreen> {
  final SidebarWidget sidebarWidget = SidebarWidget();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: AdminScaffold(
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
        sideBar: sidebarWidget.sideBarMenus(context, DeliveryBoyScreen.id),
        body: SingleChildScrollView(
          child: Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(10),
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Delivery Boys',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 36,
                  ),
                ),
                Text("Add New Categories and Sub Categories"),
                Divider(
                  thickness: 5,
                ),
                CreateNewBoyWidget(),
                Divider(
                  thickness: 5,
                ),
                TabBar(
                    labelColor: Colors.blue,
                    indicatorColor: Colors.blue,
                    tabs: [
                      Tab(
                        text: "NEW",
                      ),
                      Tab(
                        text: "APPROVED",
                      ),
                    ]),
                Expanded(
                    child: TabBarView(children: [
                  NewDeliveryBoys(),
                  ApprovedDeliveryBoys(),
                ]))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

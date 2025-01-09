import 'package:admin_website_grocery_app/services/firebase_services.dart';
import 'package:admin_website_grocery_app/services/sidebar.dart';
import 'package:admin_website_grocery_app/widgets/banners/banner_widgets.dart';
import 'package:admin_website_grocery_app/widgets/banners/banners_upload_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

class BannerScreen extends StatefulWidget {
  const BannerScreen({Key? key}) : super(key: key);
  static const id = "banner-screen";

  @override
  _BannerScreenState createState() => _BannerScreenState();
}

class _BannerScreenState extends State<BannerScreen> {
  final SidebarWidget _sidebarWidget = SidebarWidget();
  bool isVisible = false;
  bool imageSelected = true;
  String url = "";
  FirebaseServices services = FirebaseServices();
  TextEditingController fileNameTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
      sideBar: _sidebarWidget.sideBarMenus(context, BannerScreen.id),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Banner Screen',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 36,
                ),
              ),
              Text("Add/Delete Home Screen Banner Images"),
              Divider(
                thickness: 5,
              ),
              BannerWidget(),
              Divider(
                thickness: 5,
              ),
              // BannerUploadWidget(),
            ],
          ),
        ),
      ),
    );
  }


}

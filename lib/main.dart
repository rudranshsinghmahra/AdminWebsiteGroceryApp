import 'package:admin_website_grocery_app/screens/home_screen.dart';
import 'package:admin_website_grocery_app/screens/admin_users.dart';
import 'package:admin_website_grocery_app/screens/categories_screen.dart';
import 'package:admin_website_grocery_app/screens/deliveryBoy_screen.dart';
import 'package:admin_website_grocery_app/screens/login_screen.dart';
import 'package:admin_website_grocery_app/screens/manage_banners.dart';
import 'package:admin_website_grocery_app/screens/notification_screen.dart';
import 'package:admin_website_grocery_app/screens/orders_screen.dart';
import 'package:admin_website_grocery_app/screens/settings_screen.dart';
import 'package:admin_website_grocery_app/screens/splash_screen.dart';
import 'package:admin_website_grocery_app/screens/vendors_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyBXPVjFC8IRVeLDN6B_E2Y8RcdQpc1PGdg", // Your apiKey
        appId: "1:147156304764:web:96b516fa253cfea5da9af9", // Your appId
        messagingSenderId: "147156304764", // Your messagingSenderId
        projectId: "grocery-application-3329d", // Your
        storageBucket: "grocery-application-3329d.appspot.com" // projectId
        ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const SplashScreen(),
      builder: EasyLoading.init(),
      routes: {
        HomeScreen.id: (context) => const HomeScreen(),
        SplashScreen.id: (context) => const SplashScreen(),
        LoginScreen.id: (context) => const LoginScreen(),
        BannerScreen.id: (context) => const BannerScreen(),
        CategoriesScreen.id: (context) => const CategoriesScreen(),
        OrderScreen.id: (context) => const OrderScreen(),
        NotificationScreen.id: (context) => const NotificationScreen(),
        AdminUsers.id: (context) => const AdminUsers(),
        SettingScreen.id: (context) => const SettingScreen(),
        VendorScreen.id: (context) => const VendorScreen(),
        DeliveryBoyScreen.id: (context) => const DeliveryBoyScreen(),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.deepPurple),
      title: "Grocery App Admin Dashboard",
    );
  }
}

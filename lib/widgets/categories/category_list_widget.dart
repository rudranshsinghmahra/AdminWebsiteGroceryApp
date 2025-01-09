import 'package:admin_website_grocery_app/services/firebase_services.dart';
import 'package:admin_website_grocery_app/widgets/categories/category_card_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CategoryListWidget extends StatelessWidget {
  const CategoryListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseServices services = FirebaseServices();
    return Container(
      width: MediaQuery.of(context).size.width,
      child: StreamBuilder(
        stream: services.category.snapshots(),
        builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
          if(snapshot.hasError){
            return const Center(child: Text("Something went wrong.."),);
          }
          if(snapshot.connectionState==ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator());
          }
          return Wrap(
            direction: Axis.horizontal,
            children: snapshot.data!.docs.map((DocumentSnapshot document){
              return CategoryCard(documentSnapshot: document,);
              }).toList(),
          );
        },
      ),
    );
  }
}

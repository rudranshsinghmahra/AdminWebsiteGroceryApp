import 'package:admin_website_grocery_app/widgets/sub_category_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final DocumentSnapshot documentSnapshot;
  const CategoryCard({Key? key, required this.documentSnapshot})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(4),
      onTap: (){
        showDialog(context: context, builder: (BuildContext context){
          return SubCategoryWidget(categoryName: documentSnapshot['name'],);
        });
      },
      child: SizedBox(
        height: 150,
        width: 150,
        child: Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 70,
                    width: double.infinity,
                    child: Image.network(
                      documentSnapshot['images'],
                    ),
                  ),
                  const SizedBox(height: 10,),
                  FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      documentSnapshot['name'],style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

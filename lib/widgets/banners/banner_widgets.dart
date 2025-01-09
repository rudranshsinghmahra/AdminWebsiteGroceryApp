import 'package:admin_website_grocery_app/constants.dart';
import 'package:admin_website_grocery_app/services/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class BannerWidget extends StatelessWidget {
  const BannerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseServices services = FirebaseServices();
    ScrollController _controller = new ScrollController();
    return StreamBuilder<QuerySnapshot>(
      stream: services.banners.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 200,
          child: ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(dragDevices: {
              PointerDeviceKind.touch,
              PointerDeviceKind.mouse,
            },),
            child: ListView(
              controller: _controller,
              physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              scrollDirection: Axis.horizontal,
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                return Center(
                  child: Stack(
                    children: [
                      SizedBox(
                        height: 200,
                        child: Card(
                          elevation: 10,
                          child: Image.network(
                            data['images'],
                            width: 400,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Positioned(
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: IconButton(
                            onPressed: () {
                              services.deleteBannerImageFromDatabase(document.id);
                              showAlert("Banner Successfully Deleted From Database");
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                        ),
                        top: 10,
                        right: 10,
                      )
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}

import 'package:admin_website_grocery_app/services/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VendorDetailsBox extends StatefulWidget {
  final String uid;
  const VendorDetailsBox({Key? key, required this.uid}) : super(key: key);

  @override
  State<VendorDetailsBox> createState() => _VendorDetailsBoxState();
}

class _VendorDetailsBoxState extends State<VendorDetailsBox> {
  FirebaseServices services = FirebaseServices();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: services.vendors.doc(widget.uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text("Something went wrong"),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Dialog(
          child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Stack(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: ListView(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(
                              height: 100,
                              width: 100,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  snapshot.data?['imageUrl'],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  snapshot.data?['shopName'],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25),
                                ),
                                Text(
                                  snapshot.data?['dialog'],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 25),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Divider(
                          thickness: 4,
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Row(
                                children: [
                                  const Expanded(
                                    child: Text(
                                      "Contact Number",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const Padding(
                                    padding:
                                        EdgeInsets.only(left: 10, right: 10),
                                    child: Text(":"),
                                  ),
                                  Expanded(
                                      child: Text(snapshot.data?['mobile']))
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Row(
                                children: [
                                  const Expanded(
                                    child: Text(
                                      "Email",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const Padding(
                                    padding:
                                        EdgeInsets.only(left: 10, right: 10),
                                    child: Text(":"),
                                  ),
                                  Expanded(child: Text(snapshot.data?['email']))
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Expanded(
                                    child: Text(
                                      "Address",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const Padding(
                                    padding:
                                        EdgeInsets.only(left: 10, right: 10),
                                    child: Text(":"),
                                  ),
                                  Expanded(
                                      child: Text(snapshot.data?['address']))
                                ],
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Divider(
                                thickness: 2,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Row(
                                children: [
                                  const Expanded(
                                    child: Text(
                                      "Top Picked Status",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const Padding(
                                    padding:
                                        EdgeInsets.only(left: 10, right: 10),
                                    child: Text(":"),
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: snapshot.data?['isTopPicked']
                                          ? Chip(
                                              backgroundColor: Colors.green,
                                              label: Row(
                                                children: const [
                                                  Icon(Icons.check),
                                                  Text(
                                                    '  Top Picked',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )
                                                ],
                                              ),
                                            )
                                          : const Icon(
                                              Icons.clear,
                                              color: Colors.red,
                                            ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Divider(
                                thickness: 2,
                              ),
                            ),
                            Wrap(
                              children: [
                                SizedBox(
                                  height: 120,
                                  width: 120,
                                  child: Card(
                                    color: Colors.orangeAccent.withOpacity(0.9),
                                    elevation: 4,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: const [
                                          Icon(
                                            CupertinoIcons.money_dollar_circle,
                                            size: 50,
                                            color: Colors.black54,
                                          ),
                                          Text("Total Revenue"),
                                          Text("120,000")
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 120,
                                  width: 120,
                                  child: Card(
                                    color: Colors.orangeAccent.withOpacity(0.9),
                                    elevation: 4,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: const [
                                          Icon(
                                            CupertinoIcons.cart,
                                            size: 50,
                                            color: Colors.black54,
                                          ),
                                          Text("Active Orders"),
                                          Text("6")
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 120,
                                  width: 120,
                                  child: Card(
                                    color: Colors.orangeAccent.withOpacity(0.9),
                                    elevation: 4,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: const [
                                          Icon(
                                            Icons.shopping_bag,
                                            size: 50,
                                            color: Colors.black54,
                                          ),
                                          Text("Orders"),
                                          Text("130")
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 120,
                                  width: 120,
                                  child: Card(
                                    color: Colors.orangeAccent.withOpacity(0.9),
                                    elevation: 4,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: const [
                                          Icon(
                                            Icons.grain_outlined,
                                            size: 50,
                                            color: Colors.black54,
                                          ),
                                          Text("Products"),
                                          FittedBox(child: Text("160 Products",textAlign: TextAlign.center,))
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 120,
                                  width: 120,
                                  child: Card(
                                    color: Colors.orangeAccent.withOpacity(0.9),
                                    elevation: 4,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: const [
                                          Icon(
                                            Icons.list_alt_outlined,
                                            size: 50,
                                            color: Colors.black54,
                                          ),
                                          Text("Statements"),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    child: snapshot.data?['accVerified']
                        ? Chip(
                            backgroundColor: Colors.green,
                            label: Row(
                              children: [
                                Icon(
                                  Icons.check,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  "Active",
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            ))
                        : Chip(
                            backgroundColor: Colors.red,
                            label: Row(
                              children: const [
                                Icon(
                                  Icons.remove_circle,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  "In-Active",
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            )),
                    top: 10,
                    right: 10,
                  )
                ],
              )),
        );
      },
    );
  }
}

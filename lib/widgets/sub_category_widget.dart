import 'package:admin_website_grocery_app/constants.dart';
import 'package:admin_website_grocery_app/services/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SubCategoryWidget extends StatefulWidget {
  final String categoryName;
  const SubCategoryWidget({Key? key, required this.categoryName})
      : super(key: key);

  @override
  State<SubCategoryWidget> createState() => _SubCategoryWidgetState();
}

class _SubCategoryWidgetState extends State<SubCategoryWidget> {
  TextEditingController subCategoryNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    FirebaseServices services = FirebaseServices();
    return Dialog(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: 300,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: FutureBuilder<DocumentSnapshot>(
            future: services.category.doc(widget.categoryName).get(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text("Something went wrong");
              }

              if (snapshot.hasData && !snapshot.data!.exists) {
                return const Text("Document does not exist");
              }

              if (snapshot.connectionState == ConnectionState.done) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: Text("No Sub Categories Added"),
                  );
                } else {
                  Map<String, dynamic> data =
                      snapshot.data!.data() as Map<String, dynamic>;
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              const Text("Main Category : "),
                              Text(
                                widget.categoryName,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const Divider(
                            thickness: 3,
                          ),
                        ],
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: CircleAvatar(
                                child: Text("${index + 1}"),
                              ),
                              title: Text(data['subCategory'][index]['name']),
                            );
                          },
                          itemCount: data['subCategory'] == null
                              ? 0
                              : data['subCategory'].length,
                        ),
                      ),
                      Column(
                        children: [
                          const Divider(
                            thickness: 3,
                          ),
                          Container(
                            color: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    "Add New Sub Category",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: SizedBox(
                                        height: 30,
                                        child: TextField(
                                          controller: subCategoryNameController,
                                          decoration: const InputDecoration(
                                            hintText: "Sub Category Name",
                                            fillColor: Colors.white,
                                            filled: true,
                                            border: OutlineInputBorder(),
                                            focusedBorder: OutlineInputBorder(),
                                            contentPadding:
                                                EdgeInsets.only(left: 10),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 20,),
                                    ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor)
                                      ),
                                      onPressed: () {
                                        if (subCategoryNameController
                                            .text.isEmpty) {
                                          showAlert(
                                              "Need to Give Sub-Category Name");
                                        }
                                        DocumentReference reference = services
                                            .category
                                            .doc(widget.categoryName);
                                        reference.update({
                                          'subCategory': FieldValue.arrayUnion([
                                            {
                                              'name':
                                                  subCategoryNameController.text
                                            }
                                          ])
                                        });
                                        setState(() {});
                                        subCategoryNameController.clear();
                                      },
                                      child: const Text(
                                        "Save",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  );
                }
              }

              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }
}

import 'package:admin_website_grocery_app/services/firebase_services.dart';
import 'package:admin_website_grocery_app/widgets/vendors/vendors_details_box.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class VendorDataTable extends StatefulWidget {
  const VendorDataTable({super.key});

  @override
  State<VendorDataTable> createState() => _VendorDataTableState();
}

class _VendorDataTableState extends State<VendorDataTable> {
  FirebaseServices services = FirebaseServices();
  int tag = 0;
  bool? topPicked;
  bool? active;
  List<String> options = [
    "All Vendors",
    "Active Vendors",
    "In-active Vendors",
    "Top Picked",
    "Top Rated"
  ];

  filter(val) {
    if (val == 1) {
      setState(() {
        active = true;
      });
    }
    if (val == 2) {
      setState(() {
        active = false;
      });
    }
    if (val == 3) {
      setState(() {
        topPicked = true;
      });
    }
    if (val == 0) {
      setState(() {
        topPicked = null;
        active = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ChipsChoice<int>.single(
          value: tag,
          onChanged: (val) {
            setState(() {
              tag = val;
            });
            filter(val);
          },
          choiceItems: C2Choice.listFrom<int, String>(
              source: options, value: (i, v) => i, label: (i, v) => v),
        ),
        const Divider(
          thickness: 5,
        ),
        StreamBuilder<QuerySnapshot>(
          stream: services.vendors
              .where('isTopPicked', isEqualTo: topPicked)
              .where('accVerified', isEqualTo: active)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text("Something Went Wrong");
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                showBottomBorder: true,
                dataRowHeight: 60,
                headingRowColor: MaterialStateProperty.all(Colors.grey[200]),
                columns: const [
                  DataColumn(
                    label: Text("Active/Inactive"),
                  ),
                  DataColumn(
                    label: Text("Top Picked"),
                  ),
                  DataColumn(
                    label: Text("Shop Name"),
                  ),
                  DataColumn(
                    label: Text("Rating"),
                  ),
                  DataColumn(
                    label: Text("Total Sales"),
                  ),
                  DataColumn(
                    label: Text("Mobile"),
                  ),
                  DataColumn(
                    label: Text("Email"),
                  ),
                  DataColumn(
                    label: Text("View Details"),
                  ),
                ],
                rows: vendorsDetailsRow(snapshot.data, services),
              ),
            );
          },
        )
      ],
    );
  }

  List<DataRow> vendorsDetailsRow(
      QuerySnapshot? snapshot, FirebaseServices services) {
    List<DataRow> newList =
        snapshot!.docs.map((DocumentSnapshot documentSnapshot) {
      return DataRow(cells: [
        DataCell(IconButton(
          onPressed: () {
            services.updateVendorStatus(
              documentSnapshot['uid'],
              documentSnapshot['accVerified'],
            );
          },
          icon: documentSnapshot['accVerified']
              ? const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                )
              : const Icon(
                  Icons.remove_circle,
                  color: Colors.red,
                ),
        )),
        DataCell(IconButton(
          onPressed: () {
            services.updateTopPicked(
              documentSnapshot['uid'],
              documentSnapshot['isTopPicked'],
            );
          },
          icon: documentSnapshot['isTopPicked']
              ? const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                )
              : const Icon(
                  Icons.clear,
                  color: Colors.red,
                ),
        )),
        DataCell(Text(documentSnapshot['shopName'])),
        DataCell(
          Row(
            children: [
              Icon(
                Icons.star,
                color: Colors.grey,
              ),
              Text("${documentSnapshot['rating']}")
            ],
          ),
        ),
        const DataCell(Text("20,000")),
        DataCell(Text(documentSnapshot['mobile'])),
        DataCell(Text(documentSnapshot['email'])),
        DataCell(IconButton(
          icon: const Icon(Icons.info_outlined),
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return VendorDetailsBox(uid: documentSnapshot['uid']);
                });
          },
        ))
      ]);
    }).toList();
    return newList;
  }
}

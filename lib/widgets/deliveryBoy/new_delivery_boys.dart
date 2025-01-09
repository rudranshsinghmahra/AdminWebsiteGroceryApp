import 'package:admin_website_grocery_app/services/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_switch/flutter_switch.dart';

class NewDeliveryBoys extends StatefulWidget {
  const NewDeliveryBoys({Key? key}) : super(key: key);

  @override
  State<NewDeliveryBoys> createState() => _NewDeliveryBoysState();
}

class _NewDeliveryBoysState extends State<NewDeliveryBoys> {
  FirebaseServices services = FirebaseServices();
  bool status = false;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: services.deliveryBoys
          .where('accVerified', isEqualTo: false)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Something Went Wrong..");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        QuerySnapshot? snap = snapshot.data;
        if (snap?.size == 0) {
          return const Center(
            child: Text("No New Delivery boys available to list"),
          );
        }
        return SingleChildScrollView(
          child: DataTable(
            showBottomBorder: true,
            dataRowHeight: 70,
            headingRowColor: MaterialStateProperty.all(Colors.grey[200]),
            columns: const [
              DataColumn(
                label: Text("PROFILE", style: TextStyle(fontSize: 20)),
              ),
              DataColumn(
                label: Text("NAME", style: TextStyle(fontSize: 20)),
              ),
              DataColumn(
                label: Text("EMAIL", style: TextStyle(fontSize: 20)),
              ),
              DataColumn(
                label: Text("MOBILE", style: TextStyle(fontSize: 20)),
              ),
              DataColumn(
                label: Text("ADDRESS", style: TextStyle(fontSize: 20)),
              ),
              DataColumn(
                label: Text("ACTION", style: TextStyle(fontSize: 20)),
              ),
            ],
            rows: _deliveryBoyList(snapshot.data, context),
          ),
        );
      },
    );
  }

  List<DataRow> _deliveryBoyList(QuerySnapshot? snapshot, context) {
    List<DataRow> newList = snapshot!.docs.map(
      (DocumentSnapshot documentSnapshot) {
        return DataRow(
          cells: [
            DataCell(
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: SizedBox(
                  width: 80,
                  child: documentSnapshot['imageUrl'] == ""
                      ? const Icon(
                          Icons.person,
                          size: 50,
                        )
                      : Image.network(
                          documentSnapshot['imageUrl'],
                          fit: BoxFit.fill,
                        ),
                ),
              ),
            ),
            DataCell(Text(documentSnapshot['name'])),
            DataCell(Text(documentSnapshot['email'])),
            DataCell(Text(documentSnapshot['mobile'])),
            DataCell(Text(documentSnapshot['address'])),
            DataCell(documentSnapshot['mobile'] == "" ? Text("Delivery Boy Not Registered") : FlutterSwitch(
              activeText: "Approved",
              inactiveText: "Not Approved",
              width: 125.0,
              height: 45.0,
              valueFontSize: 11.0,
              toggleSize: 30.0,
              value: documentSnapshot['accVerified'],
              borderRadius: 30.0,
              padding: 8.0,
              showOnOff: true,
              onToggle: (val) {
                services.updateDeliveryBoyStatus(
                    id: documentSnapshot.id, status: true);
                EasyLoading.dismiss();
              },
            )),
          ],
        );
      },
    ).toList();
    return newList;
  }
}

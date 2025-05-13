import 'package:admin_website_grocery_app/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class FirebaseServices {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  CollectionReference banners = FirebaseFirestore.instance.collection('slider');
  CollectionReference vendors =
      FirebaseFirestore.instance.collection('vendors');
  CollectionReference category =
      FirebaseFirestore.instance.collection('category');
  CollectionReference deliveryBoys =
      FirebaseFirestore.instance.collection('deliveryBoys');
  FirebaseStorage storage = FirebaseStorage.instance;

  Future<DocumentSnapshot> getAdminCredentials(id) async {
    var result =
        await FirebaseFirestore.instance.collection('admin').doc(id).get();
    return result;
  }

  Future<String> uploadBannerImageToDatabase(url) async {
    String downloadUrl = await storage.ref(url).getDownloadURL();
    firebaseFirestore.collection('slider').add({
      'images': downloadUrl,
    });
    return downloadUrl;
  }

  deleteBannerImageFromDatabase(id) async {
    firebaseFirestore.collection('slider').doc(id).delete();
  }

  updateVendorStatus(id, status) async {
    vendors.doc(id).update({'accVerified': status ? false : true});
  }

  updateTopPicked(id, status) async {
    vendors.doc(id).update({'isTopPicked': status ? false : true});
  }

  Future<String> uploadCategoryToDatabase(url, categoryName) async {
    String downloadUrl = await storage.ref(url).getDownloadURL();
    category.doc(categoryName).set({
      'images': downloadUrl,
      'name': categoryName,
    });
    return downloadUrl;
  }

  Future<void> saveDeliveryBoys(String email, password) async {
    deliveryBoys.doc(email.toLowerCase()).set({
      'accVerified': false,
      'address': '',
      'email': email.toLowerCase(),
      'imageUrl': '',
      'location': const GeoPoint(0.0, 0.0),
      'mobile': '',
      'name': '',
      'password': password,
      'uid': '',
    });
  }

  updateDeliveryBoyStatus({id, status}) {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('deliveryBoys').doc(id);

    return FirebaseFirestore.instance.runTransaction((transaction) async {
      // Get the document
      DocumentSnapshot snapshot = await transaction.get(documentReference);

      if (!snapshot.exists) {
        throw Exception("User does not exist!");
      }
      transaction.update(documentReference, {'accVerified': status});
    }).then((value) {
      EasyLoading.showSuccess(status == true
          ? "Delivery boy status updated as Approved"
          : "Delivery boy's approval revoked");
    }).catchError((error) {
      showAlert("Failed to update delivery boy status: $error");
    });
  }
}

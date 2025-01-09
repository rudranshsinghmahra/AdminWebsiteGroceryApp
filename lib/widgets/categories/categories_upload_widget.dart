// import 'dart:html';
// import 'package:flutter/material.dart';
// import 'package:progress_dialog/progress_dialog.dart';
// import 'package:firebase/firebase.dart' as fb;
// import '../../constants.dart';
// import '../../services/firebase_services.dart';
// import '../../services/sidebar.dart';
//
// class CategoriesUploadWidget extends StatefulWidget {
//   const CategoriesUploadWidget({Key? key}) : super(key: key);
//
//   @override
//   State<CategoriesUploadWidget> createState() => _CategoriesUploadWidgetState();
// }
//
// class _CategoriesUploadWidgetState extends State<CategoriesUploadWidget> {
//   bool isVisible = false;
//   final SidebarWidget _sidebarWidget = SidebarWidget();
//   bool imageSelected = true;
//   String url = "";
//   FirebaseServices services = FirebaseServices();
//   TextEditingController fileNameTextController = TextEditingController();
//   TextEditingController categoryTextController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     ProgressDialog pr = ProgressDialog(context,
//         type: ProgressDialogType.Normal, isDismissible: false, showLogs: false);
//     pr.style(
//       borderRadius: 10.0,
//       backgroundColor: Colors.white,
//       progressWidget: const CircularProgressIndicator(),
//       elevation: 10.0,
//       insetAnimCurve: Curves.easeInOut,
//       progress: 0.0,
//       maxProgress: 100.0,
//     );
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: SizedBox(
//         height: 80,
//         width: MediaQuery.of(context).size.width,
//         child: Padding(
//           padding: const EdgeInsets.only(left: 30),
//           child: Row(
//             children: [
//               Visibility(
//                 visible: isVisible,
//                 child: Row(
//                   children: [
//                     SizedBox(
//                       width:300,
//                       height: 47,
//                       child: TextField(
//                         controller: categoryTextController,
//                         decoration: const InputDecoration(
//                           focusedBorder: OutlineInputBorder(
//                             borderSide:
//                             BorderSide(color: Colors.black, width: 1),
//                           ),
//                           filled: true,
//                           fillColor: Colors.white,
//                           hintText: "No category name given",
//                           border: OutlineInputBorder(),
//                           contentPadding: EdgeInsets.only(left: 20),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(
//                       width: 10,
//                     ),
//                     AbsorbPointer(
//                       absorbing: true,
//                       child: SizedBox(
//                         width: 300,
//                         child: TextField(
//                           controller: fileNameTextController,
//                           decoration: const InputDecoration(
//                             focusedBorder: OutlineInputBorder(
//                               borderSide:
//                                   BorderSide(color: Colors.black, width: 1),
//                             ),
//                             filled: true,
//                             fillColor: Colors.white,
//                             hintText: "No Image Selected",
//                             border: OutlineInputBorder(),
//                             contentPadding: EdgeInsets.only(left: 20),
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(
//                       width: 10,
//                     ),
//                     ElevatedButton(
//                       style: ButtonStyle(
//                         backgroundColor: MaterialStateProperty.all(
//                             Theme.of(context).primaryColor),
//                       ),
//                       onPressed: () {
//                         uploadStorage();
//                       },
//                       child: const Text(
//                         "Upload Category",
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     ),
//                     const SizedBox(
//                       width: 10,
//                     ),
//                     AbsorbPointer(
//                       absorbing: imageSelected,
//                       child: ElevatedButton(
//                         style: ButtonStyle(
//                           backgroundColor: MaterialStateProperty.all(imageSelected
//                               ? Colors.black12
//                               : Theme.of(context).primaryColor),
//                         ),
//                         onPressed: () {
//                           if(categoryTextController.text.isEmpty){
//                             showAlert("No Category Name Given");
//                           }
//                           else{
//                             pr.show();
//                             services.uploadCategoryToDatabase(url,categoryTextController.text).then(
//                                   (value) {
//                                 if (value != null) {
//                                   pr.hide();
//                                   showAlert("Saved Category To Database");
//                                   fileNameTextController.text = "No Image Selected";
//                                 }
//                               },
//                             );
//                           }
//                         },
//                         child: const Text(
//                           "Save New Category",
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(
//                 width: 10,
//               ),
//               Visibility(
//                 visible: isVisible ? false : true,
//                 child: ElevatedButton(
//                   style: ButtonStyle(
//                     backgroundColor:
//                         MaterialStateProperty.all(Theme.of(context).primaryColor),
//                   ),
//                   onPressed: () {
//                     setState(() {
//                       isVisible = true;
//                     });
//                   },
//                   child: const Text(
//                     "Add New Category",
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   void uploadImage({required Function(File file) onSelected}) {
//     FileUploadInputElement uploadInput = FileUploadInputElement()
//       ..accept = 'image/*';
//     uploadInput.click();
//     uploadInput.onChange.listen((event) {
//       final file = uploadInput.files?.first;
//       final reader = FileReader();
//       reader.readAsDataUrl(file!);
//       reader.onLoadEnd.listen((event) {
//         onSelected(file);
//       });
//     });
//   }
//
//   void uploadStorage() {
//     final dateTime = DateTime.now();
//     final path = 'categoryImage/$dateTime';
//     uploadImage(onSelected: (file) {
//       if (file != null) {
//         setState(() {
//           fileNameTextController.text = file.name;
//           imageSelected = false;
//           url = path;
//         });
//         fb
//             .storage()
//             .refFromURL('gs://grocery-application-3329d.appspot.com')
//             .child(path)
//             .put(file);
//       }
//     });
//   }
// }

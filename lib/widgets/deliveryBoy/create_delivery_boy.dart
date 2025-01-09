import 'package:admin_website_grocery_app/services/firebase_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../constants.dart';

class CreateNewBoyWidget extends StatefulWidget {
  const CreateNewBoyWidget({Key? key}) : super(key: key);

  @override
  State<CreateNewBoyWidget> createState() => _CreateNewBoyWidgetState();
}

class _CreateNewBoyWidgetState extends State<CreateNewBoyWidget> {
  bool isVisible = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final FirebaseServices _services = FirebaseServices();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Visibility(
          visible: isVisible ? false : true,
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                isVisible = true;
              });
            },
            child: const Text("Create new Delivery boy"),
          ),
        ),
        Visibility(
          visible: isVisible,
          child: Expanded(
            child: Container(
              color: Colors.grey[200],
              width: MediaQuery.of(context).size.width,
              height: 80,
              child: Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: Row(
                  children: [
                    SizedBox(
                      width: 300,
                      child: TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1),
                          ),
                          hintText: "Email ID",
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.only(left: 20),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    SizedBox(
                      width: 300,
                      child: TextFormField(
                        controller: passwordController,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1),
                          ),
                          hintText: "Password",
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.only(left: 20),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        EasyLoading.show(status: "Saving Delivery boy's data");
                        if (emailController.text.isEmpty) {
                          return showAlert("Email Id not entered");
                        }
                        if (passwordController.text.isEmpty) {
                          return showAlert("Password not entered");
                        }
                        if (passwordController.text.length < 6) {
                          return showAlert("Minimum 6 Character");
                        }
                        _services
                            .saveDeliveryBoys(
                                emailController.text, passwordController.text)
                            .whenComplete(() {
                          emailController.clear();
                          passwordController.clear();
                          EasyLoading.showSuccess("Saved Successfully");
                        });
                      },
                      child: const Text("Save"),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

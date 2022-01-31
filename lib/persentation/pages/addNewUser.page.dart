import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:masarat/infrastructure/controllers/user.dart';

class AddNewUser extends StatefulWidget {
  const AddNewUser({Key? key}) : super(key: key);

  @override
  _AddNewUserState createState() => _AddNewUserState();
}

class _AddNewUserState extends State<AddNewUser> {
  TextEditingController fNameController = TextEditingController(text: "");
  TextEditingController lNameController = TextEditingController(text: "");
  TextEditingController companyName = TextEditingController(text: "");
  String? birthday;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Add new user",
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: fNameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'First Name',
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: lNameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Last Name',
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: companyName,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'company name',
                ),
              ),
              ElevatedButton(
                  onPressed: (){
                    DatePicker.showDatePicker(context,
                        showTitleActions: true,
                        minTime: DateTime(1990, 1, 1),
                        maxTime: DateTime(2010, 1, 1),
                        onConfirm: (date) {
                          birthday = DateFormat('dd MM yyyy').format(date).replaceAll("-", " ");
                        },
                        currentTime: DateTime.now()
                    );
                  },
                  child: Text("Pick your birthday")
              ),
              SizedBox(
                height: 40,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.green
                ),
                onPressed: (){
                  UserController.createNewUser(
                      fNameController.text,
                      lNameController.text,
                      birthday ??'',
                      companyName.text
                  );
                  Navigator.pop(context);
                },
                child: Text(
                  "Create User"
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

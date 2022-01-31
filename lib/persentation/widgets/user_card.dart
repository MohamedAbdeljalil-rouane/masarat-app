import 'package:flutter/material.dart';


class UserCard extends StatelessWidget {
  String firstName;
  String lastName;
  String company;
  int age;
  int userId;
  VoidCallback onDelete;

  UserCard({
    required this.firstName,
    required this.lastName,
    required this.userId,
    required this.company,
    required this.age,
    required this.onDelete
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 2.0,
                spreadRadius: 0.0,
                offset: Offset(2.0, 2.0), // shadow direction: bottom right
              )
            ],
          ),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  firstName,
                  style: TextStyle(
                    color: age < 18 ? Colors.red : Colors.black
                  )
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  lastName,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: age < 18 ? Colors.red : Colors.black,
                      fontSize: 15
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  age.toString(),
                    style: TextStyle(
                        color: age < 18 ? Colors.red : Colors.black
                    )
                ),
              ),
              TextButton(
                  onPressed: onDelete,
                  child: Text(
                      "Delete",
                    style: TextStyle(
                      color: Colors.red
                    ),
                  ),

              )
            ],
          )
      ),
    );
  }
}

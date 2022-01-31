import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:masarat/infrastructure/controllers/user.dart';
import 'package:masarat/infrastructure/models/User.dart';
import 'package:masarat/persentation/pages/serach.page.dart';
import 'package:masarat/persentation/widgets/user_card.dart';

import 'addNewUser.page.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Future <List<User>>? users;
  int pageNumber = 1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    users = UserController.getUsersByPageNumber(pageNumber);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddNewUser()));
        },
        child: Icon(
          Icons.add
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
        child: SafeArea(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Pages",
                    style: TextStyle(
                      fontSize: 18
                    ),
                  ),
                  TextButton(
                      onPressed: (){
                        setState(() {
                          pageNumber += 1;
                          users = UserController.getUsersByPageNumber(pageNumber);
                        });
                      },
                      child: Text("Next")
                  ),
                  TextButton(
                      onPressed: (){
                        if(pageNumber != 1){
                          setState(() {
                            pageNumber -= 1;
                            users = UserController.getUsersByPageNumber(pageNumber);
                          });
                        }

                      },
                      child: Text("Back")
                  ),
                  ElevatedButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchPage()));
                      },
                      child: Icon(
                        Icons.search
                      )
                  )
                ],
              ),
              FutureBuilder<List<User>>(
                future: users,
                builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot){
                  if(snapshot.hasData){
                    snapshot.data!.toList().sort((user1, user2) => user1.age.compareTo(user2.age));
                    return SizedBox(
                      height: 650,
                      child: ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, int index){
                          return UserCard(
                            lastName: snapshot.data![index].lName,
                            firstName: snapshot.data![index].fName,
                            userId: snapshot.data![index].userId,
                            company: snapshot.data![index].company,
                            age: snapshot.data![index].age,
                            onDelete: (){
                              UserController.deleteUser(snapshot.data![index].userId);
                              setState(() {
                                users = UserController.getUsersByPageNumber(pageNumber);
                              });
                            },
                          );
                      }
                      ),
                    );
                  }else{

                    return Container(
                      color: Colors.blue,
                    );
                  }
                },

              ),
            ],
          )
        ),
      )
    );
  }
}

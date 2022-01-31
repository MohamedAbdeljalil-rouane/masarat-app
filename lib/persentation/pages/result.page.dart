import 'package:flutter/material.dart';
import 'package:masarat/infrastructure/controllers/user.dart';
import 'package:masarat/infrastructure/models/User.dart';
import 'package:masarat/persentation/widgets/user_card.dart';

class ResultPage extends StatefulWidget {

  final String filter;
  ResultPage({Key? key, required this.filter}) : super(key: key);

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {

  Future <List<User>>? images;

  @override
  Widget build(BuildContext context) {
    images = UserController.searchByTerm(widget.filter);
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<List<User>>(
          future: images,
          builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot){
            if(snapshot.hasData){
              return SizedBox(
                height: 600,
                child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index){
                      return UserCard(
                        userId: snapshot.data![index].userId,
                        lastName: snapshot.data![index].lName,
                        firstName: snapshot.data![index].fName,
                        company: snapshot.data![index].company,
                        age: snapshot.data![index].age,
                        onDelete: (){
                          UserController.deleteUser(snapshot.data![index].userId);
                          setState(() {

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
      ),
    );
  }
}

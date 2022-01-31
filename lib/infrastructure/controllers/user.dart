import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:masarat/infrastructure/models/User.dart';

class UserController{

  static String usersUrl = "https://retoolapi.dev/H0t1zB/posts";


  static Future<List<User>> getAllUsers() async {
    final response = await http
        .get(Uri.parse(usersUrl));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => User.fromJson(data)).toList();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load users');
    }
  }

  static Future<List<User>> getUsersByPageNumber(int pageNumber) async{
    final String pageUrl = usersUrl + "?_page=" + pageNumber.toString();

    final response = await http
        .get(Uri.parse(pageUrl));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => User.fromJson(data)).toList();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load users');
    }
  }

  static Future<List<User>> searchByTerm(String term) async{
    final String results = usersUrl + "?prenom=" + term;

    final response = await http
        .get(Uri.parse(results));


    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => User.fromJson(data)).toList();
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load users');
    }
  }


  static Future deleteUser(int userId) async{
    final String results = usersUrl + "/" + userId.toString();

    final response = await http
        .delete(Uri.parse(results));


    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.


      print({"message":"user deleted successfully"}) ;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to delete user');
    }
  }

  static Future createNewUser(String fName, String lName, String birthDay, String company) async {

    final response = await http
        .post(
        Uri.parse(usersUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "nom": lName,
        "prenom": fName,
        "date de naissance": birthDay,
        "entreprise": company
      })
    );

    if (response.statusCode == 201) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

      print({"message": "Data created successfully"});
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to create user');
    }
  }

}
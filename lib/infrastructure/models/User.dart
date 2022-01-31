class User{
  final String lName;
  final String fName;
  final int age;
  final String company;
  final int userId;

  User({
    required this.lName,
    required this.fName,
    required this.age,
    required this.company,
    required this.userId
  });

  factory User.fromJson(Map<String, dynamic> json) {
    List date = json['date de naissance'].toString().split(" ");
    return User(
      fName: json['prenom'],
      lName: json['nom'],
      age: 2022 - int.parse(json['date de naissance'].toString().split(" ")[2]),
      company: json["entreprise"],
      userId: json["id"]
    );
  }
}
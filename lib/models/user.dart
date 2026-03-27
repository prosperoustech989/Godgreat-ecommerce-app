import 'dart:convert';

class User {
  //Define fields
  final String id;
  final String fullName;
  final String email;
  final String state;
  final String city;
  final String locality;
  final String password;
  final String token;

  User({
    required this.id,
    required this.fullName,
    required this.email,
    required this.state,
    required this.city,
    required this.locality,
    required this.password,
    required this.token,
  });

  //Serialization:Covert User object to a map
  // Map: A map is a collection of key-value pairs
  //Why: converting to a map is an intermediate step that makes it easier to serialize
  //the object to formates like json for storage or transmission

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      'fullName': fullName,
      'email': email,
      'state': state,
      'city': city,
      'locality': locality,
      'password': password,
      'token': token,
    };
  }
  //Serialization:Covert Map to a json string
  //This method directly encodes the data from the Map into a json string
  //The json.encode() function  coverts a Dart object (such as Map or list)
  //into a json String representation , making it suitable for communication
  //between different systems.

  String tojson() => jsonEncode(toMap());

  //Deserialization: covert a Map to User object
  //purpose - Manipulation and user : once the data is coverted into a user object
  // it can be easily manipulated and use within the application . for example
  // we might want to display the user's fullName, fulName, email etc on the Ui. or we might
  //want to save the data locally.

  // the factory contructor takes a Map (usally obtained from a json object)
  ///and convert it into a User object.if a field is not present in the Map ,
  ///it defaults to an empty string

  //fromMap: This constructor take a Map<String, dynamic> and coverts into a user object
  //.its useful when you already have the data in map format
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] as String? ?? "",
      fullName: map['fullName'] as String? ?? "",
      email: map['email'] as String? ?? "",
      state: map['state'] as String? ?? "",
      city: map['city'] as String? ?? "",
      locality: map['locality'] as String? ?? "",
      password: map['password'] as String? ?? "",
      token: map['token'] as String? ?? "",
    );
  }

  //fromJson: This factory contructor takes Json String , and decodes into a Map<String.dynamic>
  //and then uses fromMap to convert that Map into a User object.
  factory User.fromJson(String source) =>
      User.fromMap(jsonDecode(source) as Map<String, dynamic>);
}

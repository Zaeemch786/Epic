import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/utills/formatters/formatters.dart';

class UserModel {
  final String id;
  String firstName;
  String lastName;
  final String username;
  final String email;
  String phoneNumber;
  String profilePicture;

  UserModel(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.username,
      required this.email,
      required this.phoneNumber,
      required this.profilePicture});
  String get fullName => '$firstName $lastName';
  String get formattedPhoneNo => TFormatter.formatePhoneNumber(phoneNumber);

  static List<String> nameParts(fullName) => fullName.split(" ");
  static String generateUsername(fullName) {
    List<String> nameParts = fullName.split(" ");
    String firstName = nameParts[0].toLowerCase();
    String lastName = nameParts.length > 1 ? nameParts[1].toLowerCase() : "";
    String camelCaseUsername = "$firstName$lastName";
    // ignore: unnecessary_string_interpolations
    String usernameWithPrefix = "$camelCaseUsername";
    return usernameWithPrefix;
  }

  static UserModel empty() => UserModel(
      id: '',
      firstName: '',
      lastName: '',
      username: '',
      email: '',
      phoneNumber: '',
      profilePicture: '');
  Map<String, dynamic> toJson() {
    return {
      'FirstName': firstName,
      'lastName': lastName,
      'Username': username,
      'Email': email,
      'PhoneNumber': phoneNumber,
      'ProfilePicture': profilePicture,
    };
  }

  factory UserModel.fromsnapshot(
      DocumentSnapshot<Map<String, dynamic>> doccument) {
    if (doccument.data() != null) {
      final data = doccument.data()!;
      return UserModel(
          id: doccument.id,
          firstName: data['FirstName'] ?? '',
          lastName: data['lastName'] ?? '',
          username: data['Username'] ?? '',
          email: data['Email'] ?? '',
          phoneNumber: data['PhoneNumber'] ?? '',
          profilePicture: data['ProfilePicture'] ?? '');
    }
    return UserModel.empty();
  }
}

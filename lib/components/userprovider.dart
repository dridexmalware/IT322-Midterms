import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserData extends ChangeNotifier {
  String? firstName;
  String? lastName;


  readData (String firstname, String lastname ) async{
    firstName = firstname;
    lastName = lastname;
    await Supabase.instance.client
        .from('useracc')
        .select()
        .eq('firstname', firstName as Object)
        .eq('lastname', lastName as Object);
        notifyListeners();
  }
}


class UserProvider extends ChangeNotifier {
  String userName;
  String lastName;
  String firstName;
  String email;
  String phoneNumber;
  String password;

  UserProvider({
    this.userName = "YAWAAA",
    this.lastName = "Jaranilla",
    this.firstName = "Yul Jhon",
    this.email = "yuljhonjaranilla@gmail.com",
    this.password = "yulskie",
    this.phoneNumber = "09696969696"
  });

  void changeUserName ({
    required String newUserName,
  }) async {
    userName = newUserName;
    notifyListeners();
  }

  void changeLastName ({
    required String newLastName,
  }) async {
    lastName = newLastName;
    notifyListeners();
  }

  void changeFirstName ({
    required String newFirstName,
  }) async {
    firstName = newFirstName;
    notifyListeners();
  }

  void changeFullName ({
    required String newFirstName,
    required String newLastName,
  }) async {
    firstName = newFirstName;
    lastName = newLastName;
    notifyListeners();
  }

  void changeEmail ({
    required String newEmail,
  }) async {
    email = newEmail;
    notifyListeners();
  }

  void changePhoneNumber ({
    required String newPhoneNumber,
  }) async {
    phoneNumber = newPhoneNumber;
    notifyListeners();
  }

  void changePassword ({
    required String newPassword,
  }) async {
    password = newPassword;
    notifyListeners();
  }

  
}
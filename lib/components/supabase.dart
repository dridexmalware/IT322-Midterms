import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseHandler {


  void addData(String firstName, String lastName, String username, String email,
      String password, String phoneNumber) async {
    await Supabase.instance.client.from('useracc').upsert([
      {
        'firstname': firstName,
        'lastname': lastName,
        'username': username,
        'email': email,
        'password': password,
        'phonenumber': phoneNumber,
      }
    ]);
  }

  readData (String firtName, String lastName ) async{
    await Supabase.instance.client
        .from('useracc')
        .select()
        .eq('firstname', firtName)
        .eq('lastname', lastName);
  }

}

import 'package:cloud_firestore/cloud_firestore.dart';

Future<void>saveUserData(String userId, String email, String username)async{
  try{
  await FirebaseFirestore.instance.collection('users').doc(userId).set({
   'email': email,
    'username': username
  });
  }catch(e){
    print('Error saving user data: $e');
  }
}
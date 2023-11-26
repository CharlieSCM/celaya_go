import 'package:firebase_auth/firebase_auth.dart';

class FirebaseUser{
  String? uid;
  String? name;
  String? email;
  String? imageUrl;

  set user(User? user){
    uid = user?.uid;
    
    name= user?.displayName;

    email = user?.email;

    imageUrl = user?.photoURL;
  }

  String? get _uid => _uid;
  String? get _name => _name;
  String? get _email => _email;
  String? get _imageUrl => imageUrl;

}
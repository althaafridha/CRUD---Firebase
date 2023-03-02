import 'package:firebase_auth/firebase_auth.dart';

class AuthController{
  FirebaseAuth auth = FirebaseAuth.instance;

  Stream<User?> get user => auth.authStateChanges();
}

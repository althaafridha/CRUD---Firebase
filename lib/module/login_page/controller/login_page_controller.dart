import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:latihan_crud_firebase/core.dart';

class LoginPageController extends State<LoginPageView>
    implements MvcController {
  static late LoginPageController instance;
  late LoginPageView view;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();


  bool secureText = true;

  final auth = FirebaseAuth.instance;


  @override
  void initState() {
    instance = this;
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);

  login(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      print("berhasil login");
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const HomePageView()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  register() {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => const RegisterPageView()));
  }

  showHide() {
    setState(() {
      secureText = !secureText;
    });
  }
  
}

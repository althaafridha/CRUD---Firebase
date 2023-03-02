import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:latihan_crud_firebase/core.dart';

class RegisterPageController extends State<RegisterPageView>
    implements MvcController {
  static late RegisterPageController instance;
  late RegisterPageView view;

  final key = GlobalKey<FormState>();

  TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();

  bool secureTextPass = true;
  bool secureTextConfirmPass = true;

  @override
  void initState() {
    instance = this;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.build(context, this);

  login() {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => const LoginPageView()));
  }

  checkingField() {
    checkEmail();
    if (passwordController.text.length < 6) {
      print("Password kurang dari 6 karakter");
      return ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Password kurang dari 6 karakter"),
          duration: Duration(seconds: 1),
        ),
      );
    } else if (passwordController.text != confirmPassController.text) {
      print("Password tidak sama");
      return ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Password dan Confirm Password tidak sama"),
          duration: Duration(seconds: 1),
        ),
      );
    } else {
      if (key.currentState!.validate()) {
        register();
      }
    }
  }

  Future register() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => const HomePageView()));
    } catch (e) {
      print(e.toString());
    }
  }

  showHidePassword() {
    setState(() {
      secureTextPass = !secureTextPass;
    });
  }

  showHideConfirmPassword() {
    setState(() {
      secureTextConfirmPass = !secureTextConfirmPass;
    });
  }

  checkEmail() {
    if (!emailController.text.contains("@")) {
      return "Email tidak valid";
    } else if (emailController.text ==
        FirebaseAuth.instance.currentUser?.email) {
      return ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Email sudah terdaftar"),
        duration: Duration(seconds: 1),
      ));
    }
  }
}

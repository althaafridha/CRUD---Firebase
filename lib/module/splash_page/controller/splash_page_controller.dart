import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:latihan_crud_firebase/core.dart';


class SplashPageController extends State<SplashPageView>
    implements MvcController {
  static late SplashPageController instance;
  late SplashPageView view;

  @override
  void initState() {
    instance = this;
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      if (FirebaseAuth.instance.currentUser == null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const LoginPageView()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const HomePageView()));
      }
    });
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}

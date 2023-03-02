import 'package:flutter/material.dart';
import 'package:latihan_crud_firebase/core.dart';
import '../controller/splash_page_controller.dart';

class SplashPageView extends StatefulWidget {
  const SplashPageView({Key? key}) : super(key: key);

  Widget build(context, SplashPageController controller) {
    controller.view = this;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.book, size: 100, color: Colors.blue,),
            SizedBox(height: 20),
            Text(
              'CRUD Firebase',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        )
        ),
    );
  }

  @override
  State<SplashPageView> createState() => SplashPageController();
}
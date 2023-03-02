import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:latihan_crud_firebase/core.dart';
import 'package:latihan_crud_firebase/utils/utils.dart';
import '../controller/login_page_controller.dart';

class LoginPageView extends StatefulWidget {


  
  const LoginPageView({Key? key}) : super(key: key);

  Widget build(context, LoginPageController controller) {
    controller.view = this;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Login',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            'Silahkan login untuk melanjutkan',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),
          ),
          const SizedBox(height: 100),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: loginRegisterBoxDecoration,
              child: TextFormField(
                controller: controller.emailController,
                decoration: const InputDecoration(
                  hintText: 'Email',
                  border: InputBorder.none
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: loginRegisterBoxDecoration,
              child: TextFormField(
                controller: controller.passwordController,
                obscureText: controller.secureText,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                          onPressed: controller.showHide,
                          icon: Icon(controller.secureText
                              ? Icons.visibility_off
                              : Icons.visibility)),
                  hintText: 'Password',
                  border: InputBorder.none
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
          MaterialButton(
            onPressed: () => controller.login(
              controller.emailController.text,
              controller.passwordController.text,),
            child: buttonAsset("Login",),
          ),
          const SizedBox(height: 25),
          RichText(
            text: TextSpan(
              text: 'Belum punya akun? ',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
              children: [
                TextSpan(
                  text: 'Daftar',
                  style: const TextStyle(
                    color: Colors.blue,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => controller.register(),
                ),
              ],
            ),
            ),
        ],
      )
    );
  }

  @override
  State<LoginPageView> createState() => LoginPageController();
}
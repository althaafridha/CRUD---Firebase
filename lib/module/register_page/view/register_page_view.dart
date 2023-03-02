import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:latihan_crud_firebase/core.dart';
import 'package:latihan_crud_firebase/utils/utils.dart';
import '../controller/register_page_controller.dart';

class RegisterPageView extends StatefulWidget {
  const RegisterPageView({Key? key}) : super(key: key);

  Widget build(context, RegisterPageController controller) {
    controller.view = this;

    return Scaffold(
      resizeToAvoidBottomInset: false,
        body: Form(
      key: controller.key,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Register',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            'Silahkan buat akun untuk melanjutkan',
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
                validator: (value) =>
                    value!.isEmpty ? 'Username tidak boleh kosong' : null,
                controller: controller.usernameController,
                decoration: const InputDecoration(
                    hintText: 'Username', border: InputBorder.none),
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
                validator: (value) =>
                    value!.isEmpty ? 'Email tidak boleh kosong' : null,
                controller: controller.emailController,
                decoration: const InputDecoration(
                    hintText: 'Email', border: InputBorder.none),
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
                obscureText: controller.secureTextPass,
                validator: (value) =>
                    value!.isEmpty ? 'Password tidak boleh kosong' : null,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                          onPressed: controller.showHidePassword,
                          icon: Icon(controller.secureTextPass
                              ? Icons.visibility_off
                              : Icons.visibility)),
                    hintText: 'Password', border: InputBorder.none),
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
                controller: controller.confirmPassController,
                obscureText: controller.secureTextConfirmPass,
                validator: (value) => value!.isEmpty
                    ? 'Confirm Password tidak boleh kosong'
                    : null,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                          onPressed: controller.showHideConfirmPassword,
                          icon: Icon(controller.secureTextConfirmPass
                              ? Icons.visibility_off
                              : Icons.visibility)),
                    hintText: 'Confirm Password', border: InputBorder.none),
              ),
            ),
          ),
          const SizedBox(height: 40),
          MaterialButton(
            onPressed: () => controller.checkingField(),
            child: buttonAsset("Daftar"),
          ),
          const SizedBox(height: 25),
          RichText(
            text: TextSpan(
              text: 'Sudah Mempunyai Akun? ',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
              children: [
                TextSpan(
                  text: 'Masuk',
                  style: const TextStyle(
                    color: Colors.blue,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => controller.login(),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }

  @override
  State<RegisterPageView> createState() => RegisterPageController();
}

import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddDataPageView extends StatefulWidget {
  const AddDataPageView({super.key});

  @override
  State<AddDataPageView> createState() => _AddDataPageViewState();
}

class _AddDataPageViewState extends State<AddDataPageView> {
  File? _image;
  late User? _user;
  late StreamSubscription<User?> _userSubscription;

  final picker = ImagePicker();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Future getImage() async {
    final pickedFile = await picker.pickImage(
        source: ImageSource.gallery, maxWidth: 1080, maxHeight: 1920);

    setState(() {
      _image = File(pickedFile!.path);
    });
  }

  final controllerTitle = TextEditingController();
  final controllerDeskription = TextEditingController();
  final controllerPrice = TextEditingController();
  @override
  void initState() {
    super.initState();
    _userSubscription = FirebaseAuth.instance.authStateChanges().listen((user) {
      setState(() {
        _user = user;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Add Data'),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new_outlined)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16.0),
                GestureDetector(
                  onTap: getImage,
                  child: Container(
                    height: 200.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: _image == null
                        ? const Icon(
                            Icons.camera_alt,
                            color: Colors.grey,
                            size: 50.0,
                          )
                        : Image.file(_image!, fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: controllerTitle,
                  decoration: InputDecoration(
                    filled: true,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    fillColor: const Color(0xffF2F2F2),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            width: 0, style: BorderStyle.none)),
                    hintText: 'Title',
                  ),
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Harap isi judul';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: controllerDeskription,
                  decoration: InputDecoration(
                    hintText: 'Deskripsi',
                    filled: true,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    fillColor: const Color(0xffF2F2F2),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            width: 0, style: BorderStyle.none)),
                  ),
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Harap isi deskripsi';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16.0,
                ),
                const SizedBox(height: 16.0),
                SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate() &&
                          _image != null &&
                          _user != null) {
                        FirebaseStorage storage = FirebaseStorage.instance;
                        Reference ref = storage
                            .ref()
                            .child("${DateTime.now()}.jpg");
                        UploadTask uploadTask = ref.putFile(_image!);
                        TaskSnapshot taskSnapshot =
                            await uploadTask.whenComplete(() => null);
                        String imageUrl =
                            await taskSnapshot.ref.getDownloadURL();

                        FirebaseFirestore firestore =
                            FirebaseFirestore.instance;
                        CollectionReference content =
                            firestore.collection('data');

                        await content.add({
                          'image': imageUrl,
                          'title': controllerTitle.text,
                          'description': controllerDeskription.text,
                          'userId': _user!.uid,
                        });

                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: Colors.red,
                            content: Text('Gagal mengupload data'),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(primary: Colors.blue),
                    child: const Text('Add Data'),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _userSubscription.cancel();
  }
}
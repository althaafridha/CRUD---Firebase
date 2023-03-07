import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditPageDataView extends StatefulWidget {

  final dynamic data;
  final String id;

    const EditPageDataView({Key? key, required this.data, required this.id}) : super(key: key);

  @override
  State<EditPageDataView> createState() => _EditPageDataViewState();
}

class _EditPageDataViewState extends State<EditPageDataView> {
  File? _image;
  late User? _user;
  late StreamSubscription<User?> _userSubscription;

  final picker = ImagePicker();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  Future getImage() async {
    final pickedFile = await picker.pickImage(
        source: ImageSource.gallery, maxWidth: 1080, maxHeight: 1920);

    setState(() {
      _image = File(pickedFile!.path);
    });
  }

  var controllerTitle = TextEditingController();
  var controllerDeskription = TextEditingController();
  @override
  void initState() {
    super.initState();
    controllerDeskription.text = widget.data['description'];
    controllerTitle.text = widget.data['title'];

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
        title: const Text('Edit Data'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
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
                        ? (widget.data['image'] == null
                            ? const Icon(
                                Icons.camera_alt,
                                color: Colors.grey,
                                size: 50.0,
                              )
                            : Image.network(widget.data['image'],
                                fit: BoxFit.cover))
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
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_key.currentState!.validate() &&
                          _image != null &&
                          _user != null) {
                        FirebaseStorage storage = FirebaseStorage.instance;
                        Reference ref = storage
                            .ref()
                            .child(DateTime.now().toString() + ".jpg");
                        UploadTask uploadTask = ref.putFile(_image!);
                        TaskSnapshot taskSnapshot =
                            await uploadTask.whenComplete(() => null);
                        String imageUrl =
                            await taskSnapshot.ref.getDownloadURL();

                        FirebaseFirestore firestore =
                            FirebaseFirestore.instance;
                        CollectionReference content =
                            firestore.collection('data');

                        DocumentReference<Map<String, dynamic>> editContent =
                            firestore.collection("data").doc(widget.id);
                        await editContent.update({
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
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                    child: const Text('Update Data'),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () async {
                      FirebaseFirestore firestore =
                          FirebaseFirestore.instance;
                      CollectionReference content =
                          firestore.collection('data');

                      DocumentReference<Map<String, dynamic>> editContent =
                          firestore.collection("data").doc(widget.id);
                      await editContent.delete();

                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: const Text('Delete Data'),
                  ),
                )
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
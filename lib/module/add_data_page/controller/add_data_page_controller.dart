import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latihan_crud_firebase/core.dart';
import 'package:latihan_crud_firebase/module/add_data_page/widget/save.dart';

class AddDataPageController extends GetxController {
  AddDataPageView? view;
  SaveData? saveData;

  File? image;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  save() async {
    var title = titleController.text;
    var description = descriptionController.text;
    var image = this.image ?? "";

    await FirebaseFirestore.instance.collection('data').add({
      'title': title,
      'description': description,
      'image': image,
    });
  }

  Future getImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? imagePicked =
        await _picker.pickImage(source: ImageSource.gallery);
    image = File(imagePicked!.path);
    update();
  }
}

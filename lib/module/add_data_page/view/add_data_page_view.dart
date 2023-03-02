import 'package:flutter/material.dart';
import 'package:latihan_crud_firebase/utils/utils.dart';
import '../controller/add_data_page_controller.dart';
import 'package:latihan_crud_firebase/core.dart';
import 'package:get/get.dart';

class AddDataPageView extends StatelessWidget {
  const AddDataPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddDataPageController>(
      init: AddDataPageController(),
      builder: (controller) {
        controller.view = this;

        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: const Text("Add Data"),
          ),
          body: Container(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                GestureDetector(
                    onTap: () async {
                      await controller.getImage();
                    },
                    child: 
                    // controller.getImage() != null
                    //     ? Container(
                    //         height: 250,
                    //         width: double.infinity,
                    //         decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.circular(10),
                    //           color: Color(0XFFF2F2F2),
                    //           border: Border.all(color: Colors.grey, width: 1),
                    //         ),
                    //         child: Image.file(controller.image!,
                    //             fit: BoxFit.cover))
                        Container(
                            height: 250,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0XFFF2F2F2),
                              border: Border.all(color: Colors.grey, width: 1),
                            ),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    "Upload Photo",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Icon(
                                    Icons.cloud_upload_rounded,
                                    size: 25,
                                    color: Colors.grey,
                                  ),
                                ]),
                          )),
                const SizedBox(height: 40),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: loginRegisterBoxDecoration,
                  child: TextFormField(
                    controller: controller.titleController,
                    maxLines: 1,
                    decoration: const InputDecoration(
                      hintText: "Title",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  height: 200,
                  padding: const EdgeInsets.all(10),
                  decoration: loginRegisterBoxDecoration,
                  child: TextFormField(
                    controller: controller.descriptionController,
                    decoration: const InputDecoration(
                      hintText: "Description",
                      border: InputBorder.none,
                    ),
                  ),
                )
              ],
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(bottom: 35),
            child: MaterialButton(onPressed: () {
              controller.save();
            }, child: buttonAsset("Save")),
          ),
        );
      },
    );
  }
}

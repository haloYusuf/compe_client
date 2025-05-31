import 'package:compe_client/core/utils/constant.dart';
import 'package:compe_client/app/modules/create_group/controllers/create_group_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CreateGroupView extends GetView<CreateGroupController> {
  const CreateGroupView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create Group',
          style: TextStyle(
            fontFamily: Constant.fontHeading,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          onPressed: controller.handleBack,
          icon: Icon(
            Icons.arrow_back_ios,
            size: 24,
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: 12,
                children: [
                  TextField(
                    controller: controller.groupNameController,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: 'Group Name',
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 2,
                        horizontal: 8,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  TextField(
                    controller: controller.maxMemberController,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      labelText: 'Max. Member',
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 2,
                        horizontal: 8,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Pilih Image',
                    style: TextStyle(
                      fontFamily: Constant.fontHeading,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Obx(
                    () => Container(
                      height: 150,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                      ),
                      child: controller.imageFile != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.file(
                                controller.imageFile!,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Center(
                              child: Text(
                                'Belum ada gambar yang dipilih!',
                                style: TextStyle(
                                  fontFamily: Constant.fontContent,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        icon: Icon(Icons.photo_library),
                        label: Text(
                          "Gallery",
                          style: TextStyle(
                            fontFamily: Constant.fontContent,
                          ),
                        ),
                        onPressed: () async => controller.pickImage(
                          source: ImageSource.gallery,
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      ElevatedButton.icon(
                        icon: Icon(Icons.camera_alt),
                        label: Text(
                          "Camera",
                          style: TextStyle(
                            fontFamily: Constant.fontContent,
                          ),
                        ),
                        onPressed: () async => controller.pickImage(
                          source: ImageSource.camera,
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  ElevatedButton(
                    onPressed: () async => controller.handleCreateGroup(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF7161EF),
                      padding: EdgeInsets.all(8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Create Group',
                      style: TextStyle(
                        fontFamily: Constant.fontHeading,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

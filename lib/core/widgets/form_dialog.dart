import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FormDialog {
  static Future<String?> showGroupIdInputDialog({
    String title = 'Masukkan ID Grup',
    String hintText = 'Contoh: GRUP-123XYZ',
    String confirmButtonText = 'Kirim',
    String cancelButtonText = 'Batal',
    required TextEditingController controller,
    required Function() onNext,
  }) async {
    return await Get.dialog<String?>(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20.0),
              TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: hintText,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                ),
                autofocus: true,
              ),
              const SizedBox(height: 25.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextButton(
                    child: Text(cancelButtonText),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                  const SizedBox(width: 8.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                    ),
                    child: Text(confirmButtonText),
                    onPressed: () {
                      if (controller.text.isNotEmpty) {
                        if (Get.isDialogOpen ?? false) {
                          Get.back();
                        }
                        onNext();
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: true, // Bisa ditutup dengan tap di luar
    );
  }
}

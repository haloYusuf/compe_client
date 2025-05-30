import 'package:compe_client/core/utils/constant.dart';
import 'package:compe_client/modules/detail/controllers/detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailView extends GetView<DetailController> {
  const DetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          controller.getInitData().compeName,
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
      body: Center(
        child: Obx(() {
          if (controller.getIsLoading()) {
            return CircularProgressIndicator();
          } else {
            if (controller.getIsError()) {
              return Column(
                spacing: 12,
                children: [
                  Text('Gagal Mendapatkan Data!'),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Coba Lagi'),
                  ),
                ],
              );
            } else {
              return Text(
                controller.getCompeData()?.compeStatus.toString() ?? 'Kosong',
              );
            }
          }
        }),
      ),
    );
  }
}

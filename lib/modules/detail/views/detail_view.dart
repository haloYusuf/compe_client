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
      body: Obx(
        () {
          if (controller.getIsLoading()) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (controller.getIsError() || controller.getCompeData() == null) {
              return Center(
                child: Column(
                  spacing: 12,
                  children: [
                    Text('Gagal Mendapatkan Data!'),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('Coba Lagi'),
                    ),
                  ],
                ),
              );
            } else {
              return Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                        bottom: 12,
                        left: 12,
                        right: 12,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 12,
                          children: [
                            Image.network(
                              controller.getCompeData()!.compeImg,
                              width: double.infinity,
                              height: 250,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  '${Constant.assetImage}/default.jpg',
                                  height: 250,
                                  fit: BoxFit.cover,
                                );
                              },
                            ),
                            Text(
                              controller.getCompeData()!.compeName,
                              style: TextStyle(
                                fontFamily: Constant.fontHeading,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 4,
                                horizontal: 12,
                              ),
                              decoration: BoxDecoration(
                                color:
                                    controller.getCompeData()!.compeStatus == 0
                                        ? Color(0xFF7161EF)
                                        : Colors.red,
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: Text(
                                controller.getCompeData()!.compeStatus == 0
                                    ? 'Opened'
                                    : 'Closed',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: Constant.fontHeading,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              margin: EdgeInsets.symmetric(vertical: 6),
                              height: 2,
                              color: Colors.black,
                            ),
                            Text(
                              'Description :',
                              style: TextStyle(
                                fontFamily: Constant.fontHeading,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.white,
                              ),
                              child: Text(
                                controller.getCompeData()!.compeDesc,
                                style: TextStyle(
                                  fontFamily: Constant.fontContent,
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Information :',
                              style: TextStyle(
                                fontFamily: Constant.fontHeading,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.white,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                spacing: 8,
                                children: [
                                  Text(
                                    'Max Participants\t: ${controller.getCompeData()!.maxParticipant}',
                                    style: TextStyle(
                                      fontFamily: Constant.fontContent,
                                      fontSize: 12,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    'Created\t: ${controller.getCompeData()!.createdAt}',
                                    style: TextStyle(
                                      fontFamily: Constant.fontContent,
                                      fontSize: 12,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    'Start Date\t: ${controller.getCompeData()!.compeDate}',
                                    style: TextStyle(
                                      fontFamily: Constant.fontContent,
                                      fontSize: 12,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(
                            (0.1 * 255).round(),
                          ),
                          spreadRadius: 0,
                          blurRadius: 4,
                          offset: Offset(1, -2),
                        ),
                      ],
                    ),
                    child: Row(
                      spacing: 8,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                vertical: 12,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              backgroundColor: Color(0xFF7161EF),
                            ),
                            child: Text(
                              'Gabung Kelompok',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                vertical: 12,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              backgroundColor: Color(0xFFFFBF1A),
                            ),
                            child: Text(
                              'Buat Kelompok',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
          }
        },
      ),
    );
  }
}

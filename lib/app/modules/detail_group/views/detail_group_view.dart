import 'package:compe_client/app/modules/detail_group/controllers/detail_group_controller.dart';
import 'package:compe_client/core/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailGroupView extends GetView<DetailGroupController> {
  const DetailGroupView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          controller.getInitData().groupModel.groupName,
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
        child: Obx(
          () {
            if (controller.getIsLoading()) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (controller.getIsError()) {
              return Center(
                child: Column(
                  spacing: 12,
                  children: [
                    Text('Gagal Mendapatkan Data!'),
                    ElevatedButton(
                      onPressed: () => controller.handleGetData(groupId: controller.getInitData().groupModel.groupId),
                      child: Text('Coba Lagi'),
                    ),
                  ],
                ),
              );
            } else {
              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        spacing: 18,
                        children: [
                          Image.network(
                            controller.getDetailGroupData()!.groupImg,
                            width: double.infinity,
                            height: 300,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                '${Constant.assetImage}/default.jpg',
                                height: 250,
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              right: 12,
                              left: 12,
                              bottom: 6,
                            ),
                            child: Column(
                              spacing: 12,
                              children: [
                                Text(
                                  controller.getDetailGroupData()!.groupName,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: Constant.fontHeading,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 6,
                                    horizontal: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.green,
                                  ),
                                  child: Text(
                                    controller
                                                .getDetailGroupData()!
                                                .groupStatus ==
                                            0
                                        ? 'Pending'
                                        : controller
                                                    .getDetailGroupData()!
                                                    .groupStatus ==
                                                1
                                            ? 'Accepted'
                                            : 'Rejected',
                                    style: TextStyle(
                                      fontFamily: Constant.fontHeading,
                                      fontSize: 12,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Max Members : ',
                                      style: TextStyle(
                                        fontFamily: Constant.fontContent,
                                        fontSize: 12,
                                      ),
                                    ),
                                    Text(
                                      controller
                                          .getDetailGroupData()!
                                          .maxMember
                                          .toString(),
                                      style: TextStyle(
                                        fontFamily: Constant.fontContent,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Created : ',
                                      style: TextStyle(
                                        fontFamily: Constant.fontContent,
                                        fontSize: 12,
                                      ),
                                    ),
                                    Text(
                                      controller
                                          .getDetailGroupData()!
                                          .groupCreatedAt,
                                      style: TextStyle(
                                        fontFamily: Constant.fontContent,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Competition : ',
                                      style: TextStyle(
                                        fontFamily: Constant.fontContent,
                                        fontSize: 12,
                                      ),
                                    ),
                                    Text(
                                      controller
                                          .getDetailGroupData()!
                                          .compeName,
                                      style: TextStyle(
                                        fontFamily: Constant.fontContent,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 1,
                                  color: Colors.black,
                                ),
                                Text(
                                  'Group Leader',
                                  style: TextStyle(
                                    fontFamily: Constant.fontContent,
                                    fontSize: 12,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    spacing: 8,
                                    children: [
                                      Text(
                                        controller
                                            .getDetailGroupData()!
                                            .leader
                                            .userName,
                                        style: TextStyle(
                                          fontFamily: Constant.fontContent,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        controller
                                            .getDetailGroupData()!
                                            .leader
                                            .email,
                                        style: TextStyle(
                                          fontFamily: Constant.fontContent,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 1,
                                  color: Colors.black,
                                ),
                                Text(
                                  'Group Member',
                                  style: TextStyle(
                                    fontFamily: Constant.fontContent,
                                    fontSize: 12,
                                  ),
                                ),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: DataTable(
                                    columns: [
                                      DataColumn(
                                        label: Text(
                                          'User Name',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          'Email',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          'Role',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                    rows: controller
                                        .getDetailGroupData()!
                                        .members
                                        .map(
                                      (v) {
                                        return DataRow(
                                          cells: [
                                            DataCell(Text(v.userName)),
                                            DataCell(Text(v.email)),
                                            DataCell(Text(
                                              v.id ==
                                                      controller
                                                          .getDetailGroupData()!
                                                          .leader
                                                          .id
                                                  ? 'Leader'
                                                  : 'Member',
                                            )),
                                          ],
                                        );
                                      },
                                    ).toList(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(12),
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
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Leave Group',
                        style: TextStyle(
                          fontFamily: Constant.fontHeading,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

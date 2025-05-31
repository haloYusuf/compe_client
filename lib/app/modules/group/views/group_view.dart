import 'package:compe_client/app/modules/group/controllers/group_controller.dart';
import 'package:compe_client/core/utils/constant.dart';
import 'package:compe_client/core/widgets/group_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GroupView extends StatelessWidget {
  const GroupView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(GroupController());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Group',
          style: TextStyle(
            fontFamily: Constant.fontHeading,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 12,
            children: [
              TextField(
                textInputAction: TextInputAction.search,
                onChanged: controller.setSearchValue,
                decoration: InputDecoration(
                  hintText: 'Find Your Competitions ...',
                  hintStyle: TextStyle(
                    fontFamily: Constant.fontContent,
                  ),
                  contentPadding: EdgeInsets.all(6),
                  prefixIcon: Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              Expanded(
                child: Obx(
                  () {
                    if (controller.getIsLoading()) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (controller.getIsError()) {
                      return Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          spacing: 12,
                          children: [
                            Text('Gagal Mendapatkan Data!'),
                            ElevatedButton(
                              onPressed: controller.getAllUserGroup,
                              child: Text('Coba Lagi'),
                            ),
                          ],
                        ),
                      );
                    } else if (controller.getAllGroup().isEmpty) {
                      return Center(
                        child: Text('Data yang dicari tidak ada!'),
                      );
                    } else {
                      return ListView.builder(
                        itemCount: controller.getAllGroup().length,
                        itemBuilder: (context, index) => Padding(
                          padding: EdgeInsets.only(
                            left: 6,
                            right: 6,
                            bottom: 12,
                          ),
                          child: GroupCard(
                            data: controller.getAllGroup()[index],
                            userId: controller.getUserId(),
                            onItemTap: () => controller.handleItemTap(index),
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

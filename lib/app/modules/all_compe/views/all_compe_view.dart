import 'package:compe_client/core/utils/constant.dart';
import 'package:compe_client/core/widgets/compe_home_card.dart';
import 'package:compe_client/app/modules/all_compe/controllers/all_compe_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllCompeView extends GetView<AllCompeController> {
  const AllCompeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'List All Competition',
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
          } else if (controller.getIsError()) {
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
            return Padding(
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
                    child: controller.getAllCompe().isEmpty
                        ? Center(
                            child: Text(
                              'Data yang dicari tidak ditemukan!',
                            ),
                          )
                        : GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 12,
                              crossAxisSpacing: 10,
                            ),
                            itemCount: controller.getAllCompe().length,
                            itemBuilder: (context, index) => CompeHomeCard(
                              data: controller.getAllCompe()[index],
                              isAllCompe: true,
                              onTap: () => controller.handleListTapped(index),
                            ),
                          ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

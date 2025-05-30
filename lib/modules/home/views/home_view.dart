import 'package:compe_client/core/utils/constant.dart';
import 'package:compe_client/core/widgets/compe_home_card.dart';
import 'package:compe_client/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFE5E8FF),
                  Color(0xFFFFFFFF),
                ],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
              ),
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: 12,
                  children: [
                    SizedBox(height: 8),
                    Obx(
                      () => Text(
                        'Welcome, ${controller.getUserData()?.userName ?? 'User'}',
                        style: TextStyle(
                          fontFamily: Constant.fontHeading,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Text(
                      'There are many\ncompetitions waiting for you.',
                      style: TextStyle(
                        fontFamily: Constant.fontHeading,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF6F5EDC),
                      ),
                    ),
                    TextField(
                      textInputAction: TextInputAction.search,
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
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Competitions',
                          style: TextStyle(
                            fontFamily: Constant.fontHeading,
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                              vertical: 2,
                              horizontal: 12,
                            ),
                          ),
                          child: Text(
                            'See All',
                            style: TextStyle(
                              fontFamily: Constant.fontContent,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Obx(
                      () {
                        if (controller.getIsLoading()) {
                          return SizedBox(
                            height: 250,
                            child: Center(
                              child: Text('Loading Data...'),
                            ),
                          );
                        } else {
                          if (controller.getIsError()) {
                            return SizedBox(
                              height: 250,
                              child: Column(
                                spacing: 12,
                                children: [
                                  Text('Gagal mendapatkan data!'),
                                  ElevatedButton(
                                    onPressed: () {},
                                    child: Text('Coba Lagi'),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return SizedBox(
                              height: 230,
                              width: double.infinity,
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    controller.getHighlightCompe().length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                      left: 2,
                                      bottom: 5,
                                      right: 8,
                                    ),
                                    child: CompeHomeCard(
                                      data:
                                          controller.getHighlightCompe()[index],
                                      onTap: () =>
                                          controller.handleListTapped(index),
                                    ),
                                  );
                                },
                              ),
                            );
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

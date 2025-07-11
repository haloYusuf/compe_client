import 'package:compe_client/core/utils/constant.dart';
import 'package:compe_client/core/widgets/auth_background.dart';
import 'package:compe_client/app/modules/auth/controllers/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthBackground(
      content: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: controller.handleBack,
            icon: Icon(
              Icons.arrow_back_ios,
            ),
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 8,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                spacing: 12,
                children: [
                  Text(
                    'Hi !',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: Constant.fontHeading,
                      fontWeight: FontWeight.w600,
                      fontSize: 28,
                    ),
                  ),
                  Text(
                    'welcome, you are very much awaited!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: Constant.fontContent,
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  TextField(
                    controller: controller.userNameController,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: 'Username',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  TextField(
                    controller: controller.emailController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  Obx(
                    () => TextField(
                      controller: controller.passController,
                      textInputAction: TextInputAction.next,
                      obscureText: !controller.getVisibilityPass(),
                      obscuringCharacter: '*',
                      decoration: InputDecoration(
                        hintText: 'Password',
                        filled: true,
                        fillColor: Colors.white,
                        suffixIcon: IconButton(
                          onPressed: controller.handleSetVisibilityPass,
                          icon: Icon(
                            controller.getVisibilityPass()
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  Obx(
                    () => TextField(
                      controller: controller.confirmPassController,
                      textInputAction: TextInputAction.next,
                      obscureText: !controller.getVisibilityConfirmPass(),
                      obscuringCharacter: '*',
                      decoration: InputDecoration(
                        hintText: 'Confirm Password',
                        filled: true,
                        fillColor: Colors.white,
                        suffixIcon: IconButton(
                          onPressed: controller.handleSetVisibilityConfirmPass,
                          icon: Icon(
                            controller.getVisibilityPass()
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  TextField(
                    controller: controller.phoneNumberController,
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      hintText: 'Phone Number',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    spacing: 2,
                    children: [
                      Text(
                        'Already member?',
                        style: TextStyle(
                          fontFamily: Constant.fontContent,
                          fontSize: 12,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            horizontal: 2,
                          ),
                        ),
                        child: Text(
                          'Log In',
                          style: TextStyle(
                            fontFamily: Constant.fontContent,
                            fontSize: 12,
                            color: Color(0xFF618EC9),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Obx(
                    () => ElevatedButton(
                      onPressed: controller.getIsLoading()
                          ? null
                          : controller.handleRegister,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFFC6B68),
                        padding: EdgeInsets.all(24),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        controller.getIsLoading()
                            ? 'Create Account ...'
                            : 'Register',
                        style: TextStyle(
                          fontFamily: Constant.fontContent,
                          color: Colors.white,
                        ),
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

import 'package:compe_client/core/utils/constant.dart';
import 'package:compe_client/core/widgets/auth_background.dart';
import 'package:compe_client/app/modules/auth/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthBackground(
      content: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Center(
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
                      'Hello !',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: Constant.fontHeading,
                        fontWeight: FontWeight.w600,
                        fontSize: 28,
                      ),
                    ),
                    Text(
                      'Wellcome back you\'ve been missed!',
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
                      controller: controller.dataController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: 'Username / Email',
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
                        obscureText: controller.getVisibilityPass(),
                        obscuringCharacter: '*',
                        decoration: InputDecoration(
                          hintText: 'Password',
                          filled: true,
                          fillColor: Colors.white,
                          suffixIcon: IconButton(
                            onPressed: controller.handleVisiblePass,
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
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      spacing: 2,
                      children: [
                        Text(
                          'Not a member?',
                          style: TextStyle(
                            fontFamily: Constant.fontContent,
                            fontSize: 12,
                          ),
                        ),
                        TextButton(
                          onPressed: controller.handleRegisterButton,
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                              horizontal: 2,
                            ),
                          ),
                          child: Text(
                            'Register',
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
                            : controller.handleLogin,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFFC6B68),
                          padding: EdgeInsets.all(24),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          controller.getIsLoading() ? 'Wait ...' : 'Sign In',
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
      ),
    );
  }
}

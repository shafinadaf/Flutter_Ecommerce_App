import 'package:webe/controller/auth_controller.dart';
import 'package:webe/home_screen/home.dart';

import '/consts/consts.dart';
import '/widgets_common/applogo_widget.dart';
import '/widgets_common/bg_widget.dart';
import '/widgets_common/custom_textfield.dart';
import '/widgets_common/our_button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  // changeScreen() {
  //   Future.delayed(const Duration(seconds: 3), () {
  //     Get.to(() => const SignupScreen());
  //   });
  // }
  bool? isCheck = false;
  var controller = Get.put(AuthController());

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var retypePasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Center(
              child: Column(
                children: [
                  (context.screenHeight * 0.1).heightBox,
                  applogoWidget(),
                  10.heightBox,
                  "sign up to $appname"
                      .text
                      .fontFamily(bold)
                      .white
                      .size(18)
                      .make(),
                  15.heightBox,
                  Obx(
                    () => Column(
                      children: [
                        customTextField(
                            hint: nameHint,
                            title: name,
                            controller: nameController,
                            isPass: false),
                        customTextField(
                            hint: emailHint,
                            title: email,
                            controller: emailController,
                            isPass: false),
                        customTextField(
                            hint: passwordHint,
                            title: password,
                            controller: passwordController,
                            isPass: true),
                        customTextField(
                            hint: passwordHint,
                            title: retypePassword,
                            controller: retypePasswordController,
                            isPass: true),
                        Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                                onPressed: () {},
                                child: forgetPass.text.make())),
                        5.heightBox,
                        // ourButton().box.width(context.screenWidth - 50).make(),

                        5.heightBox,
                        Row(
                          children: [
                            Checkbox(
                              checkColor: blueColor,
                              value: isCheck,
                              onChanged: (newValue) {
                                setState(() {
                                  isCheck = newValue;
                                });
                              },
                            ),
                            10.heightBox,
                            Expanded(
                                child: RichText(
                                    text: const TextSpan(children: [
                              TextSpan(
                                  text: "I agree to the ",
                                  style: TextStyle(
                                    fontFamily: regular,
                                    color: fontGrey,
                                  )),
                              TextSpan(
                                  text: termsAndCond,
                                  style: TextStyle(
                                    fontFamily: regular,
                                    color: blueColor,
                                  )),
                              TextSpan(
                                  text: "&",
                                  style: TextStyle(
                                    fontFamily: regular,
                                    color: fontGrey,
                                  )),
                              TextSpan(
                                  text: privacyPolacy,
                                  style: TextStyle(
                                    fontFamily: regular,
                                    color: blueColor,
                                  )),
                            ])))
                          ],
                        ),
                        controller.isloading.value
                            ? const CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation(blueColor),
                              )
                            : ourButton(
                                color: isCheck == true ? blueColor : lightGrey,
                                title: signup,
                                textColor: whiteColor,
                                onPress: () async {
                                  if (isCheck != false) {
                                    controller.isloading(true);
                                    try {
                                      await controller
                                          .signupMethod(
                                        context: context,
                                        email: emailController.text,
                                        password: passwordController.text,
                                      )
                                          .then((value) {
                                        // if (value != null) {
                                        return controller.storeUserData(
                                          email: emailController.text,
                                          password: passwordController.text,
                                          name: nameController.text,
                                        );
                                      }).then((value) {
                                        VxToast.show(context, msg: loggedin);
                                        Get.offAll(() => const Home());
                                      });
                                    } catch (e) {
                                      auth.signOut();
                                      VxToast.show(context, msg: e.toString());
                                      controller.isloading(false);
                                    }
                                  }
                                }).box.width(context.screenWidth - 50).make(),
                        10.heightBox,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            alreadyHaveAccount.text.color(fontGrey).make(),
                            login.text.color(blueColor).make().onTap(() {
                              Get.back();
                            }),
                          ],
                        ),
                      ],
                    )
                        .box
                        .white
                        .rounded
                        .padding(const EdgeInsets.all(15))
                        .width(context.screenWidth - 70)
                        .shadowSm
                        .make(),
                  )
                ],
              ),
            )));
  }
}

import 'package:multichatapp/Auth/signup.dart';
import 'package:multichatapp/Screens/forget_Screen.dart';
import 'package:multichatapp/Utility/toastmasseage.dart';
import 'package:multichatapp/component/button.dart';
import 'package:multichatapp/component/firebase_controller.dart';
import 'package:multichatapp/const/const.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var controller = Get.put(AuthController());
  bool isloading = false;
  var emailcontroller = TextEditingController();
  var passwordcontroller = TextEditingController();
  bool isobs = true;
  final _keyform = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          height: context.screenHeight * 1,
          width: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(imgbackgorund), fit: BoxFit.fill)),
          child: Column(
            children: [
              60.heightBox,
              Image.asset(
                icchat,
                color: Colors.green,
              ).box.white.roundedSM.padding(const EdgeInsets.all(8)).make(),
              loginname.text.white.fontWeight(FontWeight.bold).make(),
              15.heightBox,
              Column(
                children: [
                  //TextField
                  //  customtextfield(title: email,hinttext: emailhint,icon: const Icon(Icons.email),ispass: false,controller: emailcontroller),

                  Form(
                      key: _keyform,
                      child: Column(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              email.text.color(black).size(16).make(),
                              TextFormField(
                                controller: emailcontroller,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Enter your email';
                                  }
                                  if (!RegExp(
                                          r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+$')
                                      .hasMatch(value)) {
                                    return 'Enter correct email';
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                    hintText: emailhint,
                                    suffixIcon: Icon(Icons.email),
                                    hintStyle: TextStyle(
                                      fontStyle: FontStyle.normal,
                                      color: textfieldGrey,
                                    ),
                                    border: InputBorder.none,
                                    fillColor: lightGrey,
                                    filled: true,
                                    isDense: true,
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                      color: redColor,
                                    ))),
                              ),
                              10.heightBox
                            ],
                          ),

                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              password.text.color(black).size(16).make(),
                              TextFormField(
                                controller: passwordcontroller,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Enter  Value";
                                  }
                                  if (value.length < 6 || value.length > 8) {
                                    return "Password should be between 6 to 8";
                                  }

                                  return null;
                                },
                                obscureText: isobs,
                                decoration: InputDecoration(
                                    hintText: passwordhint,
                                    suffixIcon: InkWell(
                                        onTap: () {
                                          setState(() {
                                            isobs = !isobs;
                                          });
                                        },
                                        child: Icon(isobs
                                            ? Icons.visibility_off
                                            : Icons.visibility)),
                                    hintStyle: const TextStyle(
                                      fontStyle: FontStyle.normal,
                                      color: textfieldGrey,
                                    ),
                                    border: InputBorder.none,
                                    fillColor: lightGrey,
                                    filled: true,
                                    isDense: true,
                                    focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                      color: redColor,
                                    ))),
                              ),
                              10.heightBox
                            ],
                          ),

                          Align(
                            alignment: Alignment.topRight,
                            child: TextButton(
                                onPressed: () {
                                  Get.to(() => const ForgetScreen());
                                },
                                child: forget.text.color(redColor).make()),
                          ),
                          //Login Button..

                          ButtonScreen(
                              title: login,
                              isloading: isloading,
                              onpress: () async {
                                if (_keyform.currentState!.validate()) {
                                  setState(() {
                                    isloading = true;
                                  });
                                  try {
                                    await controller
                                        .islogin(
                                            semail: emailcontroller.text,
                                            spassword: passwordcontroller.text)
                                        .then((value) {
                                      setState(() {
                                        isloading = false;
                                      });

                                      // Get.to(() => const HomeScreen());
                                    });
                                  } catch (e) {
                                    Utils().toastMessage(e.toString());
                                    setState(() {
                                      isloading = false;
                                    });
                                  }
                                }
                              }).box.width(context.screenWidth - 50).make(),

                          //customtextfield(title: password,hinttext: passwordhint,icon: const Icon(Icons.visibility_off_outlined),ispass: true,controller: passwordcontroller),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              newaccount.text
                                  .color(Colors.grey)
                                  .fontWeight(FontWeight.w600)
                                  .make(),
                              TextButton(
                                  onPressed: () {
                                    Get.to(() => const SignupScreen());
                                  },
                                  child: signup.text.color(redColor).make())
                            ],
                          )
                        ],
                      )),
                ],
              )
                  .box
                  .white
                  .roundedSM
                  .padding(const EdgeInsets.all(8.0))
                  .width(context.screenWidth - 70)
                  .shadowSm
                  .make(),
            ],
          ),
        ));
  }
}

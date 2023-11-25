import 'package:get/get.dart';
import 'package:multichatapp/Auth/Login.dart';
import 'package:multichatapp/Utility/toastmasseage.dart';
import 'package:multichatapp/component/button.dart';
import 'package:multichatapp/component/firebase_controller.dart';
import 'package:multichatapp/const/const.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  var controller = Get.put(AuthController());

  var emailcontroller = TextEditingController();
  var passwordcontroller = TextEditingController();
  var conformpasswordcontroller = TextEditingController();
  var namecontroller = TextEditingController();
  bool isloading = false;
  bool toggle = true;
  bool istoggle = true;

  final _keyform = GlobalKey<FormState>();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
    conformpasswordcontroller.dispose();
    namecontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body:

            // StreamBuilder(
            //   stream: Firebaseservice.getuser(currentuser!.uid),
            //   builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){

            //     if(snapshot.connectionState == ConnectionState.waiting)
            //     return Text("Waiting");

            //     if(!snapshot.hasData){
            //       return const Center(child: CircularProgressIndicator(color: redColor,strokeWidth: 2,));
            //     }
            //     else{

            // return
            Container(
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
              signupname.text.white.fontWeight(FontWeight.bold).make(),
              15.heightBox,
              Column(
                children: [
                 Form(
                  key: _keyform,
                  
                  child: Column(
                  children: [
                     Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      nametitle.text.color(black).size(16).make(),
                      TextFormField(
                        controller: namecontroller,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter your name";
                          }
                          if (!RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                            return "Enter correct name";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            hintText: namehint,
                            suffixIcon: Icon(Icons.person),
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
                      )],
                  ),
                  // customtextfield(title: nametitle,hinttext: namehint,icon: const Icon(Icons.person),ispass: false,controller: namecontroller),
                  // customtextfield(title: email,hinttext: emailhint,icon: const Icon(Icons.email),ispass: false,controller: emailcontroller),
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
                            return "Enter value";
                          }
                          if (value.length < 6 || value.length > 8) {
                            return "password length should be  between 6 to 8";
                          }
                          return null;
                        },
                        obscureText: toggle,
                        decoration: InputDecoration(
                            hintText: passwordhint,
                            suffixIcon: InkWell(
                                onTap: () {
                                  setState(() {
                                    toggle = !toggle;
                                  });
                                },
                                child: Icon(toggle
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
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      conformpassword.text.color(black).size(16).make(),
                      TextFormField(
                        controller: conformpasswordcontroller,
                        validator: (value) {
                          
                          if (value!.isEmpty) {
                            return "Please confirm password";
                          }
                          if (value != passwordcontroller.text) {
                            return "Password does not match";
                          }
                          return null;
                        },
                        obscureText: istoggle,
                        decoration: InputDecoration(
                            hintText: passwordhint,
                            suffixIcon: InkWell(
                                onTap: () {
                                  setState(() {
                                    istoggle = !istoggle;
                                  });
                                },
                                child: Icon(istoggle
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
                  
                  
                      20.heightBox,
                      ourbutton(
                          title: signup,
                          loading: isloading,
                          onpress: () async {
                            if (_keyform.currentState!.validate()) {
                              setState(() {
                                isloading = true;
                              });
          
                              try {
                                await controller
                                    .signup(
                                        email: emailcontroller.text,
                                        password: passwordcontroller.text)
                                    .then((value) {
                                  return controller.stordata(
                                    email: emailcontroller.text,
                                    password: passwordcontroller.text,
                                    name: namecontroller.text,
                                  );
                                }).then((value) {
                                  setState(() {
                                    isloading = false;
                                  });
                                  Utils().toastMessage("Signup Sucessfully");
                                  Get.offAll(() => const LoginScreen());
                                });
                              } catch (e) {
                                Utils().toastMessage(e.toString());
                                setState(() {
                                  isloading = false;
                                });
                              }
                            }
                          }).box.width(context.screenWidth - 50).make(),
                      10.heightBox,
                    ],
                  ),
          
                  // customtextfield(title: password,hinttext: passwordhint,icon: const   Icon(Icons.visibility_off_outlined),ispass: true,controller: passwordcontroller),
                  // customtextfield(title: conformpassword,hinttext: passwordhint,icon: const Icon(Icons.visibility_off_outlined),ispass: true,controller: conformpasswordcontroller),
          
                  //Login Button..
          
                  //  ButtonScreen(title: signup,isloading: isloading, onpress: ()async{
                  //    }).box.width(context.screenWidth-50).make(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      alreadyaccount.text
                          .color(Colors.grey)
                          .fontWeight(FontWeight.w600)
                          .make(),
                      TextButton(
                          onPressed: () {
                            // Get.offAll(()=> const L());
                            Get.offAll(() => const LoginScreen());
                            namecontroller.clear();
                            passwordcontroller.clear();
                            conformpasswordcontroller.clear();
                            emailcontroller.clear();
                          },
                          child: login.text.color(redColor).make())
                    ],
                  )
                  ],
                 ))
                  //TextField
                 
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
        )
        // }

        // }

        // )
        );
  }
}

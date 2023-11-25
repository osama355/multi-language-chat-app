import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multichatapp/Auth/Login.dart';
import 'package:multichatapp/Utility/toastmasseage.dart';
import 'package:multichatapp/component/firebase_controller.dart';
import 'package:multichatapp/const/const.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
   var controller = Get.find<AuthController>();
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: Center(
        child: Column(
          children: [
            
              ElevatedButton(onPressed: (){
               auth.signOut().then((value) {
                Get.offAll(()=> const LoginScreen());
               }).onError((error, stackTrace) {
                 Utils().toastMessage(error.toString());
               });
              }, child: "Signout".text.black.makeCentered()),
            
          ],
        ),
      ),
    );
  }
}
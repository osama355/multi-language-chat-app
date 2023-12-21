
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:multichatapp/Screens/chat_Screen/chat_screen.dart';
import 'package:multichatapp/Screens/profile.dart';
import 'package:multichatapp/component/navbar_component.dart';
import 'package:multichatapp/const/const.dart';

class NavbarScreen extends StatefulWidget {
  final int? currentIndex;
  const NavbarScreen({super.key,this.currentIndex});

  @override
  State<NavbarScreen> createState() => _NavbarScreenState();
}

class _NavbarScreenState extends State<NavbarScreen> {
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(NavController());
    var navbar = [
   
   const  BottomNavigationBarItem(icon: Icon(Icons.chat),label: chat),
   const   BottomNavigationBarItem(icon: Icon(Icons.person),label: profile),
];

 var navbody = [
  

    const ChatScreen(),
   const ProfileScreen()
 ];
    return  Scaffold(
      body: Column(
        children: [
          Obx(()=> Expanded(child: navbody.elementAt(controller.currentindex.value)))
        ],),
        bottomNavigationBar: Obx(()=>
           BottomNavigationBar(
            currentIndex: controller.currentindex.value,
            selectedItemColor: green,
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            
            onTap: (value){
              controller.currentindex.value = value; },
              items: navbar),
        ),




    );
  }
}
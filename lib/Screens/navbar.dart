
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:multichatapp/Screens/add_friend/search_friend.dart';
import 'package:multichatapp/Screens/profile.dart';
import 'package:multichatapp/component/navbar_component.dart';
import 'package:multichatapp/const/const.dart';

class NavbarScreen extends StatefulWidget {
  const NavbarScreen({super.key});

  @override
  State<NavbarScreen> createState() => _NavbarScreenState();
}

class _NavbarScreenState extends State<NavbarScreen> {
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(NavController());
    var navbar = [
   const  BottomNavigationBarItem(icon: Icon(Icons.person_add),label: addfri),
   const  BottomNavigationBarItem(icon: Icon(Icons.chat),label: chat),
   const   BottomNavigationBarItem(icon: Icon(Icons.person),label: profile),
];

 var navbody = [
  const  SeaerchFriend(),

   Container(color: Colors.green,),
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
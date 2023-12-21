import 'package:get/get.dart';
import 'package:multichatapp/Screens/add_friend/add_friends.dart';
import 'package:multichatapp/Screens/friendprofile_Screen/Request.dart';
import 'package:multichatapp/Screens/friendprofile_Screen/show_friend.dart';
import 'package:multichatapp/Screens/friendprofile_Screen/upcomming.dart';
import 'package:multichatapp/component/navbar_component.dart';
import 'package:multichatapp/const/const.dart';

class FriendHomeScreen extends StatefulWidget {
  const FriendHomeScreen({super.key});

  @override
  State<FriendHomeScreen> createState() => _FriendHomeScreenState();
}

class _FriendHomeScreenState extends State<FriendHomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabcontroller;
  var controller = Get.find<NavController>();
  @override
  void initState() {
    super.initState();
    tabcontroller = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
    
        backgroundColor: green,
        title: const Text(
          'My Friends',
          style: TextStyle(color: Colors.white),
        ),
       
        bottom: TabBar(
          indicatorColor: redColor,
          controller: tabcontroller,
          tabs: const [
            Tab(
              child: Text(
                'Request',textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Colors.white,),
              ),
            ),
            Tab(
              child: Text(
                'My Friends',textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Colors.white),
              ),
            ),
            Tab(
              child: Text(
                'Upcoming',textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Colors.white),
              ),
            ),
             Tab(
              child: Text(
                ' Add Friends',textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Colors.white),
              ),
            ),
          ],
        ),
      ),
      body:
      
      
       TabBarView(
        controller: tabcontroller,
        children: const  [
          RequestFriendScreen(),
         ShowFriendScreen(),
        UpcommingFriendScreen(),
          AddFriends()
         
        ],
      ),
    );
  }
}

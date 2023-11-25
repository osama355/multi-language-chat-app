import 'package:get/get.dart';
import 'package:multichatapp/Screens/friendprofile_Screen/Request.dart';
import 'package:multichatapp/Screens/friendprofile_Screen/show_friend.dart';
import 'package:multichatapp/Screens/friendprofile_Screen/upcomming.dart';
import 'package:multichatapp/Screens/navbar.dart';
import 'package:multichatapp/const/const.dart';

class FriendHomeScreen extends StatefulWidget {
  const FriendHomeScreen({super.key});

  @override
  State<FriendHomeScreen> createState() => _FriendHomeScreenState();
}

class _FriendHomeScreenState extends State<FriendHomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabcontroller;
  @override
  void initState() {
    super.initState();
    tabcontroller = TabController(length: 3, vsync: this);
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
        leading: IconButton(
            onPressed: () {
              try {
                Get.offAll(() => const NavbarScreen());
              } catch (e) {}
            },
            icon: const Icon(Icons.arrow_back)),
        bottom: TabBar(
          controller: tabcontroller,
          tabs: const [
            Tab(
              child: Text(
                'Request',
                style: TextStyle(color: Colors.white),
              ),
            ),
            Tab(
              child: Text(
                'Upcomming',
                style: TextStyle(color: Colors.white),
              ),
            ),
            Tab(
              child: Text(
                'Friends',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabcontroller,
        children: const [
          RequestFriendScreen(),
          UpcommingFriendScreen(),
          ShowFriendScreen(),
        ],
      ),
    );
  }
}

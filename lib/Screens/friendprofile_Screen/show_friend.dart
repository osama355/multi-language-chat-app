import 'package:flutter/widgets.dart';
import 'package:multichatapp/const/const.dart';

class ShowFriendScreen extends StatefulWidget {
  const ShowFriendScreen({super.key});

  @override
  State<ShowFriendScreen> createState() => _ShowFriendScreenState();
}

class _ShowFriendScreenState extends State<ShowFriendScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
     
       body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: "Friend".text.size(30).make(),
          )
        ],
      ),
    );
  }
}
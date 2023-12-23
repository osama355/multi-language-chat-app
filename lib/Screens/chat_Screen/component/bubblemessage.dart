// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/widgets.dart';
// import 'package:multichatapp/const/const.dart';
// import 'package:intl/intl.dart' as intl;

// Widget sendBubble(DocumentSnapshot data) {
//   var t =
//       data['created_on'] == null ? DateTime.now() : data['created_on'].toDate();
//   var time = intl.DateFormat("h:mma").format(t);

//   return Directionality(
//     textDirection:
//         data['uid'] == currentuser!.uid ? TextDirection.ltr : TextDirection.rtl,
//     child: Container(
//       margin: const EdgeInsets.only(bottom: 8),
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//           color: data['uid'] == currentuser!.uid ? Colors.green : Colors.grey,
//           borderRadius: data['uid'] == currentuser!.uid
//               ? const BorderRadius.only(
//                   topLeft: Radius.circular(20),
//                   topRight: Radius.circular(20),
//                   bottomLeft: Radius.circular(20),
//                 )
//               : const BorderRadius.only(
//                   topLeft: Radius.circular(20),
//                   topRight: Radius.circular(20),
//                   bottomRight: Radius.circular(20),
//                 )),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           GestureDetector(
//             onTap: () {
//               print("Tap");
//                Container(
//                 height: 50,
//                 width: 50,
//                 color: black,
//                 child: "Deleted".text.make(),
//                );

// },

//             child: Text("${data['msg']}",style: const TextStyle(color: whiteColor,fontSize: 16),)),
//        // "${data['msg']}" .text.white.size(16).make().onInkLongPress(() { Firebaseservice.deletedoc(chatid: Get.put(Chatcontroller()).chatDocId,msgid: data.id);}),
//           Row(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               time.text.color(whiteColor.withOpacity(0.5)).make(),
//               5.widthBox,
//               data['uid'] == currentuser!.uid && data['read'] == false
//                   ? const Icon(
//                       Icons.done,
//                       color: Colors.blue,
//                     )
//                   : data['uid'] == currentuser!.uid && data['read'] != false
//                       ? const Icon(
//                           Icons.done_all,
//                           color: Colors.blue,
//                         )
//                       : const SizedBox.shrink(),

//             ],
//           )
//         ],
//       ),
//     ),
//   );
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import 'package:multichatapp/Service/firebase_service.dart';
import 'package:multichatapp/component/button.dart';
import 'package:multichatapp/const/const.dart';
import 'package:multichatapp/controller/chat_controller.dart';

class SendBubble extends StatefulWidget {
  final DocumentSnapshot data;

  const SendBubble({Key? key, required this.data}) : super(key: key);

  @override
  _SendBubbleState createState() => _SendBubbleState();
}

class _SendBubbleState extends State<SendBubble> {
  bool showDeletedMessage = false;
  var controller = Get.find<Chatcontroller>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.data['uid'] != currentuser!.uid){
      controller.updateread(widget.data.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    var t = widget.data['created_on'] == null
        ? DateTime.now()
        : widget.data['created_on'].toDate();
    var time = intl.DateFormat("h:mma").format(t);

    return Directionality(
      textDirection: widget.data['uid'] == currentuser!.uid
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: widget.data['uid'] == currentuser!.uid
              ? Colors.green
              : Colors.grey,
          borderRadius: widget.data['uid'] == currentuser!.uid
              ? const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                )
              : const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {
                  if(widget.data['uid'] == currentuser!.uid){
                    showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) => Dialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            "Comfirm".text.fontWeight(FontWeight.bold).make(),
                            10.heightBox,
                            "Delete Message?"
                                .text.color(redColor)
                                .size(18)
                                .make(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  width: 100,
                                  height: 30,
                                  child: ButtonScreen(
                                      title: "Yes",
                                      onpress: () {
                                     
                                            Firebaseservice.deletedoc(chatid: Get.find<Chatcontroller>().chatDocId,msgid: widget.data.id );
                                      Navigator.pop(context);

                                        
                                   
                                      }),
                                ),
                                SizedBox(
                                  width: 80,
                                  height: 30,
                                  child: ButtonScreen(
                                      title: "No",
                                      onpress: () {
                                        Navigator.pop(context);
                                      }),
                                ),
                              ],
                            )
                          ],
                        )
                            .box
                            .white
                            .roundedSM
                            .padding(const EdgeInsets.all(4))
                            .make()));

                  }

                

                // exitsdialog(context: context,data: widget.data.id));
              },
              child: Text(
                "${widget.data['msg']}",
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                time.text.color(Colors.white.withOpacity(0.5)).make(),
                5.widthBox,
               
                  
              

                
                widget.data['uid'] == currentuser!.uid &&
                        widget.data['read'] == false
                    ? const Icon(
                        Icons.done,
                        color: Colors.blue,
                      )
                    : widget.data['uid'] == currentuser!.uid &&
                            widget.data['read'] != false
                        ? const Icon(
                            Icons.done_all,
                            color: Colors.blue,
                          )
                        : const SizedBox.shrink(),
              ],
            )
          ],
        ),
      ),
    );
  }
}

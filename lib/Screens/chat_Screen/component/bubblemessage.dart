import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:multichatapp/const/const.dart';
import 'package:intl/intl.dart' as intl;









Widget sendBubble(DocumentSnapshot data){


  

  var t = data['created_on'] == null ? DateTime.now() : data['created_on'].toDate();
  var time = intl.DateFormat("h:mma").format(t);
  

 
 

  return  Directionality(
    textDirection: data['uid'] == currentuser!.uid ? TextDirection.ltr : TextDirection.rtl,
    child: Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
  
                        decoration: BoxDecoration(
                          color:data['uid'] == currentuser!.uid ? Colors.green : Colors.grey,
                           
                          borderRadius: data['uid'] == currentuser!.uid ? const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                          
                          
                        ) :
                      const  BorderRadius.only(
                         topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(20),


                        ) ),
                        
                        child: Column(
  
                           mainAxisSize: MainAxisSize.min,
                          
                           
                 crossAxisAlignment: CrossAxisAlignment.start,
                 mainAxisAlignment: MainAxisAlignment.end,
                
                    children: [
                      "${data['msg']}".text.white.size(16).make(),
                     Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                         time.text.color(whiteColor.withOpacity(0.5)).make(),
                         5.widthBox,
                        
                        
                         data['uid']==currentuser!.uid && data['read'] == false?
                        const  Icon(Icons.done,color: Colors.blue,) :
                        data['uid']==currentuser!.uid && data['read'] != false?
                        const  Icon(Icons.done_all,color: Colors.blue,)  :
                       const SizedBox.shrink()
                       
                     
                          
                         
                         
                      ],
                     )
                     
                       
                    
                     
                    
                     
                       
                      
                     
                      ],
                  ),
                      ),
  );
}
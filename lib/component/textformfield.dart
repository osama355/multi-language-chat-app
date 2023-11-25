import 'package:multichatapp/const/const.dart';

Widget customtextfield({String? title,String? hinttext, Icon? icon,controller,ispass}){

  return  Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            title!.text.color(black).size(16).make(),
            Form(
              child: TextFormField(
               
                
                controller: controller,
                validator: (value) {
                  if(value!.isEmpty){
                    return "Enter Value";
                  }
                   
                  return null;
                },
                obscureText: ispass,
                decoration:  InputDecoration(
                  hintText: hinttext,
                  suffixIcon: icon,
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
                    )
                   )
                   
                ),
              ),
            ),
            10.heightBox
          ],
        );
}
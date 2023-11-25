  import 'package:multichatapp/const/const.dart';

class ButtonScreen extends StatelessWidget {
  final String? title;
  final Color textcolor;
 final bool isloading;
  final Color buttoncolor;
  final VoidCallback onpress;
  final bool istoggle; 

  const ButtonScreen({
  
  required this.title,
  this.isloading = false,
  this.istoggle = false,
  required this.onpress,
  this.textcolor = const  Color(0xffffffff),
  this.buttoncolor = const Color.fromARGB(255, 15, 126, 80),
  super.key,

  
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onpress,
      child: Container(
        height: 47,
        decoration: BoxDecoration(
          
          borderRadius: BorderRadius.circular(12),
          color: buttoncolor,
    
        ), 
            child: Center(
               child: isloading ? const  CircularProgressIndicator(strokeWidth: 3,color: Colors.white,) :
              Text(title!,style: TextStyle(color: textcolor,fontWeight: FontWeight.bold),)
                 // title!.text.color(textcolor).fontWeight(FontWeight.bold).make(),
            ),
      ),
    );
  }
}


Widget ourbutton({title,onpress, bool loading = false}){
 return ElevatedButton(
   style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
        backgroundColor: MaterialStateProperty.all<Color>(green),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            side: const BorderSide(color: Colors.white)
          )
        )
   ),
  
  onPressed: onpress,
            child:  Center(
               child:   loading ? const  CircularProgressIndicator(strokeWidth: 3,color: Colors.white,) :
              Text(title,style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)
                 // title!.text.color(textcolor).fontWeight(FontWeight.bold).make(),
            ),
      );
    
}
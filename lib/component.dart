import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:untitled/const.dart';
import 'package:untitled/web_view.dart';
Widget defaultButton(
{
  Color background =Colors.blue ,
  double width = double.infinity,
  bool isUpperCase = true,
  double radius = 5 ,
  required Function function,
  required String text ,

}) =>
    Container(
      width: width,
      height: 40,
      child: MaterialButton(
    onPressed: (){
      function();
    },
    child: Text(
     isUpperCase ? text.toUpperCase() : text ,
      style: TextStyle(
      color: Colors.white,
    ),
    ),
  ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: background,

      ),
);
Widget defaultTextButton({
  required Function function,
  required String text,
}) => TextButton(
    onPressed: (){
      function();
    },
    child: Text(
      text.toUpperCase(),
    ),

);
Widget defaultFormField ({
  cursorColor,
  required TextEditingController controller,
  required TextInputType type,
  Function ?onSubmit ,
  Function ?onChange ,
  Function ?onTap ,
  Function ?suffixPressed,
  bool isPassword = false ,
  bool isClickable = true,
  required Function validate ,
  required String label ,
  required IconData prefix ,
  IconData? suffix ,
}) =>
    TextFormField(
      controller: controller,
  keyboardType: type ,
  enabled: isClickable,
  onFieldSubmitted: (s){
    onSubmit!(s);
  } ,
  onChanged: (s){
    onChange!(s);
  },
  onTap: (){
    onTap!();
  } ,
  validator: (s){
    validate!(s);
  },
  obscureText: isPassword ,
  decoration: InputDecoration(
    labelText: label,
  prefixIcon: Icon(prefix),
  suffixIcon: suffix != null
      ? IconButton(
    onPressed: (){
      suffixPressed!();
    },
    icon: Icon(
      suffix,
    ),
  )
      : null,
  border: OutlineInputBorder(),
  ),

);
Widget buildTaskItem(Map model,context) => Dismissible(
  key: Key(model['id'].toString()),
  child: Padding(padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        CircleAvatar(
          radius: 40,
          child: Text(
            '${model['time']}',
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('${model['title']}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,

                ),
              ),
              Text('${model['date']}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,

                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 20,
        ),


      ],
  ),
),
);
Widget tasksBuilder({
  required List<Map> tasks,
})=>ConditionalBuilder(
  condition: tasks.length > 0,
  builder: (context)=> ListView.separated(
    itemBuilder:(context,index) => buildTaskItem(tasks[index] ,context),
    separatorBuilder: (context,index) => myDriver(),
    itemCount: tasks.length,
  ),
  fallback: (context) => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.menu,
          size: 100,
          color: Colors.grey,
        ),
        Text(
          'No Tasks Yet ,Please Add Some Tasks ',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
      ],
    ),
  ),
);

Widget myDriver() =>  Padding(
  padding: const EdgeInsetsDirectional.only(
    start: 20,
  ),
  child: Container(
    width: double.infinity,
    height: 1,
    color: Colors.grey[300],
  ),
);

Widget buildArticleItem(article,context) => InkWell(
  onTap: (){
    navigateTo(context, WebViewScreen(article['url']),);
  },
  child:   Padding(
    padding: const EdgeInsets.all(15.0),
    child: Row(
      children: [
        Container(
          width: 140,
          height: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            image: DecorationImage(
              image: NetworkImage('${article['urlToImage']}'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Expanded(
          child: Container(
            height: 120,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    '${article['title']}',
                    style: Theme.of(context).textTheme.bodyText1,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  '${article['publishedAt']}',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  ),
);

Widget articleBuilder(list,context,{isSearch = false }) => ConditionalBuilder(
  condition: list.length >0,
  builder: (context) => ListView.separated(
    physics: BouncingScrollPhysics(),
    itemBuilder: (context,index) => buildArticleItem(list[index],context),
    separatorBuilder: (context,index) => myDriver(),
    itemCount: list.length ,
  ),
  fallback: (context) => isSearch ? Container(): Center(child: CircularProgressIndicator()),
);

void navigateTo(context ,widget) => Navigator.push(
  context,
  MaterialPageRoute(
  builder:(context )=> widget,
  ),
);

void navigateAndFinish(context ,widget) => Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(
    builder:(context )=> widget,
  ),
    (Route<dynamic> route) => false,
);
 void showToast ({
   required String text,
   required ToastStates state,
 })=> Fluttertoast.showToast(
     msg: text,
     toastLength: Toast.LENGTH_LONG,
     gravity: ToastGravity.BOTTOM,
     timeInSecForIosWeb: 5,
     backgroundColor: chooseToastColor(state),
     textColor: Colors.white,
     fontSize: 16.0
 );

 enum ToastStates{SUCCESS,ERROR,WARNING}
 Color chooseToastColor(ToastStates state)
 {
   Color color;
   switch(state)
   {
     case ToastStates.SUCCESS:
       color =Colors.green;
       break;
     case ToastStates.ERROR:
       color =Colors.red;
       break;
     case ToastStates.WARNING:
       color =Colors.amber;
       break;
   }
   return color;
 }

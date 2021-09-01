import 'package:flutter/material.dart';
import 'package:untitled/Cache_helper.dart';
import 'package:untitled/SocialApp/LoginScreen/SocialLoginScreen.dart';
import 'package:untitled/component.dart';
const defaultColor = Colors.blue ;

void signOut(context)
{
  CacheHelper.removeData(
      key: 'token',
  ).then((value)
  {
    if(value)
    {
      navigateAndFinish(
          context, loginScreen()
      );
    }
  });
}

void printFullText(String text)
{
  final pattern =RegExp('.{1.800}');
  pattern.allMatches(text).forEach((match)=> print(match.group(0)));
}

String token = '' ;
String uId = '' ;
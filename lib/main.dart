import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/Cache_helper.dart';
import 'package:untitled/SocialApp/LayoutScreen.dart';
import 'package:untitled/SocialApp/LoginScreen/SocialLoginScreen.dart';
import 'package:untitled/SocialApp/Network/Cubit.dart';
import 'package:untitled/SocialApp/Network/states.dart';
import 'package:untitled/bloc_observer.dart';
import 'package:untitled/const.dart';
import 'Themes.dart';
void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();


  Bloc.observer = MyBlocObserver();

  //DioHelper.init();

  await CacheHelper.init();

  bool isDark = CacheHelper.getData(key: 'isDark') ;

  Widget widget;

   uId = CacheHelper.getData(key: 'uId');

  if(uId != null )
    {
      widget = SocialLayout();
    } else
      {
        widget = loginScreen();
      }
  runApp(MyApp(
      isDark : isDark,
    startWidget: widget,
  ));
}
class MyApp extends StatelessWidget {

  final bool ?isDark ;
  final Widget ?startWidget ;

  MyApp({
    this.isDark,
    this.startWidget}) ;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context )=> SocialCubit()..getUserData(),
        ),
      ],
      child: BlocConsumer<SocialCubit,SocialStates>(
        listener: (context,state) {},
        builder: (context,state){
          return  MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: SocialCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: startWidget,
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:jrc_front/ui/pages/auth/login.dart';
import 'package:jrc_front/ui/pages/home/home.dart';
import 'package:jrc_front/ui/utils/colorTheme.dart';


class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    //call class theme and set the theme
    currentTheme.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ColorTheme.whiteTheme,
      darkTheme: ColorTheme.darkTheme,
      themeMode: currentTheme.currentTheme,
      //config routes to other class
      routes: {
        '/home': (context) => const Home(),
        '/login': (context) => const Login(),
      },
      //TODO: change class login to other class 
      home: const Home(),
    );
  }
}

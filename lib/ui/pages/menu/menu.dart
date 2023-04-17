import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/dimensions.dart';
import '../../widgets/Input.dart';
import '../../widgets/appBar.dart';
import '../../widgets/appIcon.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(color: Colors.white,fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Positioned(
            left: 0,
            right: 190,
            child: Container(
                height: Dimensions.height20,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage(
                      '/home/santiago/Documents/WorkSpace/JRC-Api-Front/assets/images/logo.png'),
                )))),
        Positioned(
            left: 190,
            right: 0,
            child: Container(
                height: Dimensions.height20,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage(
                      '/home/santiago/Documents/WorkSpace/JRC-Api-Front/assets/images/logo.png'),
                )
              )
            )
          ),
        Positioned(
              width: Dimensions.screenWidth,
              top: Dimensions.height60,
              height: Dimensions.width80,
              child: Container(
                height: Dimensions.width80,
                child: _widgetOptions.elementAt(_selectedIndex),
              )
        )
  
      ]),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Business',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'School',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}

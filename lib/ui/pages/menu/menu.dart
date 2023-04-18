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
  int _selectedIndex = 2;
  static const TextStyle optionStyle =
      TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold);
  static final List<Widget> _widgetOptions = <Widget>[
    Column(
      children: const [
        Text(
          'Index 0: Stats',
          style: optionStyle,
        ),
      ],
    ),
    Column(
      children: const [
        Text(
          'Index 1: Add',
          style: optionStyle,
        ),
      ],
    ),
    Column(
      children: const [
        Text(
          'Index 2: home',
          style: optionStyle,
        ),
      ],
    ),
    Column(
      children: const [
        Text(
          'Index 3: search',
          style: optionStyle,
        ),
      ],
    ),
    Column(
      children: const [
        Text(
          'Index 4: Person',
          style: optionStyle,
        ),
      ],
    )
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
            right: 250,
            child: Container(
                height: Dimensions.height15,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage(
                      '/home/santiago/Documents/WorkSpace/JRC-Api-Front/assets/images/logo.png'),
                )))),
        Positioned(
            width: Dimensions.screenWidth,
            top: Dimensions.height13,
            height: Dimensions.width190,
            child: Container(
                height: Dimensions.width90,
                //color: Color.fromRGBO(33, 150, 243, 1),
                child: Align(
                  alignment: Alignment.center,
                  child: _widgetOptions.elementAt(_selectedIndex),
                )))
      ]),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.query_stats),
            label: 'stats',
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Person',
          )
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromARGB(1000, 198, 169, 95),
        unselectedItemColor: const Color.fromARGB(1000, 198, 169, 95),
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
      ),
    );
  }
}

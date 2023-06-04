import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jrc_front/ui/pages/menu/search/search.dart';
import 'package:jrc_front/ui/pages/menu/stats/stats.dart';

import '../../utils/dimensions.dart';
import '../../widgets/Input.dart';
import '../../widgets/appBar.dart';
import '../../widgets/appIcon.dart';
import 'add/add.dart';
import '../auth/login.dart'; // Import the login page

class Menu extends StatefulWidget {
  const Menu({Key? key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold);
  static final List<Widget> _widgetOptions = <Widget>[
    AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return ScaleTransition(
          scale: animation,
          child: child,
        );
      },
      child: Container(
        key: const ValueKey<int>(0),
        child: const Stats(),
      ),
    ),
    AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return ScaleTransition(
          scale: animation,
          child: child,
        );
      },
      child: Container(
        key: const ValueKey<int>(1),
        child: const Add(),
      ),
    ),
    AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return ScaleTransition(
          scale: animation,
          child: child,
        );
      },
      child: Container(
        key: const ValueKey<int>(3),
        child: const Search(),
      ),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _logout() {
    // Add your logout logic here
    Get.off(() => Login());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 10,
            left: 0,
            right: 250,
            child: Container(
              height: Dimensions.height15,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/logo.png'),
                ),
              ),
            ),
          ),
          Positioned(
            width: Dimensions.screenWidth,
            top: Dimensions.height13,
            height: Dimensions.screenHeight,
            child: SizedBox(
              height: Dimensions.width90,
              //color: Color.fromRGBO(33, 150, 243, 1),
              child: Align(
                alignment: Alignment.center,
                child: _widgetOptions.elementAt(_selectedIndex),
              ),
            ),
          ),
          Positioned(
            top: 40,
            right: 10,
            child: GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Logout'),
                      content: const Text('Are you sure you want to logout?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: _logout,
                          child: const Text('Logout'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromARGB(1000, 198, 169, 95),
                ),
                child: const Icon(Icons.logout),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.query_stats),
            label: 'Stats',
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
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

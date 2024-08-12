import 'package:beautilly/screens/Admin/add_preference.dart';
import 'package:beautilly/screens/Admin/target_audience.dart';
import 'package:beautilly/utils/colors.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';

class PageWithBottomNavigation extends StatefulWidget {

 
  const PageWithBottomNavigation({super.key, });

  @override
  State<PageWithBottomNavigation> createState() =>
      _PageWithBottomNavigationState();
}

class _PageWithBottomNavigationState extends State<PageWithBottomNavigation> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

   List<Widget> pages = [
    //Click on the corresponding button in the bottom navigation bar and load the appropriate page
    const AddPreference(),
    const TargetAudience(),
  
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Column(
                children: [
                  Icon(
                    Icons.home_filled,
                    color: _selectedIndex == 0
                        ? bPrimaryColor
                        : bGrey.withOpacity(0.3),
                    size: 30,
                  ),
                  if (_selectedIndex == 0)
                    Container(
                      width: 5,
                      height: 5,
                      margin: const EdgeInsets.only(top: 2),
                      decoration: const BoxDecoration(
                        color: bPrimaryColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                ],
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Column(
                children: [
                  Icon(
                    Icons.explore,
                    color: _selectedIndex == 1
                        ? bPrimaryColor
                        : bGrey.withOpacity(0.3),
                    size: 30,
                  ),
                  if (_selectedIndex == 1)
                    Container(
                      width: 5,
                      height: 5,
                      margin: const EdgeInsets.only(top: 2),
                      decoration: const BoxDecoration(
                        color: bPrimaryColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                ],
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Column(
                children: [
                  Icon(
                    Icons.calendar_month_rounded,
                    color: _selectedIndex == 2
                        ? bPrimaryColor
                        : bGrey.withOpacity(0.3),
                    size: 30,
                  ),
                  if (_selectedIndex == 2)
                    Container(
                      width: 5,
                      height: 5,
                      margin: const EdgeInsets.only(top: 2),
                      decoration: const BoxDecoration(
                        color: bPrimaryColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                ],
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Column(
                children: [
                  Stack(
                    children: [
                      Icon(
                        Icons.inbox_rounded,
                        color: _selectedIndex == 3
                            ? bPrimaryColor
                            : bGrey.withOpacity(0.3),
                        size: 30,
                      ),
                      if (_selectedIndex != 3)
                        Positioned(
                          right: 0,
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Color(0xffF98600),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                    ],
                  ),
                  if (_selectedIndex == 3)
                    Container(
                      width: 5,
                      height: 5,
                      margin: const EdgeInsets.only(top: 2),
                      decoration: const BoxDecoration(
                        color: bPrimaryColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                ],
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Column(
                children: [
                  Icon(
                    Icons.person,
                    color: _selectedIndex == 4 ? bPrimaryColor : Colors.grey,
                    size: 30,
                  ),
                  if (_selectedIndex == 4)
                    Container(
                      width: 5,
                      height: 5,
                      margin: const EdgeInsets.only(top: 2),
                      decoration: const BoxDecoration(
                        color: bPrimaryColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                ],
              ),
              label: '',
            ),
          ],
        ),
        body: pages.elementAt(_selectedIndex));
  }
}

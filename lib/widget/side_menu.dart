import 'package:beautilly/screens/beautician_pages/staff_member_profile.dart';
import 'package:beautilly/screens/customer_profile/choose_preference.dart';
import 'package:beautilly/screens/customer_profile/findservice_page.dart';
import 'package:beautilly/screens/customer_profile/nearby_beautician_salon.dart';
import 'package:flutter/material.dart';
import 'package:beautilly/screens/join_page.dart';

import 'package:beautilly/screens/nearby_list.dart';
import 'package:beautilly/utils/colors.dart';

class SideMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.grey[850], // Dark grey background color
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const SizedBox(height: 50), // Spacing at the top
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.person,
                size: 50,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20), // Spacing between the avatar and the menu items
            _createDrawerItem(
              icon: Icons.home,
              text: 'Home',
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FindService()),
                );
              },
            ),
            _createDrawerItem(
              icon: Icons.person,
              text: 'Profile',
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FindService()),
                );
              },
            ),
            _createDrawerItem(
              icon: Icons.list_alt,
              text: 'Preferences',
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChoosePreference()),
                );
              },
            ),
            _createDrawerItem(
              icon: Icons.location_on,
              text: 'Location',
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NearbyBeauticianSalon()),
                );
              },
            ),
            _createDrawerItem(
              icon: Icons.logout,
              text: 'Logout',
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => JoinPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _createDrawerItem({required IconData icon, required String text, required GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon, color: Colors.white),
          const SizedBox(width: 20),
          Text(text, style: const TextStyle(color: Colors.white, fontSize: 18)),
        ],
      ),
      onTap: onTap,
    );
  }
}

import 'package:dukan_vendor_app/vendor/views/auth/screens/earnings_screen.dart';
import 'package:dukan_vendor_app/vendor/views/auth/screens/edit_screen.dart';
import 'package:dukan_vendor_app/vendor/views/auth/screens/logout_screen.dart';
import 'package:dukan_vendor_app/vendor/views/auth/screens/upload_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainVendorScreen extends StatefulWidget {
  const MainVendorScreen({super.key});

  @override
  State<MainVendorScreen> createState() => _MainVendorScreenState();
}

class _MainVendorScreenState extends State<MainVendorScreen> {
  int _pageIndex = 0;

  final List<Widget> _pages = [
    const EarningsScreen(),
    UploadScreen(),
    EditProductScreen(),
    LogoutScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _pageIndex,
        onTap: (value) {
          setState(() {
            _pageIndex = value;
          });
        },
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.pink,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.money_dollar,
              ),
              label: 'Earnings'),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.upload,
            ),
            label: 'Upload',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.edit,
            ),
            label: 'Edit',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.logout,
            ),
            label: 'Logout',
          ),
        ],
      ),
      body: _pages[_pageIndex],
    );
  }
}

import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

typedef void IntCallback(int value);

class CustomBottomNavigationBar extends StatefulWidget {
  final IntCallback callback;

  const CustomBottomNavigationBar({super.key, required this.callback});

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _selectedIndex = 0;

  final List<TabItem> items = [
    const TabItem(
        icon: Icon(
          FontAwesomeIcons.commentDots,
        ),
        title: 'Message'),
    const TabItem(icon: Icon(Icons.notifications), title: 'Notifications')
  ];

  void onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
    widget.callback(_selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return ConvexAppBar(
      items: items,
      activeColor: Colors.green,
      color: Colors.grey,
      backgroundColor: Colors.white,
      onTap: onTap,
      initialActiveIndex: _selectedIndex,
      style: TabStyle.react,
    );
  }
}

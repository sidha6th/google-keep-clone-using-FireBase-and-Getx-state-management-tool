

import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    required this.size,
    Key? key,
  }) : super(key: key);
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Image.network(
              'https://www.freepnglogos.com/uploads/google-logo-png/google-logo-png-google-sva-scholarship-20.png',
              width: size.shortestSide / 3,
              height: size.shortestSide / 3,
            ),
          ),
          ListView(
            shrinkWrap: true,
            children: const <Widget>[
              DraweListItem(
                icon: Icons.lightbulb_outline,
                label: 'Notes',
              ),
              DraweListItem(
                icon: Icons.notifications_none,
                label: 'Reminders',
              ),
              DraweListItem(
                icon: Icons.add,
                label: 'Create new label',
              ),
              DraweListItem(
                icon: Icons.archive_outlined,
                label: 'Archive',
              ),
              DraweListItem(
                icon: Icons.delete_outline,
                label: 'Deleted',
              ),
              DraweListItem(
                icon: Icons.settings_outlined,
                label: 'Setings',
              ),
              DraweListItem(
                icon: Icons.help_outline,
                label: 'Help & feedback',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
//====================== End Of Drawer widget ==========================//

//====================== Drawer List Items ==========================//

class DraweListItem extends StatelessWidget {
  const DraweListItem({
    required this.icon,
    required this.label,
    Key? key,
  }) : super(key: key);
  final IconData icon;
  final String label;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Icon(
                icon,
                color: Colors.black,
                size: 25,
              ),
            ),
            Text(
              label,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 22,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
//====================== End Of Drawer List Item ==========================//

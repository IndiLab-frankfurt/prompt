import 'package:flutter/material.dart';
import 'package:prompt/locator.dart';
import 'package:prompt/services/user_service.dart';
import 'package:prompt/shared/route_names.dart';
import 'package:prompt/widgets/version_info.dart';

class PromptDrawer extends StatelessWidget {
  PromptDrawer();

  _buildDrawerItem(
      {IconData icon = Icons.ac_unit,
      String text = "",
      required GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(text),
          ),
        ],
      ),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          ListTile(
            title: Container(
              padding: EdgeInsets.only(top: 20, bottom: 10.0),
              child: Container(
                  height: 140,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/icons/icon_256.png'),
                          fit: BoxFit.cover)),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(locator<UserService>().getUsername()),
                        VersionInfo()
                      ])),
            ),
          ),
          Divider(),
          _buildDrawerItem(
              icon: Icons.add_box,
              text: "Init",
              onTap: () async {
                await Navigator.pushNamed(context, RouteNames.SESSION_ZERO);
              }),
        ],
      ),
    );
  }
}

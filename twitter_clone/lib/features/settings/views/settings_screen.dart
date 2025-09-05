import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone/constants/sizes.dart';
import 'package:twitter_clone/features/settings/view_models/settings_state.dart';
import 'package:twitter_clone/features/settings/views/privacy_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("Settings")),
      body: ListView(
        children: [
          SwitchListTile(
            value: context.watch<SettingsState>().dartMode,
            onChanged: (value) {
              context.read<SettingsState>().setDarkMode(value);
            },
            title: Text("Dark mode"),
          ),
          ListTile(
            leading: Icon(Icons.person_add_outlined, size: Sizes.size32),
            title: Text("Follow and invite friends"),
          ),
          ListTile(
            leading: Icon(Icons.notifications_outlined, size: Sizes.size32),
            title: Text("Notifications"),
          ),
          ListTile(
            leading: Icon(Icons.lock_outline, size: Sizes.size32),
            title: Text("Privacy"),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => PrivacyScreen()));
            },
          ),
          ListTile(
            leading: Icon(Icons.person_outline, size: Sizes.size32),
            title: Text("Account"),
          ),
          ListTile(
            leading: Icon(Icons.help_outline, size: Sizes.size32),
            title: Text("Help"),
          ),
          ListTile(
            leading: Icon(Icons.info_outline, size: Sizes.size32),
            title: Text("About"),
          ),
          Divider(
            color: Colors.grey.shade300,
            height: Sizes.size12,
            thickness: 0.5,
          ),
          ListTile(
            title: Text(
              "Log out",
              style: TextStyle(
                color: Colors.blue,
                fontSize: Sizes.size16,
                fontWeight: FontWeight.normal,
              ),
            ),
            trailing: CupertinoActivityIndicator(),
            onTap: () {
              showCupertinoModalPopup(
                context: context,
                builder: (context) => CupertinoAlertDialog(
                  title: Text("Are you sure?"),
                  actions: [
                    CupertinoDialogAction(
                      onPressed: () => Navigator.pop(context),
                      child: Text("No"),
                    ),
                    CupertinoDialogAction(
                      isDestructiveAction: true,
                      onPressed: () => Navigator.pop(context),
                      child: Text("Yes"),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

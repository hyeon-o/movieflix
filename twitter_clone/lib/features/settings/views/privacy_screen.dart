import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twitter_clone/constants/sizes.dart';

class PrivacyScreen extends StatefulWidget {
  const PrivacyScreen({super.key});

  @override
  State<PrivacyScreen> createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends State<PrivacyScreen> {
  bool _isPrivate = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("Privacy")),
      body: ListView(
        children: [
          SwitchListTile(
            secondary: Icon(Icons.lock_outline, size: Sizes.size32),
            title: Text("Private profile"),
            value: _isPrivate,
            onChanged: (value) {
              setState(() {
                _isPrivate = value;
              });
            },
          ),
          ListTile(
            leading: Icon(Icons.attach_email_outlined, size: Sizes.size32),
            title: Text("Mentions"),
            trailing: DropdownButton<String>(
              value: "Everyone",
              icon: Padding(
                padding: const EdgeInsets.only(left: Sizes.size12),
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: Sizes.size20,
                  color: Colors.grey.shade600,
                ),
              ),
              alignment: Alignment.centerRight,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: Sizes.size16,
              ),
              items: [
                DropdownMenuItem(value: "Everyone", child: Text("Everyone")),
                DropdownMenuItem(
                  value: "People you follow",
                  child: Text("People you follow"),
                ),
                DropdownMenuItem(value: "No one", child: Text("No one")),
              ],
              onChanged: (value) {},
              underline: SizedBox(),
            ),
          ),
          ListTile(
            leading: Icon(Icons.volume_off_outlined, size: Sizes.size32),
            title: Text("Muted"),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: Sizes.size20,
              color: Colors.grey.shade600,
            ),
          ),
          ListTile(
            leading: Icon(Icons.visibility_off_outlined, size: Sizes.size32),
            title: Text("Hidden Words"),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: Sizes.size20,
              color: Colors.grey.shade600,
            ),
          ),

          Divider(
            color: Colors.grey.shade300,
            height: Sizes.size12,
            thickness: 0.5,
          ),
          ListTile(
            title: Text("Other privacy settings"),
            subtitle: Text(
              "Some settings, like restrict, apply to both Threads and Instagram and can be managed on Instagram.",
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: Sizes.size14,
              ),
            ),
            trailing: Icon(
              Icons.arrow_outward_outlined,
              size: Sizes.size20,
              color: Colors.grey.shade600,
            ),
          ),
          ListTile(
            leading: Icon(Icons.block_outlined, size: Sizes.size32),
            title: Text("Blocked profiles"),
            trailing: Icon(
              Icons.arrow_outward_outlined,
              size: Sizes.size20,
              color: Colors.grey.shade600,
            ),
          ),
          ListTile(
            leading: Icon(Icons.heart_broken_outlined, size: Sizes.size32),
            title: Text("Hide likes"),
            trailing: Icon(
              Icons.arrow_outward_outlined,
              size: Sizes.size20,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}

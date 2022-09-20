import 'package:flutter/material.dart';
import 'package:project_logic/providers/providers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({super.key, this.name});

  final String? name;

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Map userData = {};

  Future<void> getUserData() async {
    var response = await Providers.getUserById();

    if (response.statusCode == 200) {
      setState(() {
        userData = response.data;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // automaticallyImplyLeading: false,
          ),
      body: Center(
        child: Row(
          children: [
            Text("profile ${widget.name}"),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Back")),
            ElevatedButton(
                onPressed: () {
                  // Navigator.of(context).pushReplacementNamed('/Home');
                  Navigator.popAndPushNamed(context, '/Home');
                },
                child: Text("Home"))
          ],
        ),
      ),
    );
  }
}

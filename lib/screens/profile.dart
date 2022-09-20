import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Profile extends StatefulWidget {
  const Profile({super.key, this.name});

  final String? name;

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("profile ${widget.name}"),
    );
  }
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Text(name);
  }
}

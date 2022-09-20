import 'package:flutter/material.dart';
import 'package:project_logic/screens/profile.dart';

import 'screens/home/home.dart';

final Map<String, WidgetBuilder> routes = {
  '/Home': (BuildContext context) => Home(),
  "/Profile": (BuildContext context) => const Profile(),
};

final Map<String, WidgetBuilder> routesAdmin = {
  '/Home': (BuildContext context) => Home(),
  "/Profile": (BuildContext context) => const Profile(),
};

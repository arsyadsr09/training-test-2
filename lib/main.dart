import 'dart:io';

import 'package:flutter/material.dart';
import 'package:project_logic/providers/providers.dart';
import 'package:project_logic/routes.dart';
import 'package:project_logic/screens/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isAdmin = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: isAdmin ? routesAdmin : routes,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController controller = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? get _errorText {
    // at any time, we can get the text from _controller.value.text
    final text = controller.value.text;
    // Note: you can do your own custom validation here
    // Move this logic this outside the widget for more testable code
    if (text.isEmpty) {
      return 'Can\'t be empty';
    }
    if (text.length < 4) {
      return 'Too short';
    }
    // return null if the text is valid
    return null;
  }

  Future<void> onSubmitClicked() async {
    print(controller.text);
    print(passwordController.text);

    var response = await Providers.login(
        email: controller.text, password: passwordController.text);

    if (response.statusCode == 200) {
      String token =
          "laksdjlasjdlkasjdioqwjeoqwjieoiqwjeoqiwjeoq;wneq;kwjnelqkwjenkqwljneqwkjlneqwjk";
      // Obtain shared preferences.
      final prefs = await SharedPreferences.getInstance();

      await prefs.setString('USER_AUTH', token);
      // lets go to otp
      // Navigator.pushNamed(context, '/Profile');
      // or
      String resultName = "Budi";
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Profile(name: resultName)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(controller.text),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  onChanged: (value) => print(value),
                  controller: controller,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    // use the getter variable defined above
                    // errorText: _errorText,
                    icon: Icon(Icons.email),
                  ),
                ),
                TextField(
                  onChanged: (value) => print(value),
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',

                    // use the getter variable defined above
                    // errorText: _errorText,
                    icon: Icon(Icons.lock),
                  ),
                ),
                ElevatedButton(
                    onPressed: () => onSubmitClicked(), child: Text("submit"))
              ],
            ),
          ),
        ));
  }
}

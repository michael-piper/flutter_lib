import 'package:flutter/material.dart';
import 'package:dmclassik/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:dmclassik/screen/main.dart';
void main() => runApp(
    ChangeNotifierProvider<AuthService>(
        child: MyApp(),
        create: (BuildContext context){
          return AuthService();
        }
    )
);

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return screen(context);
  }
}

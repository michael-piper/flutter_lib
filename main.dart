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


//http: ^0.12.0+4
//provider: ^4.0.2
//localstorage: ^3.0.0
//image_picker: ^0.6.5+1
//shared_preferences: ^0.5.6
//flutter_paystack: ^1.0.3+1
//google_maps_webservice: ^0.0.16
//google_fonts: ^0.3.10
//flutter_dialogflow: ^0.1.3
//carousel_slider: ^1.4.1
//url_launcher: ^5.4.2
//curved_navigation_bar: ^0.3.2
//flutter_statusbarcolor: ^0.2.3

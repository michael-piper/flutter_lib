import 'package:dmclassik/screen/fund_wallet.dart';
import 'package:dmclassik/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';


import 'package:dmclassik/screen/landing.dart';
import 'package:dmclassik/screen/splash.dart';
import 'package:dmclassik/screen/auth.dart';
import 'package:dmclassik/screen/notfound.dart';
import 'package:dmclassik/screen/terms_of_service.dart';

class Routers{
  static landing(snapshot){
    if(snapshot.connectionState==ConnectionState.done){
      if(snapshot.hasData){
        LocalStorage storage = new LocalStorage(STORAGE_KEY);
        storage.setItem(STORAGE_USER_KEY,snapshot.data);
        if(snapshot.data['Role']!=null && snapshot.data['Role']['name']=="Driver"){
          return LandingPage();
        }else{
          return LandingPage();
        }
      }else{
        return AuthPage();
      }
    }else{
      return SplashPage();
    }
  }
  static splash(){
    return SplashPage();
  }
  static generatedRoutes(settings){
    List data=settings.name.split('/');
    if(data.length<=1) return;
    if(data[1]=='landing' && data[2]!=null) {
      return MaterialPageRoute(builder: (context) {
        return LandingPage();
      });
    }
    else{
      return MaterialPageRoute(builder: (context){
        return LandingPage();
      });
    }
  }
  static routes(){
    return <String, WidgetBuilder> {
      '/landing': (BuildContext context) => LandingPage(),
      '/terms_of_service': (BuildContext context) => TermsOfServicePage(),
      '/fund_wallet': (BuildContext context) => FundWalletPage()
    };
  }
  static Route unKnownRoute(RouteSettings settings){
    return PageRouteBuilder(
      pageBuilder: (BuildContext context,Animation<double> animation,
      Animation<double> secondaryAnimation){
        return NotFoundPage();
    });
  }
}
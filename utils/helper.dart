import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:dmclassik/utils/colors.dart';
import 'package:dmclassik/services/endpoints.dart';
bool get isInDebugMode{
  bool inDebugMode=false;
  assert(inDebugMode=true);
  return inDebugMode;
}

String baseURL(String path,{replace:false}){
  if(path.substring(0,8)=="https://" || path.substring(0,7)=="http://"){
    if(replace){
      path = path.replaceFirst("https://", '').replaceFirst("http://", '').split('/')[1]??'';
    }else{
      return path;
    }
  }
  return (path.substring(0,1)=='/')?BASE_URL+path:BASE_URL+'/'+path;
}

double percentage(num amount,num per,{divider:100}){
  return amount - ((amount/divider)*per);
}
enum StatusBarType{
  LIGHT,DEFAULT
}

class Helper{
  static changeStatusColor(Color color) async {
    try {
      await FlutterStatusbarcolor.setStatusBarColor(color, animate: true);
      if (useWhiteForeground(color)) {
        FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
        FlutterStatusbarcolor.setNavigationBarWhiteForeground(true);
      } else {
        FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
        FlutterStatusbarcolor.setNavigationBarWhiteForeground(false);
      }
    } on PlatformException catch (e) {
      debugPrint(e.toString());
    }
  }

  static  changeNavigationColor(Color color) async {
    try {
      await FlutterStatusbarcolor.setNavigationBarColor(color, animate: true);
    } on PlatformException catch (e) {
      debugPrint(e.toString());
    }
  }
  static changeStatusBar(StatusBarType type){
    switch(type){
      case StatusBarType.LIGHT:
        changeStatusColor(liteColor);
        changeNavigationColor(liteColor);
        break;
      case StatusBarType.DEFAULT:
      default:
        changeStatusColor(primaryColor);
        changeNavigationColor(primaryColor);
        break;
    }

  }
  static String printDurationHours(Duration duration,{int len}) {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    if(duration.inHours>0 || len == 6){
      return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
    }
    else if(duration.inMinutes>0 || len == 4){
      return "$twoDigitMinutes:$twoDigitSeconds";
    }
    else{
      return "$twoDigitSeconds";
    }
  }
}
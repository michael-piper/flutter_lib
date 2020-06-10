import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;
import 'package:dmclassik/services/api_resource.dart' as ApiResource;
import 'package:dmclassik/utils/helper.dart';
import 'package:dmclassik/utils/constants.dart';
class AuthService with ChangeNotifier{
  AuthService(){
    // print('new Service');

  }
  Future getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.containsKey(STORAGE_USER_KEY)){
      Map<String, dynamic> dat = convert.jsonDecode(prefs.getString(STORAGE_USER_KEY));
      return Future.value(dat);
    }else{
      return Future.value(null);
    }
  }
  static Future staticGetUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.containsKey(STORAGE_USER_KEY)){
      Map<String, dynamic> dat = convert.jsonDecode(prefs.getString(STORAGE_USER_KEY));
      return Future.value(dat);
    }else{
      return Future.value(null);
    }
  }


  Future login({@required phone, @required otp})async{
    return Future.value({});
  }
  Future signup({@required phone, @required country})async{
    return Future.value({});
  }
  Future sendOtp({@required phone, @required country})async{
    return Future.value({});
  }
  Future getUserForLaunch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await Future.delayed(Duration(seconds: 5));
    if(prefs.containsKey(STORAGE_USER_KEY)){
      Map<String, dynamic> dat = convert.jsonDecode(prefs.getString(STORAGE_USER_KEY));
      return Future.value(dat);
    }else{
      return Future.value(null);
    }
  }
  Future restPassword({@required phone})async{
    Map result = await ApiResource.Authorization.resetPassword({'phone':phone});
    if(result.containsKey('error')){
      return Future.value(result);
    }else{
      return Future.value({'error':true,'message':"Internet error"});
    }
  }
  Future logout()async{
    return ApiResource.Authorization.logout().then((_){
      notifyListeners();
      return Future.value(null);
    });

  }
}
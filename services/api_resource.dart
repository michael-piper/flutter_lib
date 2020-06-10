import 'dart:convert' as convert;
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'endpoints.dart';
import 'package:dmclassik/utils/constants.dart';
class ApiRes{
  ApiRes(Map res){
    if(res!=null){
      if(res['data']!=null && data is Map)data=res['data'];
      if(res['items']!=null && items is List)items=res['items'];
      if(res['item']!=null && (item is Map || item is String || item is num || item is bool)) item=res['items'];
      if(res['message']!=null && message is String)message=res['message'];
      if(res['status']!=null && status is String)status=res['status'];
      if(res['error']!=null && error is bool)error=res['error'];
      if(res['success']!=null && success is bool)success=res['success'];
    }
  }

  Map  data;
  List items;
  dynamic item;
  String message;
  String status;
  bool error;
  bool success;
}
class ApiStatus{
  static const String error='error';
  static const String success='sucess';
  static const String ok='ok';
  static bool isSuccess(String _){
    if(_==ok || _==success) return true;
    return false;
  }
  static bool isOk(String _){
    if(_==ok || _==success) return true;
    return false;
  }
  static bool isError(String _){
    if(_==error) return true;
    return false;
  }

}

class Authorization{
  static Future login({id=false})async{

  }
  static Future logout()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.containsKey(STORAGE_USER_KEY)){
      var wait = convert.jsonDecode(prefs.getString(STORAGE_USER_KEY));
      // print(wait);
      if(wait.containsKey('authorization')){

      }
      prefs.remove(STORAGE_USER_KEY);
    }
  }
  static Future signup({@required phone})async{


  }
  static Future sentOtp(body)async {
    var bytes = convert.utf8.encode(body['username']+':'+body['password']);
    var base64Str = convert.base64.encode(bytes);
    Map<String, String> headers={'Authorization':'Basic '+base64Str};
    try{
      var response = await http.put(API_AUTH_URL,headers: headers );
      if ( response.statusCode == 200) {
        return convert.jsonDecode(response.body);
      } else {
        return false;
      }
    }
    catch(e){
      print(e);
      return {'error':true,'message':"An error occured while trying to login"};
    }
  }
  static Future createAuth(body) async {
    try{
      var response = await http.post(API_AUTH_URL, body: body );
      print(response.request.url);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return convert.jsonDecode(response.body);
      } else {
        return {'error':true,'message':"Couldn't complete request"};
      }
    }
    catch (e){
//    print(e);
      return {'error':true,'message':"An error occured while trying to create your profile"};
    }
  }
  static Future resetPassword(body)async{
    Map<String, String> headers={};
    try{
      var response = await http.patch(API_AUTH_URL,body:body,headers: headers);
      if (response.statusCode == 200) {
        return convert.jsonDecode(response.body);
      } else {
        return {'error':true,'message':"Couldn't complete request"};
      }
    }
    catch(e){
      // print(e);
      return {'error':true,'message':"An error occured while trying to recover account"};
    }
  }
  static Future destroyAuth(body)async{
    Map<String, String> headers={'Authorization':body};
    try{
      var response = await http.delete(API_AUTH_URL, headers: headers);
      if (response.statusCode == 200) {
        return convert.jsonDecode(response.body);
      } else {
        return {'error':true,'message':"Couldn't complete request"};
      }
    }
    catch(e){
      return {'error':true,'message':"An error occured while trying complete request"};
    }
  }
}


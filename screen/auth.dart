// Flutter code sample for

// This example shows a [Form] with one [TextFormField] and a [RaisedButton]. A
// [GlobalKey] is used here to identify the [Form] and validate input.
import 'dart:async';

import 'package:flutter/rendering.dart';
import 'package:dmclassik/screen/terms_of_service.dart';
import 'package:dmclassik/services/api_resource.dart' as ApiResource;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';
// import service here
import 'package:dmclassik/services/auth.dart';
// import color
import 'package:dmclassik/utils/colors.dart';
import 'package:dmclassik/utils/helper.dart';
import 'package:dmclassik/ext/smartalert.dart';
import 'package:dmclassik/ext/dialogman.dart';
import 'package:dmclassik/utils/country.dart';
/// This Widget is the main application widget.
class AuthPage extends StatelessWidget {
  // static const String _title = 'Welcome';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
 
  final _formKey = GlobalKey<FormState>();
  String _countryCode;
  String _phoneCode;
  String _phone;
  String _otp;
  int _screen;
  bool _loading=false;
  TextEditingController _textController = TextEditingController();
  final DialogMan dialogMan = DialogMan(child: Scaffold(
      backgroundColor: Colors.transparent,
      body:Center(
          child:CircularProgressIndicator()
      )
  ));
  @override
  void initState(){
    super.initState();
    Helper.changeStatusBar(StatusBarType.DEFAULT);
  }
  Future sendOTP(authService)async{
    await Future.delayed(Duration(seconds: 1));
    return Future.value(true);
//                        var wait=authService.loginUser(phone:_phone);
//                        wait.then((status){
//                          if(status['error']){
//                            return  Scaffold.of(context).showSnackBar(SnackBar(content:Text(status['message'])));
//                          }
//                          else {
//                            return Scaffold.of(context).showSnackBar(SnackBar(content:Text(status['message'])));
//                          }
//                        }).catchError((e)=>print(e));
  }
  Widget signUp(AuthService authService){
    return  Container(
      // Center is a layout widget. It takes a single child and positions it
      // in the middle of the parent.
      child: Form(
          key: _formKey,
          child:Padding(
              padding: const EdgeInsets.all(16.0),
              child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(padding:EdgeInsets.only(top: 20),),
                  Text(
                    'Login',
                    style: TextStyle(fontFamily: "Lato",fontStyle:FontStyle.normal,fontWeight: FontWeight.w600,fontSize: 20),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 14,horizontal: 5),
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 1,
                              color:  noteColor
                          ),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5.0),
                              bottomLeft: Radius.circular(5.0)
                          ),
                        ),
                        child:  _countryCode==null ?
                        Icon(Icons.map,size: 29,):
                        Image(
                          image: AssetImage('assets/flags-160/${_countryCode.toLowerCase()}.png'),
                          fit: BoxFit.fill,
                          width: 61,
                          height: 30,
                        ),
                      ),
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                              hintText: 'Country',
                              suffixIcon: Icon(Icons.arrow_drop_down),
                              border: OutlineInputBorder(borderSide: BorderSide(color: noteColor))
                          ),
                          controller: _textController,
                          validator: (value){
                            if (value==null) {
                              return 'Please choose a country';
                            }
                            return null;
                          },
                          readOnly: true,
                          onTap: (){
                            f(country){
                              Helper.changeStatusBar(StatusBarType.DEFAULT);
                              if(country==null)return;
                              setState(() {
                                _textController.text = country['name'];
                                _countryCode = country['code'];
                                _phoneCode = country['dial_code'];
                                _phone = _phoneCode;
                              });
                            }
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) =>ChooseCountry(selected: _countryCode,))).then(f);
                          },
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height:50.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all( 20),
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 1,
                              color:  noteColor
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5.0),
                             bottomLeft: Radius.circular(5.0)
                          ),
                        ),
                        child:Text(_phoneCode==null?'+...':_phoneCode),
                      ),
                      Expanded(
                        child: TextFormField(
                          decoration: const InputDecoration(
                              labelText: 'Phone Number',
                              labelStyle: TextStyle(
                                color:  secondaryTextColor,
                              ),
                              border: OutlineInputBorder(borderSide: BorderSide(color: noteColor))
                          ),
                          initialValue: _phone,
                          onSaved: (value)=> _phone = value,
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter your phone number';
                            }
                            return null;
                          },
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height:25.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("i Agree to the terms ",
                        style: TextStyle(
                          color:  secondaryTextColor,
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          if(_loading) {
                            return;
                          }
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => TermsOfServicePage())).then((v)=>Helper.changeStatusBar(StatusBarType.DEFAULT));
                        },
                        child: Text("Terms of Service",
                          style: TextStyle(
                            color:  actionColor,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height:25.0,
                  ),
                  MaterialButton(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    color: primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                            top: Radius.elliptical(30.0,30.0),
                            bottom: Radius.elliptical(30.0,30.0)
                        ),
                        side: BorderSide(color: primarySwatch)
                    ),
                    onPressed: () {
                      // Validate will return true if the form is valid, or false if
                      // the form is invalid
                      final form = _formKey.currentState;
                      form.save();
                      if (_formKey.currentState.validate()) {
                        sendOTP(authService).then((_){
                          setState(() {
                            _screen=2;
                          });
                        });
                      }
                    },
                    child:_loading?
                      Text('loading...',style: TextStyle(fontSize: 16.0, color:primaryTextColor)):
                      Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                         'Continue',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: primaryTextColor,
                          ),
                        ),
                        Icon(Icons.arrow_forward,color:primaryTextColor,)
                      ],
                    ),
                  ),
                ],
              )
          ),
        )
    );
  }
//  autoFill()async{
//    await SmsAutoFill().listenForCode;
//  }
  Widget login(AuthService authService){
    return Container(
      child: Form(
        key: _formKey,
        child:Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding:EdgeInsets.only(top: 20,bottom: 10),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: IconButton(

                    icon:Icon(Icons.arrow_back_ios),
                    onPressed: (){
                      setState(() {
                        _screen=1;
                      });
                    },
                  ) ,
                ),
              ),
              Text(
                'Enter the OTP',
                style: TextStyle(fontFamily: "Lato",fontStyle:FontStyle.normal,fontWeight: FontWeight.normal,fontSize: 20),

              ),
              SizedBox(
                height: 40.0,
              ),
              MaterialButton(
                padding: EdgeInsets.symmetric(vertical: 15),
                color: primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                        top: Radius.elliptical(30.0,30.0),
                        bottom: Radius.elliptical(30.0,30.0)
                    ),
                    side: BorderSide(color: primarySwatch)
                ),
                onPressed: () {
                  // Validate will return true if the form is valid, or false if
                  // the form is invalid.
                  final form = _formKey.currentState;
                  form.save();

                  if (_formKey.currentState.validate()) {
                    if(_loading) {
                      return;
                    }
                    setState(() {
                      _loading=true;
                    });
                    authService.login(phone:_phone,otp:_otp).then((status){
                        setState(() {
                          _loading=false;
                        });
                        ApiResource.ApiRes res = ApiResource.ApiRes(status);
                        if(ApiResource.ApiStatus.isError(res.status)){
                          Scaffold.of(context).showSnackBar(SnackBar(content:Text(status['message'])));
                        }
                        else{
                          setState(() {
                            // Process data.
                            _screen=1;
                          });
                        }
                      }
                    );
                  }
                },
                child:_loading?
                Text('loading...',style: TextStyle(fontSize: 16.0, color:primaryTextColor)):
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Confirm',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: primaryTextColor,
                      ),
                    ),
                    Icon(Icons.arrow_forward,color:primaryTextColor,)
                  ],
                ),
              ),
              SizedBox(
                height: 25.0,
              ),
              ShowCountdown(sendOTP: ()=>sendOTP(authService),count: 160,),
              SizedBox(
                height: 15.0,
              ),
            ]
          )
        )
      )
    );
  }
  @override
  Widget build(BuildContext context) {
    dialogMan.buildContext(context);
    Widget buildBody(_body) {
      return Stack(
        fit:StackFit.expand,
        children: <Widget>[
          Positioned(
            bottom: 0,
            height: 150,
            child: Image(
              image: AssetImage('assets/images/login-bottom.png'),
              fit: BoxFit.fill,
              width: MediaQuery.of(context).size.width,
              height: 150,
            ),
          ),
          Positioned(
            bottom: 0,
            height: 150,
            child: Image(
              image: AssetImage('assets/icons/x.png'),
              width: 50,
              height: 50,
            ),
          ),
          Positioned(
            child: ListView(
              shrinkWrap: false,
              children: <Widget>[
                _body,
              ],
            ),
          ),
        ],
      );

    }
    switchScreen(AuthService authService) {
      switch (_screen) {
        case 2:
          {
            return login(authService);
          }
          break;
        default:
          {
            return signUp(authService);
          }
          break;
      }
    }
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(20.0),// here the desired height
        child: AppBar(
            elevation: 0,
            brightness: Brightness.dark,
            iconTheme: IconThemeData(color: primaryTextColor),
        ),
      ),
      body:Consumer<AuthService>(
        builder: (context, authService, child){
          return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: buildBody(switchScreen(authService)),
          );
        },
      )
    );
  }
}

class ShowCountdown extends StatefulWidget{
  ShowCountdown({@required this.count,@required this.sendOTP, this.onDone,this.disable=false});
  final int count;
  final Function onDone;
  final Function sendOTP;
  final bool disable;
  _ShowCountdown createState()=>_ShowCountdown();
}

class _ShowCountdown extends State<ShowCountdown> {
  int _count;
  Timer _t;
  @override
  initState(){
    super.initState();
    startCountDown();
  }
  startCountDown()async{
    _count=widget.count;
    if(null==widget.count){
      _count=120;
    }
    callback(Timer t){
      if(_count==0){
        if(widget.onDone!=null) widget.onDone();
        return t.cancel();
      }
      setState(() {
        _count--;
      });
    }
    _t=Timer.periodic(Duration(seconds: 1), callback);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _t.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if(widget.disable){
      return Container();
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(_count==0? "Didn't get OTP?":"Wait for ${Helper.printDurationHours(new Duration(seconds: _count),len: 4)} to "),
        InkWell(
          onTap: (){
            if(_count==0){
              widget.sendOTP();
              startCountDown();
            }
          },
          child: Text(" Resend",
            style: TextStyle(
              color:  actionColor,
            ),
          ),
        )
      ],
    );
  }
}


class ForgetPasswordScreen extends StatefulWidget{
  _ForgetPasswordScreen createState()=>_ForgetPasswordScreen();
}

class _ForgetPasswordScreen extends State<ForgetPasswordScreen>{
  final _formKey = GlobalKey<FormState>();
  bool _loading=false;
  String _forgotDetails;
  void initState(){
    super.initState();
    Helper.changeStatusBar(StatusBarType.LIGHT);
  }
  Widget forgotPassword(authService){
    return Container(
      // Center is a layout widget. It takes a single child and positions it
      // in the middle of the parent.
        child: Form(
          key: _formKey,
          child:Padding(
              padding: const EdgeInsets.symmetric(vertical:16.0,horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(padding:EdgeInsets.only(top: 20),),
                  Center(
                    child: Image(
                        image: AssetImage('assets/icons/reset.png'),
                        width: 165,
                        height: 160.05
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Text(
                    'Forgot Password?',
                    style: TextStyle(fontFamily: "Lato",fontStyle:FontStyle.normal,fontWeight: FontWeight.w600,fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Text(
                    'No problem! \nJust enter your email address and we\’ll send you a \npassword reset link',
                    style: TextStyle(color:noteColor),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  TextFormField(
                    initialValue:_forgotDetails ,
                    onSaved: (value)=> _forgotDetails = value,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.person,color: secondaryTextColor),
                      labelText: 'Email or Phone',
                      labelStyle: TextStyle(
                        color:  secondaryTextColor,
                      ),
                    ),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    onChanged: (v) => _forgotDetails = v,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter your phone or email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  MaterialButton(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    color: primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                            top: Radius.elliptical(30.0,30.0),
                            bottom: Radius.elliptical(30.0,30.0)
                        ),
                        side: BorderSide(color: primarySwatch)
                    ),
                    onPressed: () {
                      // Validate will return true if the form is valid, or false if
                      // the form is invalid
                      final form = _formKey.currentState;
                      form.save();
                      if (_formKey.currentState.validate()) {
                        if(_loading){
                          return;
                        }
                        setState(() {
                          _loading=true;
                        });
                        var wait=authService.forgotPassword(phone: _forgotDetails);
                        wait.then((status){
                          setState(() {
                            _loading=false;
                          });
                          return showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context ){
                              return SmartAlert(title:'Alert',description: status['message']);
                            });
                        });
                      }
                    },
                    child: Text((_loading?'loading...':'Reset'),
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                ],
              )
          ),
        )
    );

  }
  appBar(BuildContext context){
    return AppBar(
      bottom: PreferredSize(
          preferredSize: Size.fromHeight(25.0),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child:Row(
              children: <Widget>[
                IconButton(icon:Icon(Icons.arrow_back_ios),onPressed: (){
                  Navigator.of(context).pop(true);
                },),
              ],
            ),
          )
      ),
      leading: Container(),
      elevation: 0,
      backgroundColor: liteColor,
      brightness: Brightness.dark,
      iconTheme: IconThemeData(color: liteTextColor),
    );
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(80.0),// here the desired height
            child: appBar(context)
        ),
        backgroundColor:primaryTextColor,
        body:Consumer<AuthService>(
        builder: (context, authService, child){
          return ListView(
            children: <Widget>[
              forgotPassword(authService)
            ],
          );
        }
      ) // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}


class ChooseCountry extends StatefulWidget{
  final String selected;
  ChooseCountry({this.selected});
  _ChooseCountry createState()=>_ChooseCountry();
}

class _ChooseCountry extends State<ChooseCountry>{
  List<Map> _countriesCode= countriesCode;
  void initState(){
    super.initState();
    Helper.changeStatusBar(StatusBarType.LIGHT);
  }
  showCountry(e){
    return InkWell(
      onTap: (){
        Navigator.of(context).pop(e);
      },
      child:Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Image(
                image: AssetImage('assets/flags-160/${e['code'].toString().toLowerCase()}.png'),
                width: 61,
                height: 30,
                fit: BoxFit.fill,
              ),
              SizedBox(width: 5,),
              Text(e['name'],style:TextStyle(color: textColor),textAlign: TextAlign.center,)
            ],
          ),
          Divider()
        ],
      ),
    );
  }
  appBar(BuildContext context){
    return AppBar(
      bottom: PreferredSize(
          preferredSize: Size.fromHeight(25.0),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child:Row(
              children: <Widget>[
                IconButton(icon:Icon(Icons.arrow_back_ios),onPressed: (){
                  Navigator.of(context).pop(null);
                },),
              ],
            ),
          )
      ),
      leading: Container(),
      elevation: 0,
      backgroundColor: liteColor,
      brightness: Brightness.dark,
      iconTheme: IconThemeData(color: liteTextColor),
    );
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(80.0),// here the desired height
          child: appBar(context)
      ),
      backgroundColor:primaryTextColor,
      body:Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              decoration: const InputDecoration(
                  labelText: 'Search ....',
                  labelStyle: TextStyle(
                    color:  secondaryTextColor,
                  ),
                  border: OutlineInputBorder(borderSide: BorderSide(color: noteColor))
              ),
              onChanged: (_){
                List<Map<String,dynamic>> _countries =[];
                 countriesCode.forEach((Map<String,dynamic> e){
                    if( e['name'].toLowerCase().indexOf(_.toLowerCase())>-1) _countries.add(e);
                  });
                setState(() {
                  _countriesCode = _countries;
                });
              },
            ),
            SizedBox(height: 10,),
            Expanded(
              child: ListView.builder(itemCount:_countriesCode.length,itemBuilder: (context, idx){
                return showCountry(_countriesCode[idx]);
              }),
            )
          ],
        ),
      )// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
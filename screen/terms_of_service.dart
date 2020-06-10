
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:dmclassik/utils/helper.dart';
// import color
import 'package:dmclassik/utils/colors.dart';
import 'package:dmclassik/ext/smartalert.dart';
class TermsOfServicePage extends StatefulWidget{
  _TermsOfServicePage createState()=>_TermsOfServicePage();
}

class _TermsOfServicePage extends State<TermsOfServicePage>{
  final _formKey = GlobalKey<FormState>();
  bool _loading=false;
  String _forgotDetails;
  void initState(){
    super.initState();
    Helper.changeStatusBar(StatusBarType.LIGHT);
  }
  Widget body(){
    return Container(
      // Center is a layout widget. It takes a single child and positions it
      // in the middle of the parent.
      child: Column(
        children: <Widget>[
          Text('Terms of service')
        ],
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
                IconButton(
                  icon:Icon(Icons.arrow_back_ios),
                  onPressed: (){
                    Navigator.of(context).pop(true);
                  },
                ),
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
      body: ListView(
        children: <Widget>[
          body()
        ]
      )
    );
  }
}
import 'package:flutter/material.dart';

class SmallCard extends StatelessWidget{
  final String name;
  final String avatar;
  final String link;
  final double width;
  final double height;
  final Color color;
  final double radius;
  final BoxFit fit;
  final String subtitle;
  final Function onTap;
  SmallCard({this.name,this.avatar,this.onTap,this.link,this.width: 80,this.height: 80,this.color : Colors.white,this.radius=5,this.fit:BoxFit.fill,this.subtitle});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5.0),

      child:  InkWell(
        onTap: onTap==null? (){
          if(link!=null)Navigator.of(context).pushNamed(link);
        }:onTap,
        child:Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color:this.color,
                borderRadius: new BorderRadius.circular(this.width/this.radius),
              ),
              child:(avatar!=null?ClipRRect(
                borderRadius: new BorderRadius.circular(8.0),
                child: Image(
                    image: (avatar.substring(0,4)=="http")?NetworkImage(avatar):AssetImage(avatar),
                    width: width,
                    height: height,
                    fit: fit,
                  ),
              ):Container(width: width,height: height,)),
            ),
            Text(name),
            Text(subtitle==null?'':subtitle)
          ],
        ) ,
      ),
    );
  }
}
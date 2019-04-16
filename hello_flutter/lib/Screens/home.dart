import 'package:flutter/material.dart';
import './home.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.deepPurple,
      child: Center(
        child: Text(
          sayHello(),
          textDirection: TextDirection.ltr,
          style: TextStyle(color: Colors.white, fontSize: 36.0),
        ),
      ),
    );
  }

  String sayHello() {
    String hello;

    DateTime now = new DateTime.now();
    int minute = now.minute;

    int hour = now.hour;
    if (hour < 12) {
      hello = "Good Morning";
    } else if (hour < 18 ) {
      hello = "Good AfterNoon";
    } else {
      hello = "Good Evening";
    }
    String minutes = (minute < 10) ? "0" + minute.toString() : minute.toString();
    return "It's now " + hour.toString() + ":" + minutes + ". \n " + hello;





    // num myNum;
    // myNum = 43;
    // return hello;
  }
}




/*
class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Colors.red,
        margin: new EdgeInsets.only(
            left: 24.0,
            right: 42.0,
            bottom: 24.0
        ),
        child: new Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new RaisedButton(
                onPressed: ()=>{},
                color: new Color(0xFF00D99D),
                elevation: 10.0,
                padding: new EdgeInsets.symmetric(vertical: 16.0, horizontal: 30.0),
                splashColor: new Color(0xFF00FF00),
//                shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(32.0)),
                child: new Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new Text(
                      "BOOK A TABLE",
                      style: new TextStyle(
                          color: new Color(0xFFFFFFFF)
                      ),
                    ),
                    new Icon(Icons.arrow_forward_ios, color: new Color(0xFFFFFFFF))
                  ],
                )),



          ],
        ),
        alignment: Alignment.bottomLeft
    );
  }
}
*/
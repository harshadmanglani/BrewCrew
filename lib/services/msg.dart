import 'package:brewcrew/models/msgholder.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
class Message extends StatefulWidget {
  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<Message> {

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
   _getToken() {
    _firebaseMessaging.getToken().then((deviceToken) {
      print("Device Token: $deviceToken");
    });
  }

  @override
  void initState() {
    super.initState();
    print("dude");
    _getToken();
  }

  @override
  Widget build(BuildContext context) {
     initState();
    return Container();
  }
}

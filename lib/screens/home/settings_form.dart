import 'package:brewcrew/models/user.dart';
import 'package:brewcrew/services/database.dart';
import 'package:brewcrew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:brewcrew/shared/constants.dart';
import 'package:provider/provider.dart';
import 'dart:io';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4', '5'];
  final List<int> strengths = [100, 200, 300, 400, 500, 600, 700, 800, 900];

  String _currentName, _currentSugars;
  int _currentStrength;

  @override
  Widget build(BuildContext context) {

    User user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
      stream: Database(uid: user.uid).userData,
      builder: (context, snapshot) {
        //print(snapshot.data);
        if(snapshot.hasData)
          {
            UserData userData = snapshot.data;
            return Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text(
                  "Update preferences",
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  initialValue: userData.name,
//                  initialValue: "New Name",
                  decoration: inputdec,
                  validator: (val) => val.isEmpty? "Please enter a name": null,
                  onChanged: (val) => setState(() => _currentName = val),
                ),
                SizedBox(height: 20.0),
                //dropdown
                DropdownButtonFormField(
                  decoration: inputdec,
                  value: _currentSugars ?? userData.sugars,
//                  value: _currentSugars ?? "0",
                  items: sugars.map((sugar)
                  {
                    return DropdownMenuItem(
                      value: sugar,
                      child: Text('$sugar sugar(s)'),
                    );
                  }).toList(),
                  onChanged: (val) => setState(() => _currentSugars = val),
                ),
                //slider
                Slider(
                  value: (_currentStrength ?? userData.strength).toDouble(),
                  activeColor: Colors.brown[_currentStrength ?? userData.strength],
                  inactiveColor: Colors.brown[_currentStrength ?? userData.strength],
//                  value: (_currentStrength ?? 100).toDouble(),
//                  activeColor: Colors.brown[_currentStrength ?? 100],
//                  inactiveColor: Colors.brown[_currentStrength ?? 100],
                  min: 100.0,
                  max: 900.0,
                  divisions: 8,
                  onChanged: (val) => setState(() => _currentStrength = val.round()),
                ),
                RaisedButton(
                  color: Colors.pink[400],
                  child: Text(
                    "Update",
                    style: TextStyle(color: Colors.white)
                  ),
                  onPressed: () async {
                    if(_formKey.currentState.validate()){
                      await Database(uid: user.uid).updateUserData(
                         _currentSugars ?? userData.sugars,
                        _currentName ?? userData.name,
                        _currentStrength ?? userData.strength,
                      );
                      Navigator.pop(context);
                    }
                  },
                )
              ],
            )
          );}
        else{
          return Loading();
        }
      }
    );
  }
}

import 'package:brewcrew/services/auth.dart';
import 'package:brewcrew/shared/constants.dart';
import 'package:brewcrew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:brewcrew/screens/authenticate/authenticate.dart';

class Register extends StatefulWidget {
  final Function toggle;
  Register({this.toggle});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  bool loading = false;
  final _formkey = GlobalKey<FormState>();
  String password = '', email = '', error = '';

  @override
  Widget build(BuildContext context) {
    return loading? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Register for Brew Crew'),
        actions: <Widget>[
          FlatButton.icon(onPressed: (){
            widget.toggle();
          }, icon: Icon(Icons.person), label: Text("Sign In")),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
        child: Container(
          child: Form(
            key: _formkey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0),

                TextFormField(
                  decoration: inputdec.copyWith(hintText: "Email"),
                  validator: (val) => val.isEmpty ? 'Enter an email' : null,
                  onChanged: (val) {
                    setState(() {
                      email = val;
                    });
                  },
                ),
                SizedBox(height: 20.0),

                TextFormField(
                  decoration: inputdec.copyWith(hintText: "Password"),
                  validator: (val) => val.length < 6 ? 'Password should be >= 6 char' : null,
                  obscureText: true,
                  onChanged: (val) {
                    setState(() {
                      password = val;
                    });
                  },
                ),
                SizedBox(height: 20.0),

                RaisedButton(
                  color: Colors.pink[400],
                  child: Text('Sign Up', style: TextStyle(color: Colors.white),),
                  onPressed: () async {
                    if(_formkey.currentState.validate())
                    {
                      setState(() {
                        loading = true;
                      });
                      dynamic result = await _auth.registerwithEmailandPassword(email, password);
                      if(result == null)
                        setState(() {
                          loading = false;
                          error = "Please enter a valid email and retry.\n";
                        });
                      else
                        {
                          error = '';
                        }
                    }
                    else
                    {

                    }
                  },
                  elevation: 10.0,
                ),
                SizedBox(height: 12.0),

                Text(error, style: TextStyle(color: Colors.red, fontSize: 14.0),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

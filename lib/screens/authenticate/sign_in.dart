import 'package:brewcrew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:brewcrew/services/auth.dart';
import 'package:brewcrew/screens/authenticate/authenticate.dart';
import 'package:brewcrew/shared/constants.dart';

class SignIn extends StatefulWidget {
  final Function toggle;
  SignIn({this.toggle});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();
  String password = '', email = '', error = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign in to Brew Crew'),
        actions: <Widget>[
          FlatButton.icon(onPressed: (){
            widget.toggle();
          }, icon: Icon(Icons.person), label: Text("Register")),
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
                  child: Text('Sign In', style: TextStyle(color: Colors.white),),
                  onPressed: () async {
                    if(_formkey.currentState.validate())
                      {
                        setState(() {
                          loading = true;
                        });
                        dynamic result = await _auth.siginwithEmailandPassword(email, password);
                        if(result == null)
                          setState(() {
                            loading = false;
                            error = "Invalid Credentials.\n";
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//RaisedButton(
//child: Text("Anonymus sign in here"),
//onPressed: () async {
//dynamic result = await _auth.signinAnon();
//if (result == null)
//print("Error signing in.\n");
//else
//print("signed in");
//print(result.uid);
//},
//),

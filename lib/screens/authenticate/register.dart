import 'package:caoffee_cafe/screens/authenticate/sign_in.dart';
import 'package:caoffee_cafe/services/auth.dart';
import 'package:flutter/material.dart';
class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth=AuthService();
  final _formKey = GlobalKey<FormState>();

  String email='';
  String password='';
  String error='';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],

      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 1.0,
        title: Text('Sign Up to Coffee Cafe'),
        actions: [
          FlatButton.icon(onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (buildContext) => SignIn()));
          },
              icon: Icon(Icons.person),
              label: Text('Sign In'))
        ],
      ),

      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 20.0),
              TextFormField(
                validator: (val) => val.isEmpty ? 'Enter an email' : null,
                decoration: InputDecoration(
                  icon: Icon(Icons.person),
                  labelText: 'Email',
                ),
                onChanged: (val){
                  setState(() => email = val);
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: InputDecoration(
                  icon: Icon(Icons.security),
                  labelText: 'Password',
                ),
                obscureText: true,
                validator: (val) =>val.isEmpty ? 'Enter password' : val.length<6 ? 'Password must be at least 6 charcters' : null,
                onChanged: (val){
                  setState(() => password = val);
                },
              ),
              SizedBox(height: 20.0,),
              RaisedButton(
                color: Colors.orange[400],
                child: Text(
                  'Register',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () async {
                  if(_formKey.currentState.validate()){
                    dynamic result = await _auth.registerwithEmailandPassword(email, password);
                    if(result == null){
                      setState(() {
                        error = 'either account exists or invalid email';
                      });
                    }
                  }
                },
              ),
              SizedBox(height: 20.0,),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}

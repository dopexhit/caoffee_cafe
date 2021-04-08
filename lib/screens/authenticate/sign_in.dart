import 'package:caoffee_cafe/screens/authenticate/register.dart';
import 'package:caoffee_cafe/screens/home/home.dart';
import 'package:caoffee_cafe/services/auth.dart';
// import 'package:caoffee_cafe/shared/loading.dart';
import 'package:flutter/material.dart';
class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}
//this is a test comment
class _SignInState extends State<SignIn> {
  final AuthService _auth=AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading=false;

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
        title: Text('Sign In to Coffee Cafe'),
        actions: [
          FlatButton.icon(onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (buildContext) => Register()));
            },
              icon: Icon(Icons.person),
              label: Text('Register'))
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
                validator: (val) => val.isEmpty ? 'Enter email' : null,
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
                validator: (val) => val.isEmpty ? 'Enter Password' : null,
                decoration: InputDecoration(
                  icon: Icon(Icons.security),
                  labelText: 'Password',
                ),
                obscureText: true,
                onChanged: (val){
                    setState(() => password = val);
                },
              ),
              SizedBox(height: 20.0,),
              RaisedButton(
                color: Colors.orange[400],
                child: Text(
                  'Sign In',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () async {
                  if(_formKey.currentState.validate()){
                    setState(() {
                      loading=true;
                    });
                    dynamic result = await _auth.signInwithEmailandPassword(email, password);
                     if(result == null){
                        setState(() {
                          loading=false;
                          error = 'Invalid Credentials';
                       });
                     }
                     else{
                       Navigator.pushReplacement(context, MaterialPageRoute(builder: (buildContext) => Home()));
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

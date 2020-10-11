import 'package:caoffee_cafe/screens/authenticate/authenticate.dart';
import 'package:caoffee_cafe/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:caoffee_cafe/models/user.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<CustomUser>(context);
    //if signed in then home else authenticate
    if(user == null) return Authenticate();
    else return Home();
  }
}

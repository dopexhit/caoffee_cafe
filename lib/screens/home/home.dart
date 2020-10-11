import 'package:caoffee_cafe/models/brew.dart';
import 'package:caoffee_cafe/screens/authenticate/register.dart';
import 'package:caoffee_cafe/screens/home/brew_list.dart';
import 'package:caoffee_cafe/screens/home/settings_form.dart';
import 'package:caoffee_cafe/services/auth.dart';
import 'package:caoffee_cafe/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {

  final AuthService _auth=AuthService();

  @override
  Widget build(BuildContext context) {

    void _showSettingsPanel(){
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: SettingsForm(),
        );
      });
    }

    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          backgroundColor: Colors.brown[400],
          title: Text('Coffee Cafe'),
          elevation: 1.0,
          actions: <Widget>[
            FlatButton.icon(onPressed: () async {
              await _auth.signOut().then((value) => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_){return Register();})));
            },
                icon: Icon(Icons.person),
                label: Text('Sign Out')),
            FlatButton.icon(
              icon: Icon(Icons.settings),
              label: Text('settings'),
              onPressed: () => _showSettingsPanel(),
            ),
          ],
        ),
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage('https://png.pngtree.com/thumb_back/fh260/back_our/20190617/ourmid/pngtree-coffee-fragrance-vintage-background-image_125053.jpg'),
                fit: BoxFit.cover,
              )
            ),
            child: BrewList()
        ),
      ),
    );
  }
}

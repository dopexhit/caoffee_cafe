import 'package:caoffee_cafe/models/user.dart';
import 'package:caoffee_cafe/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formKey = GlobalKey<FormState>();
  final List<String> sugars= ['0', '1', '2' ,'3' ,'4'];

  //form values
  String _currentName='new crew member';
  String _currentSugars = '0';
  int _currentStrength= 100;


  @override
  Widget build(BuildContext context) {

    final user=Provider.of<CustomUser>(context);

    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Text(
            'Update your brew Settings',
            style: TextStyle(fontSize: 18.0),
          ),
          SizedBox(height: 20.0),
          TextFormField(
            validator: (val) => val.isEmpty ? 'Please enter a name' : null,
            decoration: InputDecoration(
              icon: Icon(Icons.person),
              labelText: 'Name',
            ),
            onChanged: (val){
              setState(() => _currentName = val);
            },
          ),
          SizedBox(height: 20.0),
          //dropdown
          DropdownButtonFormField(
            items: sugars.map((sugar){
              return DropdownMenuItem(
                value: sugar,
                child: Text('$sugar sugars'),
              );
            }).toList(),
            onChanged: (val) =>setState(()=>_currentSugars = val),
          ),
          SizedBox(height: 20.0),
          //slider
          Slider(
            value: (_currentStrength ?? 100).toDouble(),
            min: 100.0,
            max: 900.0,
            divisions: 8,
            onChanged: (val)=> setState(()=> _currentStrength = val.round()),
            activeColor: Colors.brown[_currentStrength ?? 100],
            inactiveColor: Colors.brown[_currentStrength ?? 100],
          ),
          SizedBox(height: 20.0),
          RaisedButton(
            color: Colors.orange[400],
            child: Text(
              'Update',
              style: TextStyle( color: Colors.white),
            ),
            onPressed: () async {
              if(_formKey.currentState.validate()){
                await DatabaseService(uid: user.uid).updateUserData(_currentSugars, _currentName, _currentStrength);
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
    );
  }
}

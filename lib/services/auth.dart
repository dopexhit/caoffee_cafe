import 'package:caoffee_cafe/models/user.dart';
import 'package:caoffee_cafe/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService{

  final FirebaseAuth _auth=FirebaseAuth.instance;

  //creating user object based on FirebaseUser
  CustomUser _userFromFirebaseUser(FirebaseUser user){
    return user != null ? CustomUser(uid: user.uid) : null;
  }

  //auth change user stream of data changes
  Stream<CustomUser> get user{
    return _auth.onAuthStateChanged
        .map((FirebaseUser user) => _userFromFirebaseUser(user));
  }

  //sign in anonymously
  Future signInAnon() async{
    try{
      AuthResult result=await _auth.signInAnonymously();
      FirebaseUser user= result.user;
      return _userFromFirebaseUser(user);
    } catch(e){
      print(e.toString());
      return null;
    }
  }
  //sign in email pass
  Future signInwithEmailandPassword(String email, String password) async{
    try{
      // AuthResult result=await _auth.signInWithEmailAndPassword(email: email, password: password);
      // FirebaseUser user = result.user;
      // return _userFromFirebaseUser(user);
      return await _auth.signInWithEmailAndPassword(email: email, password: password);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //register email pass
  Future registerwithEmailandPassword(String email, String password) async{
    try{
      AuthResult result=await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;

      //create new document with uid
      await DatabaseService(uid: user.uid).updateUserData('0', 'new crew member', 100);
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString);
      return null;
    }
  }
}
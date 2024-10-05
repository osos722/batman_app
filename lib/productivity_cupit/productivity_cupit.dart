import 'package:failed4/sirveces/notification.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'app_states.dart';
class pro_cupit extends Cubit<big_states> {
  pro_cupit(initialstate st) :  super(st);

bool? is_signin;
Future<void> getter()async{
  SharedPreferences _shared=await SharedPreferences.getInstance();
  _shared.getBool('is_signin')??false;
  emit(login_state());
}












  Future<void> login_firebase(TextEditingController usernamecontroller,
      TextEditingController passwordcontroler) async {
    emit(login_in_firebase(
        username: usernamecontroller, password: passwordcontroler));
    var user = FirebaseAuth.instance;
    try {
      UserCredential u1 = await user.createUserWithEmailAndPassword(
          email: usernamecontroller.text, password: passwordcontroler.text);
      print("Successfully logged in: ${u1.user?.email}");
      SharedPreferences _shared = await SharedPreferences.getInstance();
      await _shared.setBool('is_signin', true); // Save the sign-in status
      is_signin=true;
      emit(login_state());
      // Update local variable
    } on FirebaseException catch (e) {
      print(e.toString());
    }
  }






  void start_the_count(int min1, int sec1) {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (sec1 == 0 && min1 == 0) {
        timer.cancel();
        notification.show_notfication();
      } else if (sec1 == 0) {
        sec1 = 59;
        min1--;
      } else if (sec1 > 0) {
        sec1--;
      }
      else if(sec1 !=0 &&min1==0){
        sec1--;
      }

      emit(start_count(min: min1, sec: sec1));
    });

    emit(start_count(min: min1, sec: sec1));
  }
}

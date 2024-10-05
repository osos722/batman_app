import 'package:flutter/cupertino.dart';
import 'package:timer_count_down/timer_controller.dart';
class big_states{}
class initialstate extends big_states {}
class login_image_state extends big_states{}
class login_in_firebase extends big_states{
TextEditingController? username;
TextEditingController? password;
login_in_firebase({required this.username,required this.password});
}
class start_count extends big_states{
  int min;
  int sec;
  start_count({required this.min,required this.sec});
}
class login_state extends big_states{
}
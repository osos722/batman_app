import 'package:failed4/productivity_cupit/app_states.dart';
import 'package:failed4/productivity_cupit/productivity_cupit.dart';
import 'package:failed4/screens/home.dart';
import 'package:failed4/screens/login.dart';
import 'package:failed4/sirveces/notification.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
void main() async {
  runApp(myapp());
await Firebase.initializeApp(
options: DefaultFirebaseOptions.currentPlatform,
);
WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  await notification.init();
}
class myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => pro_cupit(initialstate()),
      child: BlocBuilder<pro_cupit, big_states>(
          builder: (context, state) {
            var cup = context.watch<pro_cupit>(); // Correct way to use Bloc inside builder
             return MaterialApp(
               home:cup.is_signin==false?login():home()
             );
           },)
      );

  }
}

//cup.is_signin2 ? home():login(),

//WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
//FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);





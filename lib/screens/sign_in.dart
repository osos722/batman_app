import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../productivity_cupit/productivity_cupit.dart';
class signin extends StatelessWidget {
  TextEditingController emailcontroller1=TextEditingController();
  TextEditingController passwordcontroller1=TextEditingController();
  @override
  Widget build(BuildContext context){
      return Scaffold(
        backgroundColor: Colors.blueGrey[800],
          body: Padding(
          padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Image.asset('images/Batman-Logo.png'),
                SizedBox(height: 60,),
                TextField(
                  controller: emailcontroller1,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(),
                  ),
                    ),
            SizedBox(height: 20,),
            TextField(
              controller: passwordcontroller1,
              decoration: InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
              ),
            ),
              ]
                  ),
          ),
            );
    }
    }

import 'package:failed4/productivity_cupit/productivity_cupit.dart';
import 'package:failed4/repeatedvalues/vars.dart';
import 'package:failed4/screens/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'home.dart';

class login extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
          return Scaffold(
            backgroundColor: Colors.blueGrey[800],
            body: ListView(
              children:[ Padding(
                padding: EdgeInsets.all(20),
                child: Form(
                  key: formKey, // Add the key to the form
                  child: Column(
                    children: [
                      Image.asset('images/Batman-Logo.png'),
                      SizedBox(height: 60),
                      TextFormField(
                        validator: (data1){
                          if(data1!.isEmpty){
                            return "you should Add Email";
                          }
                        },
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: 'Username',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        validator: (data){
                          if(data!.isEmpty){
                            return "you should Add Email";
                          }
                        },
                        controller: passwordController,
                        decoration: InputDecoration(
                          labelText: "Password",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Batman Begins",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Colors.amber[400],
                        ),
                      ),
                      SizedBox(height: 20),
                      TextButton(
                        onPressed: () {
                          if(formKey.currentState!.validate()){
                          context.read<pro_cupit>().login_firebase(emailController, passwordController);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => home()),
                          );}
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          "Sign In",
                          style: TextStyle(
                            color: textcolor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => signin()));
                        },
                        child: Text(
                          "Don't have an account?",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),]
            ),
          );
        }
        }


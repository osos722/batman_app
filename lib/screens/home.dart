import 'package:failed4/repeatedvalues/vars.dart';
import 'package:failed4/screens/mission.dart';
import 'package:failed4/screens/notes.dart';
import 'package:failed4/screens/panadora.dart';
import 'package:failed4/screens/reminder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
bool is_signedin=false;
class home extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: backgroundcolor1,
      body:
             Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'The Dark Knight',
                      style: TextStyle(
                        color: Color(0xffECDFCC),
                        fontWeight: FontWeight.w900,
                        fontSize: 40,
                      ),
                    ),
                      SizedBox(height: 50,),
                      Container(
                        width: 170,
                        height:60,
                        decoration: BoxDecoration(
                          color: homeiconbgcolor,
                          borderRadius: BorderRadius.circular(20)
                        ),
                        child: Center(
                          child: TextButton(
                            onPressed: (){
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context)=>missions()));
                            },
                           child: Text("Missions",
                            style: TextStyle(
                              color:textcolor,
                              fontWeight: FontWeight.bold,
                              fontSize: 25
                            ),
                          ),
                        ),
                      ),),
                    SizedBox(height: 20,),
                    Container(
                      width: 170,
                      height:60,
                      decoration: BoxDecoration(
                          color: homeiconbgcolor,
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: Center(
                        child: TextButton(
                          onPressed: (){
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context)=>notes()));
                          },
                          child: Text("Notes",
                          style: TextStyle(
                              color:textcolor,
                              fontWeight: FontWeight.bold,
                              fontSize: 25
                          ),
                        ),)
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      width: 170,
                      height:60,
                      decoration: BoxDecoration(
                          color: homeiconbgcolor,
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: Center(
                        child: TextButton(
                          onPressed: (){
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context)=>panadora()));
                          }
                          ,
                          child:Text("Panadora",
                          style: TextStyle(
                              color:textcolor,
                              fontWeight: FontWeight.bold,
                              fontSize: 25
                          ),
                        ),
                      ),
                    ),),
                    SizedBox(height: 20,),
                    Container(
                      width: 170,
                      height:60,
                      decoration: BoxDecoration(
                          color: homeiconbgcolor,
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: Center(
                        child: TextButton(
                          onPressed: (){
                           Navigator.push(context,MaterialPageRoute(builder:(context)=>reminder()));},
                          child: Text("Reminder",
                          style: TextStyle(
                              color:textcolor,
                              fontWeight: FontWeight.bold,
                              fontSize: 25
                          ),
                        ),)
                      ),
                    ),
                    ],
                ),
                 ),

         );
  }
}
//home screen ,notes,panadora,missions,reminders
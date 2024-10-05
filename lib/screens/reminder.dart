import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:failed4/sirveces/notification.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/reminder_model.dart';
import '../repeatedvalues/vars.dart';

class reminder extends StatelessWidget {
  TextEditingController reminder_controller = TextEditingController();
  TimeOfDay? reminder_time;

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> reminderStream =
    FirebaseFirestore.instance.collection('reminder').snapshots();

    return StreamBuilder(
      stream: reminderStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        }



        List<reminder_model> reminder_list = snapshot.data!.docs.map((doc) {
          var data = doc.data() as Map<String, dynamic>;

          // Check for null 'reminder_time' field and handle it safely
          if (data['reminder_time'] == null) {
            return reminder_model(
              reminder_text: data['reminder_text'],
              repetition: null, // Handle the null case gracefully
            );
          } else {
            // If 'reminder_time' exists, proceed normally
            return reminder_model.fromJason(data);
          }
        }).toList();
        for(int j=0;j<reminder_list.length;j++){
          DateTime? remind_me=reminder_list[j].repetition;
          String? remind_text =reminder_list[j].reminder_text;
          if(remind_me!=null&&remind_me.isAfter(DateTime.now())){
            notification.repeated_not(j,remind_text,remind_me);
          }
        }
        return Scaffold(
          backgroundColor: backgroundcolor1,
          body: Stack(
            children: [
              ListView.builder(
                itemCount: reminder_list.length,
                itemBuilder: (BuildContext context, int index) {
                  var reminderId = snapshot.data!.docs[index];
                  return Column(
                    children: [
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              width: 280,
                              decoration: BoxDecoration(
                                color: Color(0Xff697565),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "${reminder_list[index].reminder_text}",
                                  style: TextStyle(
                                    color: Color(0xffECDFCC),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          IconButton(
                            onPressed: () async {
                              await FirebaseFirestore.instance
                                  .collection('reminder')
                                  .doc(reminderId.id)
                                  .delete();
                            },
                            icon: Icon(Icons.delete),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: 140,),
                      ElevatedButton(
                          onPressed: () {
                            showModalBottomSheet(
                              isScrollControlled: true,
                              backgroundColor: Color(0xffECDFCC),
                              context: context,
                              builder: (context) => Padding(
                                padding: EdgeInsets.only(
                                  bottom: MediaQuery.of(context).viewInsets.bottom,
                                ),
                                child: Container(
                                  height:
                                  MediaQuery.of(context).size.height * 0.5,
                                  child: Column(
                                    children: [
                                      SizedBox(height: 20),
                                      Center(
                                        child: Text(
                                          "Remind Me",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 30),
                                      Container(
                                          width: 340,
                                          child: TextField(
                                            controller: reminder_controller,
                                            decoration: InputDecoration(
                                                labelText: "Remind Me ",
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(15),
                                                    borderSide: BorderSide(
                                                      color: Colors.pinkAccent,
                                                      width: 2,
                                                    ))),
                                            maxLines: 2,
                                            textInputAction:
                                            TextInputAction.done,
                                          )),
                                      SizedBox(height: 60),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Center(
                                            child: ElevatedButton(
                                              onPressed: () async {
                                                reminder_time =
                                                await showTimePicker(
                                                  context: context,
                                                  initialTime: TimeOfDay.now(),
                                                );
                                              },
                                              child: Text(
                                                "Reminder Time",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 30),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 20),
                                      ElevatedButton(
                                        onPressed: () {
                                          if (reminder_time != null) {
                                            // Convert TimeOfDay to DateTime for Firestore
                                            DateTime now = DateTime.now();
                                            DateTime reminderDateTime =
                                            DateTime(
                                              now.year,
                                              now.month,
                                              now.day,
                                              reminder_time!.hour,
                                              reminder_time!.minute,
                                            );

                                            FirebaseFirestore.instance
                                                .collection('reminder')
                                                .add({
                                              "reminder_text":
                                              reminder_controller.text,
                                              "reminder_time":
                                              reminderDateTime,
                                            });

                                            // Clear the controller after submit
                                            reminder_controller.clear();

                                            Navigator.pop(context);
                                          }
                                        },
                                        child: Text(
                                          "Add",
                                          style: TextStyle(
                                            backgroundColor: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            color: textcolor,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          child: Icon(Icons.add))
                    ],
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }
}

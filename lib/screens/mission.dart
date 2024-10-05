import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:failed4/models/missions_model.dart';
import 'package:failed4/sirveces/notification.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../repeatedvalues/vars.dart';

class missions extends StatelessWidget {
   int? hour_from_showtimepicker;
   int? munite_from_showtimepicker;
   TimeOfDay? deadlinetime;
   DateTime now=DateTime.now();
   DateTime? date_for_firestore;
   List<TimeOfDay?>dates=[];
  final Stream<QuerySnapshot> missionStream =
  FirebaseFirestore.instance.collection('missions').snapshots();
  int missionNumber = 0;
  DateTime date=DateTime(DateTime.now().hour,DateTime.now().minute);

  TextEditingController mission_controller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: missionStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        }
       // List<mission_model> listOfMissions = snapshot.data!.docs
         //   .map((doc) => mission_model.fromJason(doc))
           // .toList();
        List<mission_model> listOfMissions = snapshot.data!.docs
            .map((doc) {
          // Get the timestamp and convert to DateTime
          var data = doc.data() as Map<String, dynamic>;
          Timestamp deadlineTimestamp = data['deadline_model1'] as Timestamp;
          DateTime deadlineDateTime = deadlineTimestamp.toDate();
          return mission_model.fromJason(data)
            ..deadline_model = deadlineDateTime;  // Assign DateTime to the model
        })
            .toList();

        for(int i=0;i<listOfMissions.length;i++){
          DateTime? mission_deadline=listOfMissions[i].deadline_model;
          String? mission_string=listOfMissions[i].mission1_tostore;
          if(mission_deadline!=null&& mission_deadline.isAfter(now)){
            notification.mission_notification(mission_deadline,mission_string!,i );
          }
        }
        return Scaffold(
          backgroundColor: backgroundcolor1,
          body: Stack(
            children: [
              ListView.builder(
                itemCount: listOfMissions.length,
                itemBuilder: (BuildContext context, int index) {
                  var missionId = snapshot.data!.docs[index];
                  return Column(
                    children: [
                      SizedBox(height: 20),
                      Row(
                        children: [
                          SizedBox(width: 20),
                          Expanded(
                            child: Container(
                              width: 280,
                              decoration: BoxDecoration(
                                color: Color(0Xff697565), // Background color
                                borderRadius: BorderRadius.circular(10), // Adjust the radius as needed
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "${listOfMissions[index].mission1_tostore}",
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
                                  .collection('missions')
                                  .doc(missionId.id) // Use the correct document ID
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                                height: MediaQuery.of(context).size.height * 0.65,
                                child: Column(
                                  children: [
                                    SizedBox(height: 20),
                                    Center(
                                      child: Text(
                                        "The Mission",
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
                                        controller: mission_controller,
                                        decoration: InputDecoration(
                                          labelText: "Your Next Mission",
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(15.0),
                                            borderSide: BorderSide(
                                              width: 2,
                                              color: Colors.pinkAccent,
                                            ),
                                          ),
                                        ),
                                        maxLines: 3,
                                        textInputAction: TextInputAction.done,
                                      ),
                                    ),
                                    SizedBox(height: 60),
                                        ElevatedButton(
                                          onPressed: ()async{
                                           deadlinetime=  await showTimePicker(
                                                context: context,
                                                initialTime: TimeOfDay.now()
                                            );
                                           date_for_firestore=DateTime(
                                             DateTime.now().year,
                                             DateTime.now().month,
                                             DateTime.now().day,
                                             deadlinetime!.hour,
                                             deadlinetime!.minute
                                           );
                                          },
                                          child: Text("DeadLine",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 30
                                            ),),
                                        ),
                                    SizedBox(height: 20,),
                                    ElevatedButton(

                                        onPressed: (){

                                          if(deadlinetime!=null){
                                           // notification.mission_notification(date_for_firestore, mission_controller.text);
                                            FirebaseFirestore.instance.collection('missions').add({'mission':mission_controller.text,'deadline_model1':date_for_firestore});
                                            Navigator.pop(context);
                                           {
                                              }
                                            }

                                    },
                                      child: Text("Add",
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
                        child: Icon(Icons.add),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

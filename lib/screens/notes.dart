import 'package:failed4/models/notes_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../repeatedvalues/vars.dart';
class notes extends StatelessWidget {
  final Stream<QuerySnapshot> noteStream = FirebaseFirestore.instance.collection('saved notes').orderBy('created at').snapshots();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: noteStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }



        if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        }




        // Extract the list of notes
        List<notes_model> listOfNotes = snapshot.data!.docs
            .map((doc) => notes_model.fromJason(doc))
            .toList();

        return Scaffold(
          backgroundColor: backgroundcolor1,
          body: Stack(
            children: [
              ListView.builder(
                itemCount: listOfNotes.length,

                itemBuilder: (BuildContext context, int index) {
                  var documint_id=snapshot.data!.docs[index];
                  return Column(
                    children: [
                        Row(
                          children: [
                            SizedBox(width: 60,),
                               Container(
                                width: 200,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color:Color(0Xff697565),
                                  ),
                                  child: Row(
                                    children:[
                                      SizedBox(width: 10,),
                              
                              
                              
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.all(8),
                                          child: Text("${listOfNotes[index].note_from_model}",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: textcolor,
                                          ),
                                          ),
                                        ),
                                      ),
                                    ])
                                      ),
                            SizedBox(width: 20,),
                            IconButton(onPressed: ()async{
                              await FirebaseFirestore.instance.collection('saved notes').doc(documint_id.id).delete();
                            }, icon:Icon(Icons.delete))
                          ],
                        ),
                      



                      // Assuming NotesModel has a 'note' property
                      SizedBox(height: 15),
                    ],
                  );



                },
              ),










              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      SizedBox(width: 140),
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
                                height: MediaQuery.of(context).size.height * 0.40,
                                child: Column(
                                  children: [
                                    SizedBox(height: 20),
                                    Center(
                                      child: Text(
                                        "Add Your Note here",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 30),


                                    Container(
                                      width:340,
                                      child: TextField(
                                        onSubmitted: (data) {
                                          FirebaseFirestore.instance
                                              .collection('saved notes')
                                              .add({"note": data,
                                            "created at":DateTime.now()
                                          });
                                        },
                                        textInputAction: TextInputAction.done,
                                        maxLines: 2,
                                        decoration: InputDecoration(
                                          labelText: "Your Note",
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(15.0),
                                            borderSide: BorderSide(
                                              width: 20,
                                              color: Colors.pinkAccent,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
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
        );}

    );
  }
}

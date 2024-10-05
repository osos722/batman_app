import 'package:cloud_firestore/cloud_firestore.dart';

class reminder_model{
  String? reminder_text;
  DateTime? repetition;
  reminder_model({required this.reminder_text,required this.repetition});
  factory reminder_model.fromJason(reminder_jason){
    return reminder_model(
        reminder_text: reminder_jason["reminder_text"],
      repetition: (reminder_jason["reminder_time"] as Timestamp).toDate(),
    );
  }
}

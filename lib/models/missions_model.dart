import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class mission_model{
  String? mission1_tostore;
  DateTime? deadline_model;
  mission_model({required this.mission1_tostore,required this.deadline_model});
  factory mission_model.fromJason(mission_jason){
    return mission_model(
      mission1_tostore:mission_jason['mission'],
      deadline_model: mission_jason['deadline_model1'] != null
          ? (mission_jason['deadline_model1'] as Timestamp).toDate() // Convert Timestamp to DateTime
          : null,
    );
  }

}

class notes_model{
  String note_from_model;
  notes_model(this.note_from_model);
  factory notes_model.fromJason(jasondata){
    return notes_model(jasondata["note"]);
  }
}
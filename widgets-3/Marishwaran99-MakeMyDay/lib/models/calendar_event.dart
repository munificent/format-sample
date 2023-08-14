class CalendarEvent {
  String title;
  int id;
  String date;

  CalendarEvent(this.title, this.date);
  CalendarEvent.withId(this.id, this.title, this.date);

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }

    map['title'] = title;
    map['date'] = date;

    return map;
  }

  CalendarEvent.fromMapObject(Map<String, dynamic> map) {
    this.id = map['id'];
    this.title = map['title'];
    this.date = map['date'];
  }
}

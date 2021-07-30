// Κλάση με την λιστα που θα κραταει τα δεδομενα με τις μερες
class SleepList {
  final List<SleepDay> days;

  SleepList({this.days});

  factory SleepList.fromJson(List<dynamic> parsedJson) {
    List<SleepDay> days = new List<SleepDay>();
    days = parsedJson.map((e) => SleepDay.fromJson(e)).toList();
    return new SleepList(days: days);
  }
}

// Μοντελο για το τι στοιχεια θελω απο το json
class SleepDay {
  final String dateOfSleep;
  final int minutesAsleep;
  final String endTime;

  SleepDay({this.dateOfSleep, this.minutesAsleep, this.endTime});

  factory SleepDay.fromJson(Map<String, dynamic> json) {
    return new SleepDay(
      dateOfSleep: json['dateOfSleep'],
      minutesAsleep: json['minutesAsleep'],
      endTime: json['endTime'],
    );
  }
}

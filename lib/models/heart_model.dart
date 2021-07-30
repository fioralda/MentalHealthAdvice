//λιστα για να κραταω τα δεδομενα του αρχειου HeartRate
class HeartList {
  final List<HeartRate> days;

  HeartList({this.days});

  factory HeartList.fromJson(List<dynamic> parsedJson) {
    List<HeartRate> days = new List<HeartRate>();
    days = parsedJson.map((e) => HeartRate.fromJson(e)).toList();
    return new HeartList(days: days);
  }
}

// Μοντελο για το τι δεδομενα χρειαζομαι να παρω για καθε στοιχειο απο το αρχειο json
class HeartRate {
  final String dateTime;
  final int avarage;

  HeartRate({this.dateTime, this.avarage});

  factory HeartRate.fromJson(Map<String, dynamic> json) {
    return new HeartRate(
      dateTime: json['dateTime'],
      avarage: json['avarage'],
    );
  }
}

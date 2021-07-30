// Λιστα για να κραταω τα δεδομενα του αρχειου calories
class CaloriesList {
  final List<Calories> days;

  CaloriesList({this.days});

  factory CaloriesList.fromJson(List<dynamic> parsedJson) {
    List<Calories> days = new List<Calories>();
    days = parsedJson.map((e) => Calories.fromJson(e)).toList();
    return new CaloriesList(days: days);
  }
}

// Μοντελο για το τι δεδομενα χρειαζομαι να παρω για καθε στοιχειο απο τα calories
class Calories {
  final String dateTime;
  final int value;

  Calories({this.dateTime, this.value});

  factory Calories.fromJson(Map<String, dynamic> json) {
    return new Calories(
      dateTime: json['dateTime'],
      value: json['value'],
    );
  }
}

// Λιστα για να κραταω τα δεδομενα του αρχειου Steps

class StepsList {
  final List<StepsDay> days;

  StepsList({this.days});

  factory StepsList.fromJson(List<dynamic> parsedJson) {
    List<StepsDay> days = new List<StepsDay>();
    days = parsedJson.map((e) => StepsDay.fromJson(e)).toList();
    return new StepsList(days: days);
  }
}
// Μοντελο για το τι δεδομενα χρειαζομαι να παρω για καθε στοιχειο απο τα Steps

class StepsDay {
  final String dateTime;
  final int value;

  StepsDay({this.dateTime, this.value});

  factory StepsDay.fromJson(Map<String, dynamic> json) {
    return new StepsDay(
      dateTime: json['dateTime'],
      value: json['value'],
    );
  }
}

//Μοντελο για το τι αρχεια χρειαζομαι απο το json
class Me {
  final String displayName;
  final String dateOfBirth;
  final String avatar640;

  Me({this.displayName, this.dateOfBirth, this.avatar640});

  factory Me.fromJson(Map<String, dynamic> json) {
    return new Me(
      displayName: json['displayName'],
      dateOfBirth: json['dateOfBirth'],
      avatar640: json['avatar640'],
    );
  }
}

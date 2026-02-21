class Titanic {
  final double sex;
  final double age;
  final double fare;
  final double classe;
  

  final double? prediction;

  final DateTime? timeStamp;

  Titanic({
    required this.sex,
    required this.age,
    required this.fare,
    required this.classe,
    this.prediction,
    DateTime? timeStamp,
  }) : timeStamp = timeStamp ?? DateTime.now();

  Map<String, double> toJson() => {
    'sex': sex,
    'age': age,
    'fare': fare,
    'classe': classe,
  };

  factory Titanic.fromJson(Map<String, dynamic> json) => Titanic(
      sex: (json['sex'] as num ).toDouble(),
      age: (json['age'] as num ).toDouble(),
      fare:(json['fare'] as num ).toDouble(),
      classe: (json['classe'] as num ).toDouble(),
      prediction: (json['prediction'] as num?)?.toDouble(),
      timeStamp: json['timeStamp'] != null ? DateTime.parse(json['timeStamp']): null,
    );
}


class Titanic {
  final double sex;
  final double age;
  final double fare;
  final double classe;

  Titanic({
    required this.sex,
    required this.age,
    required this.fare,
    required this.classe,
  });

  Map<String, double> toJson() => {
        'sex': sex,
        'age': age,
        'fare': fare,
        'classe': classe,
      };
}

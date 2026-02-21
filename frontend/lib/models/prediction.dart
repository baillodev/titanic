class Prediction {
  final double prediction;
  final DateTime receivedAt;

  Prediction({
    required this.prediction,
    DateTime? receivedAt
    }) : receivedAt = receivedAt ?? DateTime.now();

  factory Prediction.fromJson(Map<String, dynamic> json) => Prediction(
    prediction: (json['prediction'] as num).toDouble(),
  ); 
}
class LyricLineModel
{
  final int timeStart;
  final int timeEnd;
  final String lineText;
  final int lineOrder;

  LyricLineModel({
    required this.timeStart,
    required this.timeEnd,
    required this.lineText,
    required this.lineOrder,
  });

  factory LyricLineModel.fromJson(Map<String, dynamic> json) {
    return LyricLineModel(
      timeStart: json['timeStart'] as int,
      timeEnd: json['timeEnd'] as int,
      lineText: json['lineText'] as String,
      lineOrder: json['lineOrder'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'timeStart': timeStart,
      'timeEnd': timeEnd,
      'lineText': lineText,
      'lineOrder': lineOrder,
    };
  }
}
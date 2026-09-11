class SearchHistoryModel {
  final String id;
  final String keyword;
  final String? resultType;
  final String? clickedResultId;

  SearchHistoryModel({
    required this.id,
    required this.keyword,
    this.resultType,
    this.clickedResultId,
  });

  factory SearchHistoryModel.fromJson(Map<String, dynamic> json) {
    return SearchHistoryModel(
      id: json["id"],
      keyword: json["keyword"],
      resultType: json["resultType"],
      clickedResultId: json["clickedResultId"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "keyword": keyword,
      "resultType": resultType,
      "clickedResultId": clickedResultId,
    };
  }
}

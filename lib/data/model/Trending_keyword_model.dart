class TrendingKeywordModel
{
  final String id;
  final String? keyword;
  final int? order;

  TrendingKeywordModel({
    required this.id,
    this.keyword,
    this.order,
  });

  factory TrendingKeywordModel.fromJson(Map<String, dynamic> json) {
    return TrendingKeywordModel(
      id: json['id'] as String,
      keyword: json['keyword'] as String?,
      order: json['order'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'keyword': keyword,
      'order': order,
    };
  }
}
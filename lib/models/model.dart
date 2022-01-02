import 'package:abdelrhman_khaled_portfolio/db/dbschima.dart';

class Notes {
  final String title;
  final int? id;
  final bool isImportent;
  final bool slctDelete;
  final String descp;
  final int number;
  final DateTime createdTime;

  const Notes(
      {required this.id,
      required this.title,
      required this.createdTime,
      required this.descp,
      required this.slctDelete,
      required this.isImportent,
      required this.number});

  Map<String, Object?> tojson() => {
        NotefIelds.id: id,
        NotefIelds.title: title,
        NotefIelds.createdTime: createdTime.toIso8601String(),
        NotefIelds.descp: descp,
        NotefIelds.slctDelete: slctDelete ? 1 : 0,
        NotefIelds.isImportent: isImportent ? 1 : 0,
        NotefIelds.number: number,
      };
  static Notes fromjson(Map<String, Object?> json) => Notes(
        id: json[NotefIelds.id] as int?,
        title: json[NotefIelds.title] as String,
        createdTime: DateTime.parse(json[NotefIelds.createdTime] as String),
        descp: json[NotefIelds.descp] as String,
        slctDelete: json[NotefIelds.slctDelete] as int == 1 ? true : false,
        isImportent: json[NotefIelds.isImportent] as int == 1 ? true : false,
        number: json[NotefIelds.number] as int,
      );
  Notes copy({
    String? title,
    int? id,
    bool? isImportent,
    bool? slctDelete,
    String? descp,
    int? number,
    DateTime? createdTime,
  }) =>
      Notes(
        id: id ?? this.id,
        title: title ?? this.title,
        slctDelete: slctDelete ?? this.slctDelete,
        isImportent: isImportent ?? this.isImportent,
        descp: descp ?? this.descp,
        number: number ?? this.number,
        createdTime: createdTime ?? this.createdTime,
      );
}

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/news.dart';
import '../../external/databases/sql_database/operations/sql_create_table.dart';
import '../../external/databases/sql_database/operations/sql_insert.dart';
import '../../external/databases/sql_database/operations/sql_select.dart';
import '../../external/databases/sql_database/types/sql_integer.dart';
import '../../external/databases/sql_database/types/sql_text.dart';
import '../../utils/constants.dart';

class NewsMapper {
  static Map<String, dynamic> toMap(News news) {
    return {
      'title': news.title,
      'subtitle': news.subtitle,
      'url': news.url,
      'timestamp': news.timestamp.toIso8601String(),
      'reference': news.reference,
    };
  }

  static fromMap(Map<String, dynamic> map) {
    return News(
      id: map['id'],
      title: map['title'],
      subtitle: map['subtitle'],
      url: map['url'],
      timestamp: map['timestamp'] is Timestamp
          ? (map['timestamp'] as Timestamp).toDate()
          : DateTime.parse(map['timestamp']),
      reference: map['reference'],
    );
  }

  static String toJSON(News news) => json.encode(toMap(news));

  static fromJSON(String source) => fromMap(json.decode(source));

  static SQLInsert toSQLInsert(News news) => SQLInsert(
        tableName: 'NEWS',
        data: toMap(news),
      );

  static SQLSelect toSQLSelect({int? offset, String? lastDocumentReference}) {
    if (lastDocumentReference != null) {
      return SQLSelect(
        tableName: 'NEWS',
        where: 'reference = \'$lastDocumentReference\'',
        limit: 1,
      );
    } else {
      return SQLSelect(
        tableName: 'NEWS',
        offset: offset,
        limit: Constants.paginationSize,
      );
    }
  }

  static SQLCreateTable get tableCreationStatement => const SQLCreateTable(
        tableName: 'NEWS',
        tableContents: [
          SQLInteger(value: 'id', isPrimaryKey: true, isAutoIncremented: true),
          SQLText(value: 'title'),
          SQLText(value: 'subtitle'),
          SQLText(value: 'url'),
          SQLText(value: 'timestamp'),
          SQLText(value: 'reference'),
        ],
      );
}

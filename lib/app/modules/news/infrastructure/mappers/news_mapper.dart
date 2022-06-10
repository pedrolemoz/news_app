import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/packages/sql_database/operations/sql_create_table.dart';
import '../../../../core/packages/sql_database/operations/sql_insert.dart';
import '../../../../core/packages/sql_database/types/sql_integer.dart';
import '../../../../core/packages/sql_database/types/sql_text.dart';
import '../../domain/entities/news.dart';

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

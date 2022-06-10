import 'package:meta/meta.dart';

import 'sql_query.dart';

class SQLDataType implements SQLQuery {
  final String value;
  final bool isAutoIncremented;
  final bool isPrimaryKey;
  final bool isForeignKey;
  final bool isNotNull;

  const SQLDataType({
    required this.value,
    this.isAutoIncremented = false,
    this.isPrimaryKey = false,
    this.isForeignKey = false,
    this.isNotNull = true,
  });

  @override
  @mustCallSuper
  String asQuery() {
    final query = StringBuffer();

    if (isPrimaryKey) {
      query.write(' PRIMARY KEY');
    } else if (isForeignKey) {
      query.write(' FOREIGN KEY');
    }

    if (isAutoIncremented) {
      query.write(' AUTOINCREMENT');
    }

    if (isNotNull) {
      query.write(' NOT NULL');
    }

    return query.toString();
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SQLDataType &&
        other.value == value &&
        other.isAutoIncremented == isAutoIncremented &&
        other.isPrimaryKey == isPrimaryKey &&
        other.isForeignKey == isForeignKey &&
        other.isNotNull == isNotNull;
  }

  @override
  int get hashCode {
    return value.hashCode ^
        isAutoIncremented.hashCode ^
        isPrimaryKey.hashCode ^
        isForeignKey.hashCode ^
        isNotNull.hashCode;
  }
}

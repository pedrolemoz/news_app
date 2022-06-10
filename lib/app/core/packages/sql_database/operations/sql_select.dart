import '../types/sql_query.dart';

class SQLSelect implements SQLQuery {
  final SQLSelectColumnMode columnMode;
  final String tableName;
  final List<String>? columns;
  final int? limit;
  final int? offset;
  final String? where;

  const SQLSelect({
    this.columnMode = SQLSelectColumnMode.allColumns,
    required this.tableName,
    this.columns,
    this.limit,
    this.offset,
    this.where,
  });

  @override
  String asQuery() {
    final query = StringBuffer();

    if (columnMode == SQLSelectColumnMode.allColumns) {
      query.write('SELECT * FROM $tableName');
    } else {
      query.write(
        'SELECT ${columns!.reduce((a, b) => a += ', $b')} FROM $tableName',
      );
    }

    if (where != null) {
      query.write(' WHERE $where');
    }

    if (limit != null) {
      query.write(' LIMIT $limit');
    }

    if (offset != null) {
      query.write(' OFFSET $offset');
    }

    query.write(';');

    return query.toString();
  }
}

enum SQLSelectColumnMode { allColumns, filteredColumns }

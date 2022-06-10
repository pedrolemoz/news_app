import '../types/sql_query.dart';

class SQLInsert implements SQLQuery {
  final String tableName;
  final Map<String, dynamic> data;

  const SQLInsert({required this.tableName, required this.data});

  @override
  String asQuery() {
    final columns = data.keys
        .toList()
        .map((e) => e.toString())
        .reduce((a, b) => a += ', $b');

    final values = data.values
        .toList()
        .map((e) => e.toString())
        .reduce((a, b) => a += ', $b');

    return 'INSERT INTO $tableName ($columns) VALUES ($values);';
  }
}

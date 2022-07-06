import 'package:news_app/app/external/databases/sql_database/operations/sql_insert.dart';
import 'package:news_app/app/external/databases/sql_database/types/sql_integer.dart';
import 'package:news_app/app/external/databases/sql_database/types/sql_text.dart';

import '../types/sql_data_type.dart';
import '../types/sql_query.dart';
import 'sql_select.dart';

class SQLCreateTable implements SQLQuery {
  final String tableName;
  final List<SQLDataType> tableContents;

  const SQLCreateTable({required this.tableName, required this.tableContents});

  @override
  String asQuery() =>
      'CREATE TABLE $tableName (${tableContents.map((e) => e.asQuery()).reduce((a, b) => a += ', $b')});';
}

void main() {
  final table = SQLCreateTable(
    tableName: 'MINHA_TABELA',
    tableContents: [
      SQLInteger(value: 'ID', isPrimaryKey: true, isAutoIncremented: true),
      SQLText(value: 'NOME'),
      SQLInteger(value: 'IDADE'),
    ],
  );

  final insert = SQLInsert(
    data: {'NOME': 'MOREIRA', 'IDADE': 21},
    tableName: 'MINHA_TABELA',
  );

  final select = SQLSelect(
    tableName: 'MINHA_TABELA',
    columnMode: SQLSelectColumnMode.allColumns,
    limit: 54,
    offset: 54,
    where: 'NOME LIKE "MOREIRA"',
  );

  print(table.asQuery());
  print(insert.asQuery());
  print(select.asQuery());
}

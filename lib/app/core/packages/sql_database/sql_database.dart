import 'operations/sql_insert.dart';
import 'operations/sql_select.dart';

abstract class SQLDatabase {
  Future<void> initializeDataBase();
  Future<int> insert(SQLInsert parameters);
  Future<List<Map<String, dynamic>>> select(SQLSelect parameters);
  Future<void> resetDataBase();
}

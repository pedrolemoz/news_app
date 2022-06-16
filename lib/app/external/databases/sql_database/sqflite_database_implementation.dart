import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'configuration/sql_configuration.dart';
import 'errors/sql_exceptions.dart';
import 'operations/sql_insert.dart';
import 'operations/sql_select.dart';

abstract class SQLDatabase {
  Future<void> initializeDataBase();
  Future<int> insert(SQLInsert parameters);
  Future<List<Map<String, dynamic>>> select(SQLSelect parameters);
  Future<void> resetDataBase();
}

class SQFliteDatabaseImplementation implements SQLDatabase {
  bool hasInitializedDataBase = false;
  final SQLConfiguration sqlConfiguration;
  late String dataBasesPath;
  late Database _dataBase;

  SQFliteDatabaseImplementation(this.sqlConfiguration);

  @override
  Future<void> initializeDataBase() async {
    dataBasesPath = await getDatabasesPath();

    _dataBase = await openDatabase(
      join(dataBasesPath, sqlConfiguration.dataBaseName()),
      version: sqlConfiguration.dataBaseVersion(),
      onOpen: (dataBase) => hasInitializedDataBase = true,
      onCreate: (dataBase, version) async {
        final statements = sqlConfiguration.createTableStatements();
        for (var statement in statements) {
          await dataBase.execute(statement.asQuery());
        }
      },
    );
  }

  @override
  Future<int> insert(SQLInsert parameters) async {
    if (!hasInitializedDataBase) await initializeDataBase();
    if (parameters.tableName == '' || parameters.tableName.isEmpty) {
      throw InvalidSQLTableNameException();
    }
    if (parameters.data.isEmpty) throw InvalidSQLValuesException();
    try {
      return await _dataBase.insert(parameters.tableName, parameters.data);
    } catch (exception) {
      throw SQLException(message: '$exception');
    }
  }

  @override
  Future<List<Map<String, dynamic>>> select(SQLSelect parameters) async {
    if (!hasInitializedDataBase) await initializeDataBase();
    if (parameters.tableName == '' || parameters.tableName.isEmpty) {
      throw InvalidSQLTableNameException();
    }
    if (parameters.columnMode == SQLSelectColumnMode.filteredColumns &&
            parameters.columns == null ||
        parameters.columns != null && parameters.columns!.isEmpty) {
      throw InvalidSQLColumnsException();
    }
    try {
      return await _dataBase.rawQuery(parameters.asQuery());
    } catch (exception) {
      throw SQLException(message: '$exception');
    }
  }

  @override
  Future<void> resetDataBase() async {
    try {
      if (!hasInitializedDataBase) await initializeDataBase();
      await deleteDatabase(
        join(
          dataBasesPath,
          sqlConfiguration.dataBaseName(),
        ),
      );
      await initializeDataBase();
    } catch (exception) {
      throw SQLException(message: '$exception');
    }
  }
}

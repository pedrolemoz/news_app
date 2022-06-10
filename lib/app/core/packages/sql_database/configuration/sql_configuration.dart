import '../../../../modules/news/infrastructure/mappers/news_mapper.dart';
import '../operations/sql_create_table.dart';

abstract class SQLConfiguration {
  String dataBaseName();
  int dataBaseVersion();
  List<SQLCreateTable> createTableStatements();
}

class NewsAppSQLConfiguration implements SQLConfiguration {
  @override
  String dataBaseName() => 'news_app.db';

  @override
  int dataBaseVersion() => 1;

  @override
  List<SQLCreateTable> createTableStatements() =>
      [NewsMapper.tableCreationStatement];
}

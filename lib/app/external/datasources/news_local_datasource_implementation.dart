import '../../domain/entities/news.dart';
import '../../domain/requests/get_news_request.dart';
import '../../infrastructure/datasources/news_local_datasource.dart';
import '../../infrastructure/exceptions/core_exceptions.dart';
import '../../infrastructure/exceptions/news_exceptions.dart';
import '../../infrastructure/mappers/news_mapper.dart';
import '../databases/sql_database/errors/sql_exceptions.dart';
import '../databases/sql_database/sqflite_database_implementation.dart';

class NewsLocalDataSourceImplementation implements NewsLocalDataSource {
  final SQLDatabase dataBase;

  const NewsLocalDataSourceImplementation(this.dataBase);

  @override
  Future<List<News>> getNewsFromStorage(GetNewsRequest request) async {
    try {
      int? offset;

      if (request.shouldUseLastDocumentReference) {
        final lastDocument = await dataBase.select(
          NewsMapper.toSQLSelect(
            lastDocumentReference: request.lastDocumentReference,
          ),
        );
        offset = lastDocument[0]['id'];
      }

      final data = await dataBase.select(
        NewsMapper.toSQLSelect(
          offset: offset,
        ),
      );
      final news = List<News>.from(
        data.map(
          (news) => NewsMapper.fromMap(news),
        ),
      );
      if (news.isEmpty && !request.shouldUseLastDocumentReference) {
        throw NoNewsToShowException();
      }
      return news;
    } on SQLException {
      throw StorageException();
    } catch (exception) {
      throw UnknownException(data: '$exception');
    }
  }

  @override
  Future<void> saveNewsInStorage(
    List<News> news,
    GetNewsRequest request,
  ) async {
    try {
      if (!request.shouldUseLastDocumentReference) {
        await dataBase.resetDataBase();
      }
      for (var data in news) {
        await dataBase.insert(NewsMapper.toSQLInsert(data));
      }
    } on SQLException {
      throw StorageException();
    } catch (exception) {
      throw UnknownException(data: '$exception');
    }
  }
}

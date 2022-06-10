import '../../../../core/external/constants/constants.dart';
import '../../../../core/infrastructure/exceptions/global_exceptions.dart';
import '../../../../core/packages/sql_database/operations/sql_select.dart';
import '../../../../core/packages/sql_database/sql_database.dart';
import '../../domain/entities/news.dart';
import '../../domain/parameters/get_news_parameters.dart';
import '../../infrastructure/datasources/news_local_datasource.dart';
import '../../infrastructure/errors/news_exceptions.dart';
import '../../infrastructure/mappers/news_mapper.dart';

class NewsLocalDataSourceImplementation implements NewsLocalDataSource {
  final SQLDatabase dataBase;

  NewsLocalDataSourceImplementation(this.dataBase);

  @override
  Future<List<News>> getNews(GetNewsParameters parameters) async {
    try {
      List<News> news = [];

      int? offset;

      if (parameters.shouldUseLastDocumentReference) {
        final lastDocumentSelectStatement = SQLSelect(
          tableName: 'NEWS',
          where: 'reference = \'${parameters.lastDocumentReference}\'',
          limit: 1,
        );

        final lastDocument = await dataBase.select(lastDocumentSelectStatement);

        offset = lastDocument[0]['id'];
      }

      final newsSelectStatement = SQLSelect(
        tableName: 'NEWS',
        offset: offset,
        limit: Constants.paginationSize,
      );

      final data = await dataBase.select(newsSelectStatement);

      for (var element in data) {
        news.add(NewsMapper.fromMap(element));
      }

      if (news.isEmpty && !parameters.shouldUseLastDocumentReference) {
        throw NoNewsToShowException();
      }

      return news;
    } catch (exception) {
      throw CacheException();
    }
  }

  @override
  Future<void> storeNews(List<News> news, GetNewsParameters parameters) async {
    try {
      if (!parameters.shouldUseLastDocumentReference) {
        await dataBase.resetDataBase();
      }

      for (var data in news) {
        await dataBase.insert(NewsMapper.toSQLInsert(data));
      }
    } catch (exception) {
      throw CacheException();
    }
  }
}

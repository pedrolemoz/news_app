import '../../domain/entities/news.dart';
import '../../domain/failures/failure.dart';
import '../../domain/repositories/news_repository.dart';
import '../../domain/requests/get_news_request.dart';
import '../../utils/either.dart';
import '../datasources/news_datasource.dart';
import '../datasources/news_local_datasource.dart';
import '../exceptions/core_exceptions.dart';
import '../exceptions/news_exceptions.dart';

class NewsRepositoryImplementation implements NewsRepository {
  final NewsDataSource dataSource;
  final NewsLocalDataSource localDataSource;

  const NewsRepositoryImplementation(this.dataSource, this.localDataSource);

  @override
  Future<Either<Failure, List<News>>> getNewsFromServer(
    GetNewsRequest request,
  ) async {
    try {
      final news = await dataSource.getNewsFromServer(request);
      return right(news);
    } on NoInternetConnectionException catch (exception) {
      return left(exception.asFailure);
    } on NoNewsToShowException catch (exception) {
      return left(exception.asFailure);
    } on ServerException catch (exception) {
      return left(exception.asFailure);
    } on UnknownException catch (exception) {
      return left(exception.asFailure);
    }
  }

  @override
  Future<Either<Failure, List<News>>> getNewsFromStorage(
    GetNewsRequest request,
  ) async {
    try {
      final news = await localDataSource.getNewsFromStorage(request);
      return right(news);
    } on StorageException catch (exception) {
      return left(exception.asFailure);
    } on NoNewsToShowException catch (exception) {
      return left(exception.asFailure);
    } on UnknownException catch (exception) {
      return left(exception.asFailure);
    }
  }

  @override
  Future<Either<Failure, void>> saveNewsInStorage(
    List<News> news,
    GetNewsRequest request,
  ) async {
    try {
      return right(await localDataSource.saveNewsInStorage(news, request));
    } on StorageException catch (exception) {
      return left(exception.asFailure);
    } on UnknownException catch (exception) {
      return left(exception.asFailure);
    }
  }
}

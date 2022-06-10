import 'package:dartz/dartz.dart';

import '../../../../core/domain/errors/failure.dart';
import '../../../../core/domain/errors/global_failures.dart';
import '../../../../core/infrastructure/exceptions/global_exceptions.dart';
import '../../domain/entities/news.dart';
import '../../domain/errors/news_failures.dart';
import '../../domain/parameters/get_news_parameters.dart';
import '../../domain/repositories/news_repository.dart';
import '../datasources/news_datasource.dart';
import '../datasources/news_local_datasource.dart';
import '../errors/news_exceptions.dart';

class NewsRepositoryImplementation implements NewsRepository {
  final NewsDataSource dataSource;
  final NewsLocalDataSource localDataSource;

  const NewsRepositoryImplementation(this.dataSource, this.localDataSource);

  @override
  Future<Either<Failure, List<News>>> getNews(
    GetNewsParameters parameters,
  ) async {
    try {
      final news = await dataSource.getNews(parameters);

      await localDataSource.storeNews(news, parameters);

      return Right(news);
    } on NoNewsToShowException {
      return Left(NoNewsToShowFailure());
    } on NoInternetConnectionException {
      try {
        final news = await localDataSource.getNews(parameters);
        return Right(news);
      } catch (exception) {
        return Left(NoInternetConnectionFailure());
      }
    } on ServerException catch (exception) {
      return Left(ServerFailure(message: exception.data));
    } catch (exception) {
      return Left(Failure(message: '$exception'));
    }
  }
}

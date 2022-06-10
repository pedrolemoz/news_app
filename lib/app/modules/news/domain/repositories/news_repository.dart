import 'package:dartz/dartz.dart';

import '../../../../core/domain/errors/failure.dart';
import '../entities/news.dart';
import '../parameters/get_news_parameters.dart';

abstract class NewsRepository {
  Future<Either<Failure, List<News>>> getNews(GetNewsParameters parameters);
}

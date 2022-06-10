import 'package:dartz/dartz.dart';

import '../../../../core/domain/errors/failure.dart';
import '../../../../core/domain/usecases/async_usecase.dart';
import '../entities/news.dart';
import '../errors/news_failures.dart';
import '../parameters/get_news_parameters.dart';
import '../repositories/news_repository.dart';

abstract class GetNews implements AsyncUsecase<List<News>, GetNewsParameters> {}

class GetNewsImplementation implements GetNews {
  final NewsRepository repository;

  const GetNewsImplementation(this.repository);

  @override
  Future<Either<Failure, List<News>>> call(GetNewsParameters parameters) async {
    if (parameters.shouldUseLastDocumentReference) {
      if (parameters.lastDocumentReference == null ||
          parameters.lastDocumentReference!.isEmpty ||
          !parameters.lastDocumentReference!.contains('news')) {
        return Left(InvalidLastDocumentFailure());
      }
    }

    return await repository.getNews(parameters);
  }
}

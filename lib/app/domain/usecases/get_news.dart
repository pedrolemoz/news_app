import '../../utils/either.dart';
import '../entities/news.dart';
import '../failures/core_failures.dart';
import '../failures/failure.dart';
import '../failures/news_failures.dart';
import '../repositories/news_repository.dart';
import '../requests/get_news_request.dart';

abstract class GetNews {
  Future<Either<Failure, List<News>>> call(GetNewsRequest request);
}

class GetNewsImplementation implements GetNews {
  final NewsRepository repository;

  const GetNewsImplementation(this.repository);

  @override
  Future<Either<Failure, List<News>>> call(GetNewsRequest request) async {
    if (!request.isValid) return left(InvalidLastDocumentFailure());
    final result = await repository.getNewsFromServer(request);
    return result.evaluate(
      (failure) async {
        if (failure is NoInternetConnectionFailure) {
          return await repository.getNewsFromStorage(request);
        }
        return left(failure);
      },
      (success) async {
        await repository.saveNewsInStorage(success, request);
        return right(success);
      },
    );
  }
}

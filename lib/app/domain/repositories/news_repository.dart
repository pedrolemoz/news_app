import '../../utils/either.dart';
import '../entities/news.dart';
import '../failures/failure.dart';
import '../requests/get_news_request.dart';

abstract class NewsRepository {
  Future<Either<Failure, List<News>>> getNewsFromServer(
    GetNewsRequest request,
  );

  Future<Either<Failure, List<News>>> getNewsFromStorage(
    GetNewsRequest request,
  );

  Future<void> saveNewsInStorage(List<News> news, GetNewsRequest request);
}

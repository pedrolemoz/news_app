import '../../domain/entities/news.dart';
import '../../domain/requests/get_news_request.dart';

abstract class NewsLocalDataSource {
  Future<List<News>> getNewsFromStorage(GetNewsRequest request);

  Future<void> saveNewsInStorage(List<News> news, GetNewsRequest request);
}

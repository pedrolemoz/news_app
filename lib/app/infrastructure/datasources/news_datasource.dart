import '../../domain/entities/news.dart';
import '../../domain/requests/get_news_request.dart';

abstract class NewsDataSource {
  Future<List<News>> getNewsFromServer(GetNewsRequest request);
}

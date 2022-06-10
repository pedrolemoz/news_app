import '../../domain/entities/news.dart';
import '../../domain/parameters/get_news_parameters.dart';

abstract class NewsLocalDataSource {
  Future<List<News>> getNews(GetNewsParameters parameters);

  Future<void> storeNews(List<News> news, GetNewsParameters parameters);
}

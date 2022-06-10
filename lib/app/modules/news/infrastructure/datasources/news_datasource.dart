import '../../domain/entities/news.dart';
import '../../domain/parameters/get_news_parameters.dart';

abstract class NewsDataSource {
  Future<List<News>> getNews(GetNewsParameters parameters);
}

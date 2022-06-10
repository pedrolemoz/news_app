import '../../../../../modules/news/domain/parameters/get_news_parameters.dart';

abstract class FirebaseFirestoreClient {
  Future<List<Map<String, dynamic>>> getNews(GetNewsParameters parameters);
}

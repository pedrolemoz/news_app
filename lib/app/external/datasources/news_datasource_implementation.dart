import '../../domain/entities/news.dart';
import '../../domain/requests/get_news_request.dart';
import '../../infrastructure/datasources/news_datasource.dart';
import '../../infrastructure/exceptions/core_exceptions.dart';
import '../../infrastructure/exceptions/news_exceptions.dart';
import '../../infrastructure/mappers/news_mapper.dart';
import '../clients/firebase_firestore_client/firebase_firestore_client.dart';
import '../services/connectivity_service/connectivity_service.dart';

class NewsDataSourceImplementation implements NewsDataSource {
  final ConnectivityService connectivityService;
  final FirebaseFirestoreClient firestoreClient;

  const NewsDataSourceImplementation(
    this.connectivityService,
    this.firestoreClient,
  );

  @override
  Future<List<News>> getNewsFromServer(GetNewsRequest request) async {
    final hasActiveNetwork = await connectivityService.hasActiveNetwork();
    if (!hasActiveNetwork) throw NoInternetConnectionException();
    final data = await firestoreClient.getNews(request);
    if (data.isEmpty) throw NoNewsToShowException();
    return data.map<News>((news) => NewsMapper.fromMap(news)).toList();
  }
}

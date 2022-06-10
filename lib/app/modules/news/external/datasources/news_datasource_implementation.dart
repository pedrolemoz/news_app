import '../../../../core/infrastructure/exceptions/global_exceptions.dart';
import '../../../../core/packages/firebase/firebase_firestore_client/abstraction/firebase_firestore_client.dart';
import '../../../../core/packages/network_connectivity_checker/abstractions/network_connectivity_checker.dart';
import '../../../../core/utils/extensions/remove_duplicated_elements.dart';
import '../../domain/entities/news.dart';
import '../../domain/parameters/get_news_parameters.dart';
import '../../infrastructure/datasources/news_datasource.dart';
import '../../infrastructure/errors/news_exceptions.dart';
import '../../infrastructure/mappers/news_mapper.dart';

class NewsDataSourceImplementation implements NewsDataSource {
  final NetworkConnectivityChecker networkConnectivityChecker;
  final FirebaseFirestoreClient firestoreClient;

  const NewsDataSourceImplementation(
    this.firestoreClient,
    this.networkConnectivityChecker,
  );

  @override
  Future<List<News>> getNews(GetNewsParameters parameters) async {
    if (!await networkConnectivityChecker.hasActiveNetwork()) {
      throw NoInternetConnectionException();
    }

    final data = await firestoreClient.getNews(parameters);

    if (data.isEmpty) {
      throw NoNewsToShowException();
    }

    final news =
        data.map<News>((element) => NewsMapper.fromMap(element)).toList();

    return news.removeDuplicatedElements<News>();
  }
}

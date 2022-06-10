import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../../modules/news/domain/parameters/get_news_parameters.dart';
import '../../../../external/constants/constants.dart';
import '../../../../infrastructure/exceptions/global_exceptions.dart';
import '../abstraction/firebase_firestore_client.dart';

class FirebaseFirestoreClientImplementation implements FirebaseFirestoreClient {
  @override
  Future<List<Map<String, dynamic>>> getNews(
    GetNewsParameters parameters,
  ) async {
    try {
      final firestoreService = FirebaseFirestore.instance;

      Query<Map<String, dynamic>> query = firestoreService
          .collection('news')
          .orderBy('timestamp', descending: true);

      if (parameters.lastDocumentReference != null) {
        final documentSnapshot =
            await firestoreService.doc(parameters.lastDocumentReference!).get();

        query = query.startAfterDocument(documentSnapshot);
      }

      query = query.limit(Constants.paginationSize);

      final snapshot = await query.get();

      final news = snapshot.docs
          .map<Map<String, dynamic>>((news) => news.data())
          .toList();

      return news;
    } catch (exception) {
      throw ServerException(data: '$exception');
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../domain/requests/get_news_request.dart';
import '../../../infrastructure/exceptions/core_exceptions.dart';
import '../../../utils/constants.dart';

abstract class FirebaseFirestoreClient {
  Future<List<Map<String, dynamic>>> getNews(GetNewsRequest request);
}

class FirebaseFirestoreClientImplementation implements FirebaseFirestoreClient {
  @override
  Future<List<Map<String, dynamic>>> getNews(
    GetNewsRequest request,
  ) async {
    try {
      final firestoreService = FirebaseFirestore.instance;
      Query<Map<String, dynamic>> query = firestoreService
          .collection('news')
          .orderBy('timestamp', descending: true);

      if (request.lastDocumentReference != null) {
        final documentSnapshot =
            await firestoreService.doc(request.lastDocumentReference!).get();
        query = query.startAfterDocument(documentSnapshot);
      }

      query = query.limit(Constants.paginationSize);
      final snapshot = await query.get();
      final news = snapshot.docs
          .map<Map<String, dynamic>>((news) => news.data())
          .toList();

      return news;
    } on FirebaseException catch (exception) {
      throw ServerException(
        data: 'Firebase Error: ${exception.message} - ${exception.code}',
      );
    } catch (exception) {
      throw UnknownException(data: '$exception');
    }
  }
}

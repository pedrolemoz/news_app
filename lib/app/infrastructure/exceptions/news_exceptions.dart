import '../../domain/failures/failure.dart';
import '../../domain/failures/news_failures.dart';
import 'app_exception.dart';

class NoNewsToShowException implements AppException {
  const NoNewsToShowException();

  @override
  Failure get asFailure => NoNewsToShowFailure();
}

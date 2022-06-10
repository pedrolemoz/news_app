class SQLException implements Exception {
  final String? message;

  SQLException({this.message});
}

class InvalidSQLTableNameException extends SQLException {}

class InvalidSQLValuesException extends SQLException {}

class InvalidSQLColumnsException extends SQLException {}

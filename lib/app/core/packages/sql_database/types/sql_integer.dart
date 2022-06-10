import 'sql_data_type.dart';

class SQLInteger extends SQLDataType {
  const SQLInteger({
    required super.value,
    super.isAutoIncremented = false,
    super.isPrimaryKey = false,
    super.isForeignKey = false,
    super.isNotNull = true,
  });

  @override
  String asQuery() {
    final query = StringBuffer('$value INTEGER');

    final superQuery = super.asQuery();

    if (superQuery != '' && superQuery.isNotEmpty) {
      query.write(superQuery);
    }

    return query.toString();
  }
}

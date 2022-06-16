import 'sql_data_type.dart';

class SQLText extends SQLDataType {
  const SQLText({
    required super.value,
    super.isPrimaryKey = false,
    super.isForeignKey = false,
    super.isNotNull = true,
  });

  @override
  String asQuery() {
    final query = StringBuffer('$value TEXT');

    final superQuery = super.asQuery();

    if (superQuery != '' && superQuery.isNotEmpty) {
      query.write(superQuery);
    }

    return query.toString();
  }
}

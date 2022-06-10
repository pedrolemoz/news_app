import 'sql_data_type.dart';

class SQLDateTime extends SQLDataType {
  const SQLDateTime({
    required super.value,
    super.isPrimaryKey = false,
    super.isForeignKey = false,
    super.isNotNull = true,
  });

  @override
  String asQuery() {
    final query = StringBuffer('$value DATETIME');

    final superQuery = super.asQuery();

    if (superQuery != '' && superQuery.isNotEmpty) {
      query.write(superQuery);
    }

    return query.toString();
  }
}

class News {
  final int? id;
  final String title;
  final String subtitle;
  final String url;
  final DateTime timestamp;
  final String reference;

  const News({
    this.id,
    required this.title,
    required this.subtitle,
    required this.url,
    required this.timestamp,
    required this.reference,
  });

  @override
  bool operator ==(Object object) {
    if (identical(this, object)) return true;

    return object is News &&
        object.id == id &&
        object.title == title &&
        object.subtitle == subtitle &&
        object.url == url &&
        object.timestamp == timestamp &&
        object.reference == reference;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        subtitle.hashCode ^
        url.hashCode ^
        timestamp.hashCode ^
        reference.hashCode;
  }
}

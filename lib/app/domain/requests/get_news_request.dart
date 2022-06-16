class GetNewsRequest {
  final bool shouldUseLastDocumentReference;
  final String? lastDocumentReference;

  const GetNewsRequest({
    this.lastDocumentReference,
    this.shouldUseLastDocumentReference = false,
  });

  bool get isValid {
    if (shouldUseLastDocumentReference) {
      if (lastDocumentReference == null ||
          lastDocumentReference!.isEmpty ||
          !lastDocumentReference!.contains('news')) {
        return false;
      }
    }

    return true;
  }
}

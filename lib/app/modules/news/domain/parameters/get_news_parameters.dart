class GetNewsParameters {
  final bool shouldUseLastDocumentReference;
  final String? lastDocumentReference;

  const GetNewsParameters({
    this.lastDocumentReference,
    this.shouldUseLastDocumentReference = false,
  });
}

class EnumValues<T> {
  Map<String, T> map;

  EnumValues(this.map);

  Map<T, String> get reverse => map.map((k, v) => MapEntry(v, k));
}

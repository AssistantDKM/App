import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';

class MuseumState {
  final List<String> donations;

  const MuseumState({
    required this.donations,
  });

  factory MuseumState.initial() {
    return MuseumState(donations: List.empty(growable: true));
  }

  MuseumState copyWith({
    List<String>? donations,
  }) {
    return MuseumState(donations: donations ?? this.donations);
  }

  factory MuseumState.fromJson(Map<String, dynamic> json) {
    // ignore: unnecessary_null_comparison
    if (json == null) return MuseumState.initial();
    try {
      return MuseumState(
        donations: readListSafe<String>(
          json,
          'donations',
          (p) => p.toString(),
        ).toList(),
      );
    } catch (exception) {
      return MuseumState.initial();
    }
  }

  Map<String, dynamic> toJson() => {
        'donations': donations,
      };
}

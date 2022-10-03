import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';

class FavouriteState {
  final List<String> favouriteItems;

  const FavouriteState({
    required this.favouriteItems,
  });

  factory FavouriteState.initial() {
    return FavouriteState(favouriteItems: List.empty(growable: true));
  }

  FavouriteState copyWith({
    List<String>? favouriteItems,
  }) {
    return FavouriteState(
        favouriteItems: favouriteItems ?? this.favouriteItems);
  }

  factory FavouriteState.fromJson(Map<String, dynamic> json) {
    // ignore: unnecessary_null_comparison
    if (json == null) return FavouriteState.initial();
    try {
      return FavouriteState(
        favouriteItems: readListSafe<String>(
          json,
          'favouriteItems',
          (p) => p.toString(),
        ).toList(),
      );
    } catch (exception) {
      return FavouriteState.initial();
    }
  }

  Map<String, dynamic> toJson() => {
        'favouriteItems': favouriteItems,
      };
}

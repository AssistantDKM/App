import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../contracts/redux/app_state.dart';
import '../../redux/favourite/favourite_viewmodel.dart';

class InventoryItemFavouritesIcon extends StatelessWidget {
  final String appId;

  const InventoryItemFavouritesIcon({
    Key? key,
    required this.appId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, FavouriteViewModel>(
      converter: (store) => FavouriteViewModel.fromStore(store),
      builder: (redxContext, viewModel) {
        bool currentItemIsFavourite = viewModel.favourites //
            .where((fav) => fav.toLowerCase() == appId.toLowerCase())
            .isNotEmpty;
        return IconButton(
          icon: Icon(
            currentItemIsFavourite ? Icons.star : Icons.star_border,
            size: 32,
          ),
          onPressed: () {
            if (currentItemIsFavourite) {
              viewModel.removeFavourite(appId);
            } else {
              viewModel.addFavourite(appId);
            }
          },
        );
      },
    );
  }
}

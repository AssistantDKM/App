import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../contracts/redux/app_state.dart';
import '../../redux/museum/museum_viewmodel.dart';

class InventoryItemMuseumIcon extends StatelessWidget {
  final String appId;

  const InventoryItemMuseumIcon({super.key, required this.appId});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, MuseumViewModel>(
      converter: (store) => MuseumViewModel.fromStore(store),
      builder: (redxContext, viewModel) {
        bool currentItemIsInTheMuseum = viewModel.donation //
            .where((donation) => donation.toLowerCase() == appId.toLowerCase())
            .isNotEmpty;

        Widget hasDonated = Stack(
          alignment: AlignmentDirectional.center,
          children: [
            const Icon(Icons.museum_rounded),
            const Icon(Icons.stop),
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Icon(
                Icons.check,
                size: 14,
                color: getTheme().getScaffoldBackgroundColour(context),
              ),
            ),
          ],
        );

        Widget notDonated = Stack(
          alignment: AlignmentDirectional.center,
          children: [
            const Icon(Icons.museum_rounded),
            const Icon(Icons.stop),
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Icon(
                Icons.close,
                size: 14,
                color: getTheme().getScaffoldBackgroundColour(context),
              ),
            ),
          ],
        );

        return IconButton(
          icon: currentItemIsInTheMuseum ? hasDonated : notDonated,
          onPressed: () {
            if (currentItemIsInTheMuseum) {
              viewModel.removeFromMuseum(appId);
            } else {
              viewModel.addToMuseum(appId);
            }
          },
        );
      },
    );
  }
}

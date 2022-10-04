import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../constants/app_image.dart';
import '../../contracts/redux/app_state.dart';
import '../../redux/museum/museum_viewmodel.dart';
import '../adaptive/checkbox.dart';

class InventoryItemMuseumTile extends StatelessWidget {
  final String appId;

  const InventoryItemMuseumTile({super.key, required this.appId});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, MuseumViewModel>(
      converter: (store) => MuseumViewModel.fromStore(store),
      builder: (redxContext, viewModel) {
        bool currentItemIsInTheMuseum = viewModel.donation //
            .where((donation) => donation.toLowerCase() == appId.toLowerCase())
            .isNotEmpty;

        return ListTile(
          leading: localImage(AppImage.museum),
          title: const Text('Donated to Museum'), // TODO Localize
          trailing: CustomCheckbox(value: currentItemIsInTheMuseum),
          onTap: () {
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

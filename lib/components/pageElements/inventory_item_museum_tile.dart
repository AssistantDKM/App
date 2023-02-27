import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../constants/app_image.dart';
import '../../contracts/redux/app_state.dart';
import '../../redux/museum/museum_viewmodel.dart';

class InventoryItemMuseumTile extends StatelessWidget {
  final String appId;

  const InventoryItemMuseumTile({
    Key? key,
    required this.appId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, MuseumViewModel>(
      converter: (store) => MuseumViewModel.fromStore(store),
      builder: (redxContext, viewModel) {
        bool currentItemIsInTheMuseum = viewModel.donation //
            .where((donation) => donation.toLowerCase() == appId.toLowerCase())
            .isNotEmpty;

        onTapped() {
          if (currentItemIsInTheMuseum) {
            viewModel.removeFromMuseum(appId);
          } else {
            viewModel.addToMuseum(appId);
          }
        }

        return ListTile(
          leading: const LocalImage(imagePath: AppImage.museum),
          title: Text(getTranslations().fromKey(LocaleKey.museumDonation)),
          trailing: getBaseWidget().adaptiveCheckbox(
            value: currentItemIsInTheMuseum,
            onChanged: (_) => onTapped(),
          ),
          onTap: onTapped,
        );
      },
    );
  }
}

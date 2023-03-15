import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../constants/app_image.dart';
import '../../contracts/redux/app_state.dart';
import '../../redux/museum/museum_viewmodel.dart';

class InventoryItemMuseumTile extends StatelessWidget {
  final String appId;
  final List<String> donations;

  const InventoryItemMuseumTile({
    Key? key,
    required this.appId,
    required this.donations,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InventoryItemMuseumWrapper(
      appId: appId,
      donations: donations,
      builder: (bool currentItemIsInTheMuseum, void Function() onTapped) {
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

class InventoryItemMuseumCheckBox extends StatelessWidget {
  final String appId;
  final List<String> donations;

  const InventoryItemMuseumCheckBox({
    Key? key,
    required this.appId,
    required this.donations,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InventoryItemMuseumWrapper(
      appId: appId,
      donations: donations,
      builder: (bool currentItemIsInTheMuseum, void Function() onTapped) {
        return getBaseWidget().adaptiveCheckbox(
          value: currentItemIsInTheMuseum,
          onChanged: (_) => onTapped(),
        );
      },
    );
  }
}

class InventoryItemMuseumWrapper extends StatelessWidget {
  final String appId;
  final List<String> donations;
  final Widget Function(
    bool currentItemIsInTheMuseum,
    void Function() onTapped,
  ) builder;

  const InventoryItemMuseumWrapper({
    Key? key,
    required this.appId,
    required this.donations,
    required this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, MuseumViewModel>(
      converter: (store) => MuseumViewModel.fromStore(store),
      builder: (redxContext, viewModel) {
        bool currentItemIsInTheMuseum = donations //
            .where((donation) => donation.toLowerCase() == appId.toLowerCase())
            .isNotEmpty;

        onTapped() {
          if (currentItemIsInTheMuseum) {
            viewModel.removeFromMuseum(appId);
          } else {
            viewModel.addToMuseum(appId);
          }
        }

        return builder(currentItemIsInTheMuseum, onTapped);
      },
    );
  }
}

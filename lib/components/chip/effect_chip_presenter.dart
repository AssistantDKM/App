import 'package:assistant_dinkum_app/constants/app_image.dart';
import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../../constants/app_colour.dart';
import '../../contracts/json/enum/food_effect.dart';

Widget effectChipPresenter(BuildContext context, FoodEffect effect) {
  String localImageStr = AppImage.customLoading;
  String valueStr = effect.value.toString();
  switch (effect.type) {
    case 'Health':
      localImageStr = AppImage.health;
      break;
    case 'HealthPlus':
      localImageStr = AppImage.healthPlus;
      break;
    case 'Energy':
      localImageStr = AppImage.energy;
      break;
    case 'EnergyPlus':
      localImageStr = AppImage.energyPlus;
      break;
    case 'Stamina':
      localImageStr = AppImage.stamina;
      break;
    case 'Defence Buff':
      localImageStr = AppImage.defence;
      break;
    case 'Attack Buff':
      localImageStr = AppImage.weapon;
      break;
    case 'Speed Buff':
      localImageStr = AppImage.speed;
      break;
    case 'Mining Buff':
      localImageStr = AppImage.mining;
      break;
    case 'Fishing Buff':
      localImageStr = AppImage.fishing;
      valueStr = '${(effect.value / 60).toStringAsFixed(0)}min';
      break;
    case 'Weapon Buff':
      localImageStr = AppImage.weapon;
      break;
  }

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 2),
    child: Chip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          localImage(localImageStr, width: 24, height: 24),
          genericItemDescription(valueStr)
        ],
      ),
      backgroundColor: AppColour.defaultTagColour,
    ),
  );
}

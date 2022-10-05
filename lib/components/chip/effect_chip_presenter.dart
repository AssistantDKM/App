import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../../constants/app_colour.dart';
import '../../constants/app_image.dart';
import '../../contracts/json/enum/consumable_buff_type.dart';
import '../../contracts/json/inventory_item_consumable_buff.dart';

Widget effectChipPresenter(
    BuildContext context, InventoryItemConsumableBuff effect) {
  String localImageStr = AppImage.customLoading;
  bool isMinuteBased = false;

  switch (effect.type) {
    case ConsumableBuffType.healthGain:
      localImageStr = AppImage.health;
      break;
    case ConsumableBuffType.healthRegen:
      localImageStr = AppImage.health;
      isMinuteBased = true;
      break;
    case ConsumableBuffType.tempHealthGain:
      localImageStr = AppImage.healthPlus;
      break;
    case ConsumableBuffType.staminaGain:
      localImageStr = AppImage.energy;
      break;
    case ConsumableBuffType.staminaRegen:
      localImageStr = AppImage.energy;
      isMinuteBased = true;
      break;
    case ConsumableBuffType.tempStaminaGain:
      localImageStr = AppImage.energyPlus;
      break;
    case ConsumableBuffType.speedBuff:
      localImageStr = AppImage.speed;
      isMinuteBased = true;
      break;
    case ConsumableBuffType.defenceBuff:
      localImageStr = AppImage.defence;
      isMinuteBased = true;
      break;
    case ConsumableBuffType.xPBuff:
    case ConsumableBuffType.huntingBuff:
      localImageStr = AppImage.hunting;
      isMinuteBased = true;
      break;
    case ConsumableBuffType.miningBuff:
      localImageStr = AppImage.mining;
      isMinuteBased = true;
      break;
    case ConsumableBuffType.fishingBuff:
      localImageStr = AppImage.fishing;
      isMinuteBased = true;
      break;
    case ConsumableBuffType.farmingBuff:
      localImageStr = AppImage.farming;
      isMinuteBased = true;
      break;
    case ConsumableBuffType.loggingBuff:
      localImageStr = AppImage.harvesting;
      isMinuteBased = true;
      break;
    default:
      localImageStr = AppImage.unknown;
      break;
  }

  String valueStr = '${effect.level}';
  if (isMinuteBased) {
    valueStr = '${(effect.seconds / 60).toStringAsFixed(0)}min';
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

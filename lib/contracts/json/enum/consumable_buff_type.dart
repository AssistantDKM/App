import '../../enum_base.dart';

enum ConsumableBuffType {
  unknown,
  healthRegen,
  staminaRegen,
  fullBuff,
  miningBuff,
  loggingBuff,
  huntingBuff,
  farmingBuff,
  fishingBuff,
  defenceBuff,
  speedBuff,
  xPBuff,

  //
  healthGain,
  staminaGain,
  tempHealthGain,
  tempStaminaGain,
}

final consumableBuffTypeValues = EnumValues({
  "": ConsumableBuffType.unknown,
  "0": ConsumableBuffType.healthRegen,
  "1": ConsumableBuffType.staminaRegen,
  "2": ConsumableBuffType.fullBuff,
  "3": ConsumableBuffType.miningBuff,
  "4": ConsumableBuffType.loggingBuff,
  "5": ConsumableBuffType.huntingBuff,
  "6": ConsumableBuffType.farmingBuff,
  "7": ConsumableBuffType.fishingBuff,
  "8": ConsumableBuffType.defenceBuff,
  "9": ConsumableBuffType.speedBuff,
  "10": ConsumableBuffType.xPBuff,
  //
  "20": ConsumableBuffType.healthGain,
  "21": ConsumableBuffType.staminaGain,
  "22": ConsumableBuffType.tempHealthGain,
  "23": ConsumableBuffType.tempStaminaGain,
});

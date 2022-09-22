import 'package:assistant_dinkum_app/constants/app_colour.dart';
import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

Widget chipFromString(String label) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Chip(
        label: genericItemDescription(label),
        backgroundColor: AppColour.defaultTagColour,
      ),
    );

List<Widget> loadSections(String sectionName, List<String> items) => [
      emptySpace2x(),
      genericItemGroup(sectionName),
      flatCard(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Wrap(
            alignment: WrapAlignment.center,
            children: items.map((item) => chipFromString(item)).toList(),
          ),
        ),
      ),
    ];

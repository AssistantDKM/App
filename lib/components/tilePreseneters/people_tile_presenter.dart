import 'package:assistant_dinkum_app/contracts/json/people_item.dart';
import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

Widget peopleTilePresenter(BuildContext context, PeopleItem item, int index) {
  String localImage =
      item.imageUrl.replaceAll('https://api.dinkumapi.com/', '');
  return genericListTile(
    context,
    leadingImage: 'assets/$localImage',
    name: item.name,
  );
}

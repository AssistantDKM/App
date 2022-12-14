import 'package:assistantapps_flutter_common/assistantapps_flutter_common.dart';
import 'package:flutter/material.dart';

import '../../constants/app_image.dart';

class PathService implements IPathService {
  @override
  String get imageAssetPathPrefix => AppImage.imageAssetPathPrefix;
  @override
  Widget get steamNewsDefaultImage =>
      localImage('$imageAssetPathPrefix/defaultNews.jpg');
  @override
  String get defaultProfilePic => '';
  @override
  String get unknownImagePath => AppImage.unknown;

  @override
  String get defaultGuideImage => AppImage.unknown;
}

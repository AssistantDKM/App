import '../base/persist_to_storage.dart';

class AddFavouriteAction extends PersistToStorage {
  final String appId;
  AddFavouriteAction(this.appId);
}

class RemoveFavouriteAction extends PersistToStorage {
  final String appId;
  RemoveFavouriteAction(this.appId);
}

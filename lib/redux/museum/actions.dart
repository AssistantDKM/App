import '../base/persist_to_storage.dart';

class AddToMuseumAction extends PersistToStorage {
  final String appId;
  AddToMuseumAction(this.appId);
}

class RemoveFromMuseumAction extends PersistToStorage {
  final String appId;
  RemoveFromMuseumAction(this.appId);
}

import '../base/persist_to_storage.dart';

class AddToCartAction extends PersistToStorage {
  final String appId;
  final int quantity;
  AddToCartAction({
    required this.appId,
    required this.quantity,
  });
}

class EditToCartAction extends PersistToStorage {
  final String appId;
  final int quantity;
  EditToCartAction({
    required this.appId,
    required this.quantity,
  });
}

class RemoveFromCartAction extends PersistToStorage {
  final String appId;
  RemoveFromCartAction(this.appId);
}

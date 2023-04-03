import 'required_item_details.dart';

class RequiredItemTreeDetails extends RequiredItemDetails {
  int cost;
  List<RequiredItemTreeDetails> children;

  RequiredItemTreeDetails({
    required appId,
    required quantity,
    required String icon,
    required String name,
    required bool isHidden,
    required this.cost,
    required this.children,
  }) : super(
          appId: appId,
          icon: icon,
          name: name,
          isHidden: isHidden,
          quantity: quantity,
        );

  factory RequiredItemTreeDetails.fromRequiredItemDetails(
      RequiredItemDetails req, int cost) {
    List<RequiredItemTreeDetails> children = List.empty(growable: true);
    return RequiredItemTreeDetails(
      appId: req.appId,
      icon: req.icon,
      name: req.name,
      isHidden: req.isHidden,
      quantity: req.quantity,
      cost: cost,
      children: children,
    );
  }

  // factory RequiredItemTreeDetails.fromGenericPageItem(
  //     GenericPageItem generic, int quantity) {
  //   return RequiredItemTreeDetails(
  //     id: generic.id,
  //     colour: generic.colour,
  //     icon: generic.icon,
  //     name: generic.name,
  //     quantity: quantity,
  //   );
  // }

  @override
  String toString() {
    return "${quantity}x $name";
  }
}

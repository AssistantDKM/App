import '../contracts/json/inventory_item.dart';
import '../contracts/pageItem/cart_item_page_item.dart';

bool searchInventoryItem(InventoryItem inv, String search) =>
    inv.name.toLowerCase().contains(search);

bool searchCartItemPageItem(CartItemPageItem cart, String search) =>
    cart.item.name.toLowerCase().contains(search);

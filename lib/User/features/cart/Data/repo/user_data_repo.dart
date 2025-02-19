import '../../../Orders/Data/models/order_model.dart';
import '../../../home/data/models/coffe_item.dart';
import '../DataSource/user_data_firebase.dart';

class UserDataRepo {
  UserData userData;
  UserDataRepo(this.userData);

  Future<List<CoffeeItem>> fetchCart() async {
    final List<CoffeeItem> cart = await userData.getCart();
    return cart;
  }

  Future<void> addToCart(List<CoffeeItem> myCart) async {
    await userData.updateCart(myCart);
  }

  Future<void> updateQuantity(
      String selectedSize, String id, int myQuantity) async {
    await userData.updateQuantityNumber(
      selectedSize,
      id,
      myQuantity,
    );
  }

  Future<void> addOrderToAdminOrders(OrderModel order) async {
    await userData.addOrderToAdminOrders(order);
  }
}

import 'package:coffe_app/features/cart/Data/DataSource/user_data_firebase.dart';
import 'package:coffe_app/features/home/data/models/coffe_item.dart';

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
}

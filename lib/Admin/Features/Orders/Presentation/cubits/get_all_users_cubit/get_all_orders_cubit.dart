import 'package:bloc/bloc.dart';
import 'package:coffe_app/Admin/Features/Orders/Data/repos/all_orders_repo.dart';
import 'package:coffe_app/Admin/Features/Users/Data/repos/all_users_repo.dart';
import 'package:coffe_app/features/Orders/Data/models/order_model.dart';
import 'package:coffe_app/features/home/data/models/UserData/user_data.dart';
import 'package:meta/meta.dart';

part 'get_all_orders_state.dart';

class GetAllOrdersCubit extends Cubit<GetAllOrdersState> {
  GetAllOrdersCubit(this.allOrdersRepo) : super(GetAllOrdersInitial());
  AllOrdersRepo allOrdersRepo;

  Future getAllOrders() async {
    emit(GetAllOrdersLoading());
    try {
      List<OrderModel> orders = await allOrdersRepo.getOrders();
      emit(GetAllOrdersSuccess(orders: orders));
      return;
    } catch (e) {
      emit(GetAllOrdersFailure(error: e.toString()));
      return;
    }
  }
}

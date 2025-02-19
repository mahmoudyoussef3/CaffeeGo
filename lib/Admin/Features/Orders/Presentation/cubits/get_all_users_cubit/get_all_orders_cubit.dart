import 'package:coffe_app/Admin/Features/Orders/Data/repos/all_orders_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../../../../User/features/Orders/Data/models/order_model.dart';

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

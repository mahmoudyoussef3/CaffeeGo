import 'package:coffe_app/Admin/Features/AdminNotification/data/admin_notifications.dart';
import 'package:coffe_app/Admin/Features/Items/Data/Repo/admin_items_repo.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../User/features/home/data/models/coffe_item.dart';
import '../../../../../User/features/home/presentation/cubit/coffe_items/coffee_items_cubit.dart';
import '../../../../../config/notifications.dart/send_notification_srevice.dart';

part 'admin_items_state.dart';

class AdminItemsCubit extends Cubit<AdminItemsState> {
  AdminItemsCubit(this.adminItemsRepo) : super(AdminItemsInitial());
  AdminItemsRepo adminItemsRepo;

  Future addCoffeeItem(CoffeeItem coffee, BuildContext context) async {
    emit(AdminItemsLoading());
    try {
      await adminItemsRepo.addCoffeeRepo(coffee);
      final coffeeCubit = context.read<CoffeeItemsCubit>();
      coffeeCubit.fetchCoffeeItems();
      emit(AdminItemsLoaded());
      sendNotificationToAllUsers(
          title: 'New Drink',
          body: '${coffee.name}has been added',
          data: {}, img: coffee.image);

    } catch (e) {
      emit(AdminItemsError(errorMessage: e.toString()));
    }
  }

  Future deleteCoffeeItem(String coffeeName, BuildContext context) async {
    emit(AdminItemsLoading());
    try {
      await adminItemsRepo.deleteCoffeeRepo(coffeeName);
      final coffeeCubit = context.read<CoffeeItemsCubit>();
      coffeeCubit.fetchCoffeeItems();
      emit(AdminItemsLoaded());
    } catch (e) {
      emit(AdminItemsError(errorMessage: e.toString()));
    }
  }
}

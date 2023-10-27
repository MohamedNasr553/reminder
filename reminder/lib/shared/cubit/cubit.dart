import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminder/endPoints.dart';
import 'package:reminder/models/reminder_model.dart';
import 'package:reminder/modules/reminder_app/archived_tasks/archived_tasks.dart';
import 'package:reminder/modules/reminder_app/done_tasks/done_tasks.dart';
import 'package:reminder/modules/reminder_app/new_tasks/new_tasks.dart';
import 'package:reminder/shared/cubit/states.dart';
import 'package:reminder/shared/network/remote/dio_helper.dart';

class ReminderCubit extends Cubit<ReminderStates>{
  ReminderCubit() : super(ReminderInitialState());

  static ReminderCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> screens = [
    const NewTasks(),
    const DoneTasks(),
    const ArchivedTasks(),
  ];

  List<String> titles = ['New Tasks', 'Done Tasks', 'Archived Tasks'];

  void changeIndex(index) {
    currentIndex = index;

    emit(ChangeBottomNavBarState());
  }

  bool isDark = false;

  void changeTheme(){
    isDark = !isDark;

    emit(ChangeThemeState());
  }

  ReminderAppModel? reminderAppModel;
  void getAllEvents(){
    emit(ReminderGetEventsLoadingState());

    DioHelper.getData(
      url: GET_EVENTS,
    ).then((value){
      reminderAppModel = ReminderAppModel.fromJson(value.data);
      print(reminderAppModel?.data?.reminderData.toString());

      emit(ReminderGetEventsSuccessState());
    }).catchError((error){
      print(error);

      emit(ReminderGetEventsErrorState(error.toString()));
    });
  }

  ReminderModel? addEventsReminderModel;
  void addEvents({
    required String name,
    required String description,
    required var startDate,
}){
    emit(ReminderAddEventsLoadingState());

    DioHelper.postData(
      url: ADD_EVENT,
      data: {
        'name' : name,
        'description' : description,
        'startDate' : startDate,
      },
    ).then((value){
      addEventsReminderModel = ReminderModel.fromJson(value.data);
      getAllEvents();

      emit(ReminderAddEventsSuccessState());
    }).catchError((error){
      print(error.toString());

      emit(ReminderAddEventsErrorState(error.toString()));
    });
  }

  ReminderModel? updateEventsReminderModel;
  void updateEvents({
    required String name,
    required String description,
    required var startDate,
  }){
    emit(ReminderUpdateEventsLoadingState());

    DioHelper.patchData(
      url: UPDATE_EVENT,
      data: {
        'name' : name,
        'description' : description,
        'startDate' : startDate,
      },
    ).then((value){
      updateEventsReminderModel = ReminderModel.fromJson(value.data);
      getAllEvents();

      emit(ReminderUpdateEventsSuccessState());
    }).catchError((error){
      print(error.toString());

      emit(ReminderUpdateEventsErrorState(error.toString()));
    });
  }
}
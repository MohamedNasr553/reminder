import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminder/modules/reminder_app/add_task/add_task.dart';
import 'package:reminder/shared/components/components.dart';
import 'package:reminder/shared/cubit/cubit.dart';
import 'package:reminder/shared/cubit/states.dart';

class ReminderLayout extends StatelessWidget {
  const ReminderLayout({super.key});

  @override
  Widget build(BuildContext context) {
    var reminderCubit = ReminderCubit.get(context);

    return BlocConsumer<ReminderCubit, ReminderStates>(
      listener: (context, states){},
      builder: (context, states){
        return Scaffold(
          appBar: AppBar(
            title: Text(
              reminderCubit.titles[reminderCubit.currentIndex],
              style: const TextStyle(
                fontSize: 20.0,
              ),
            ),
            actions: [
              IconButton(
                onPressed: (){
                  reminderCubit.changeTheme();
                },
                icon: const Icon(
                  Icons.brightness_4_outlined,
                ),
              ),
            ],
          ),
          body: reminderCubit.screens[reminderCubit.currentIndex],
          floatingActionButton: FloatingActionButton.extended(
            onPressed: (){
              navigateAndFinish(context, AddTasks());
            },
            label: const Text(
              'Add Task',
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: reminderCubit.currentIndex,
            elevation: 5.0,
            onTap: (index) {
              reminderCubit.changeIndex(index);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.menu,
                ),
                label: 'Tasks',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.check_circle_outline,
                ),
                label: 'Done',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.archive_outlined,
                ),
                label: 'Archived',
              ),
            ],
          ),
        );
      },
    );
  }
}

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminder/models/reminder_model.dart';
import 'package:reminder/shared/cubit/cubit.dart';
import 'package:reminder/shared/cubit/states.dart';

class NewTasks extends StatelessWidget {
  const NewTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ReminderCubit, ReminderStates>(
      listener: (context, state){},
      builder: (context, state){
        return ConditionalBuilder(
          condition: ReminderCubit.get(context).reminderAppModel != null,
          builder: (context) => getAllTasks(ReminderCubit.get(context).reminderAppModel),
          fallback: (context) => const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget newTasksBuilderItem(ReminderModel? model)
    =>
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
            ),
            width: double.infinity,
            height: 100.0,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        model!.name!,
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        model.description!,
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        model.startDate!,
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  CircleAvatar(
                    backgroundColor: Colors.green,
                    radius: 20.0,
                    child: IconButton(
                      onPressed: (){},
                      icon: const Icon(
                        Icons.check,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.blue,
                    radius: 20.0,
                    child: IconButton(
                      onPressed: (){},
                      icon: const Icon(
                        Icons.edit,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.red,
                    radius: 20.0,
                    child: IconButton(
                      onPressed: (){},
                      icon: const Icon(
                        Icons.delete,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );

  ListView getAllTasks(ReminderAppModel? model)
    =>
        ListView.separated(
            itemBuilder: (context, index) => newTasksBuilderItem(model.data!.reminderData[index]),
            separatorBuilder: (context, index) => const SizedBox(width: double.infinity, height: 1.0,),
            itemCount: model!.results!,
        );
}
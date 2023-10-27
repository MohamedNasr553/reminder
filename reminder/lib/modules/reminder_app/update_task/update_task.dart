import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:reminder/layout/reminder_app/reminder_layout.dart';
import 'package:reminder/models/reminder_model.dart';
import 'package:reminder/shared/components/components.dart';
import 'package:reminder/shared/cubit/cubit.dart';
import 'package:reminder/shared/cubit/states.dart';

class UpdateTask extends StatelessWidget {
  ReminderModel? model;
  UpdateTask({super.key});

  var nameController = TextEditingController();
  var descriptionController = TextEditingController();
  var startDateController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ReminderCubit, ReminderStates>(
      listener: (context, state){},
      builder: (context, state){
        var model = ReminderCubit.get(context).updateEventsReminderModel;

        nameController.text = model!.name!;
        descriptionController.text = model.description!;
        startDateController.text = model.startDate!;
        return Scaffold(
          appBar: AppBar(),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  defaultFormField(
                    controller: nameController,
                    type: TextInputType.text,
                    validate: (value){
                      if(value!.isEmpty){
                        return "Name must not be empty";
                      }
                      return null;
                    },
                    label: "Event Name",
                    prefix: Icons.title,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  defaultFormField(
                    controller: descriptionController,
                    type: TextInputType.text,
                    validate: (value){},
                    label: "Event Description (optional)",
                    prefix: Icons.menu,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  defaultFormField(
                    controller: startDateController,
                    type: TextInputType.datetime,
                    validate: (value){
                      if(value!.isEmpty){
                        return "Date must not be empty";
                      }
                      return null;
                    },
                    onTap: (){
                      showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime.parse("2025-05-03")
                      ).then((value) {
                        startDateController.text = DateFormat.yMMMd().format(value!);

                        print(DateFormat.yMMMd().format(value));
                      });
                    },
                    label: "Event StartDate",
                    prefix: Icons.watch_later_outlined,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  defaultButton(
                    radius: 5.0,
                    width: 200.0,
                    function: (){
                      if(formKey.currentState!.validate()){
                        ReminderCubit.get(context).updateEvents(
                          name: nameController.text,
                          description: descriptionController.text,
                          startDate: startDateController.text,
                        );
                        navigateAndFinish(context, const ReminderLayout());
                      }
                    }, text: 'UPDATE',
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

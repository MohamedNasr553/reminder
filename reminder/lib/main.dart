import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminder/bloc_observer.dart';
import 'package:reminder/shared/cubit/cubit.dart';
import 'package:reminder/shared/cubit/states.dart';
import 'package:reminder/shared/styles/themes.dart';
import 'layout/reminder_app/reminder_layout.dart';
import 'shared/network/remote/dio_helper.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ReminderCubit()..getAllEvents(),
        ),
      ],
      child: BlocConsumer<ReminderCubit, ReminderStates>(
        listener: (context, state){},
        builder: (context, state){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode:
            ReminderCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: const ReminderLayout(),
          );
        },
      ),
    );
  }
}

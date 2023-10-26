abstract class ReminderStates{}

class ReminderInitialState extends ReminderStates{}

class ChangeBottomNavBarState extends ReminderStates{}

class ChangeThemeState extends ReminderStates{}

class ReminderGetEventsLoadingState extends ReminderStates{}

class ReminderGetEventsSuccessState extends ReminderStates{}

class ReminderGetEventsErrorState extends ReminderStates{
  final String error;

  ReminderGetEventsErrorState(this.error);
}

class ReminderAddEventsLoadingState extends ReminderStates{}

class ReminderAddEventsSuccessState extends ReminderStates{}

class ReminderAddEventsErrorState extends ReminderStates{
  final String error;

  ReminderAddEventsErrorState(this.error);
}
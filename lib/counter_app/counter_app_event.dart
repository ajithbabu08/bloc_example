part of 'counter_app_bloc.dart';

@immutable
sealed class CounterAppEvent {}


class Increment extends CounterAppEvent{}


class Decrement extends CounterAppEvent{}
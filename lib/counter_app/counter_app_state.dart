part of 'counter_app_bloc.dart';

class CounterAppState {
  final int count;

  CounterAppState({required this.count});
}

class InitialState extends CounterAppState {
  InitialState() : super(count: 0);
}

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'counter_app_event.dart';
part 'counter_app_state.dart';

class CounterAppBloc extends Bloc<CounterAppEvent, CounterAppState> {
  CounterAppBloc() : super(InitialState()) {

    on<Increment>((event, emit) {
      final currentvalue = state.count;
      final newincrementvalue = currentvalue + 1;
      return emit(CounterAppState(count: newincrementvalue));
    });


     on<Decrement>((event, emit) {
      final currentvalue = state.count;
      final newdecrementvalue = currentvalue - 1;
      return emit(CounterAppState(count: newdecrementvalue));
    });
  }
}

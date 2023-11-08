import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../color/color_cubit.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  int incrementSize = 1;
  final ColorCubit colorCubit;
  //We will listen the color state in the future
  late final StreamSubscription colorSubscription;
  //Abhi listen nahin kar rahe lekin baad mein listen karenge

  CounterCubit({
    required this.colorCubit,
  }) : super(CounterState.initial()) {
    //stream will continuosly listen to the changes
    colorSubscription = colorCubit.stream.listen((ColorState colorState) {
  //Koi bhi state change hoga color mein to ham usko listen kar lenge
  //Bas we will not be able to know the initial state of color uske liye initial state ko 
  // constructor mein alag se bhejna padega
      if (colorState.color == Colors.red) {
        incrementSize = 1;
      } else if (colorState.color == Colors.green) {
        incrementSize = 10;
      } else if (colorState.color == Colors.blue) {
        incrementSize = 100;
      } else if (colorState.color == Colors.black) {
        emit(state.copyWith(counter: state.counter - 100));
        incrementSize = -100;
      }
    });
  }

//counter state ko change karega yeh function
  void changeCounter() {
    emit(state.copyWith(counter: state.counter + incrementSize));
  }

  @override
  //Agar stream subscription ko close nahin karenge to leakage issues ho sakte hain
  Future<void> close() {
    colorSubscription.cancel();
    return super.close();
  }
}

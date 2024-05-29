import 'package:bloc/bloc.dart';
import 'package:bloc_counter/bloc/switch/switch_event.dart';
import 'package:bloc_counter/bloc/switch/switch_state.dart';
import 'package:flutter/material.dart';

class SwitchBloc extends Bloc<SwitchEvents,SwitchState>{
  SwitchBloc():super(SwitchState()){
    on<EnableOrDisableNotifications>(_enableOrDisableNotifications);
    on<SliderEvent>(_slider);
  }

  void _enableOrDisableNotifications
      (EnableOrDisableNotifications event, Emitter<SwitchState> emit ){
    emit (state.copyWith(isSwitch: !state.isSwitch));
  }

  void _slider(SliderEvent event, Emitter<SwitchState> emit ){
    emit (state.copyWith(slider:  event.slider.toDouble()));
  }


}
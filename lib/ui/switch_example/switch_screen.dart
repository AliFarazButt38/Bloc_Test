import 'package:bloc_counter/bloc/switch/switch_bloc.dart';
import 'package:bloc_counter/bloc/switch/switch_event.dart';
import 'package:bloc_counter/bloc/switch/switch_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SwitchExample extends StatefulWidget {
  const SwitchExample({Key? key}) : super(key: key);

  @override
  State<SwitchExample> createState() => _SwitchExampleState();
}

class _SwitchExampleState extends State<SwitchExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Example Switch"),),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Notifications",),
                BlocBuilder<SwitchBloc, SwitchState>(
                  buildWhen: (previous,current)=>previous.isSwitch !=current.isSwitch,
                  builder: (context, state) {
                    return Switch(value: state.isSwitch, onChanged: (newValue) {
                      context.read<SwitchBloc>().add(
                          EnableOrDisableNotifications());
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 30,),
            BlocBuilder<SwitchBloc, SwitchState>(
              builder: (context, state) {
                return Container(
                  height: 200,
                  color: Colors.red.withOpacity(state.slider)
                );
              },
            ),
            SizedBox(height: 50,),
            BlocBuilder<SwitchBloc, SwitchState>(
              buildWhen: (previous ,current)=>previous.slider!=current.slider ,
              builder: (context, state) {
                return Slider(value: state.slider, onChanged: (value) {
                  context.read<SwitchBloc>().add(SliderEvent(slider: value));
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

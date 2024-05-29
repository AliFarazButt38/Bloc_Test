import 'package:bloc_counter/bloc/todo/todo_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/todo/todo_bloc.dart';
import '../../bloc/todo/todo_state.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({Key? key}) : super(key: key);

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Todo Screen"),),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          if(state.todosList.isEmpty){
            return const Center(child:  Text("No Todos"),);
          }else if(state.todosList.isNotEmpty){
            return ListView.builder(
                itemCount: state.todosList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(state.todosList[index]),
                    trailing: IconButton(
                        onPressed: () {
                          context.read<TodoBloc>().add(RemoveTodoEvent(task:state.todosList[index] ));

                        }, icon: Icon(Icons.delete)),

                  );
                }
            );
          }else{
            return SizedBox();
          }

        },
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        for(int i=0; i<20 ; i++) {
          context.read<TodoBloc>().add(AddTodoEvent(task: 'Task ' + i.toString()));
        }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

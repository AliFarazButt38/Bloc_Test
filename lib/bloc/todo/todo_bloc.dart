import 'package:bloc_counter/bloc/todo/todo_event.dart';
import 'package:bloc_counter/bloc/todo/todo_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState>{
  final List<String> todosList= [];

  TodoBloc():super(const TodoState()){
    on<AddTodoEvent>(_addTodoEvent);
    on<RemoveTodoEvent>(_removeTodoEvent);

  }
void _addTodoEvent(AddTodoEvent event, Emitter<TodoState> emit ){
  todosList.add(event.task);
  emit (state.copyWith(todosList: List.from(todosList)));
}
  void _removeTodoEvent(RemoveTodoEvent event, Emitter<TodoState> emit ){
    todosList.remove(event.task);
    emit (state.copyWith(todosList: List.from(todosList)));
  }


}
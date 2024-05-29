import 'package:bloc_counter/bloc/counter/counter_bloc.dart';
import 'package:bloc_counter/bloc/favouriteApp/favourite_app_bloc.dart';
import 'package:bloc_counter/bloc/imagePicker/image_picker_bloc.dart';
import 'package:bloc_counter/bloc/posts/posts_bloc.dart';
import 'package:bloc_counter/bloc/switch/switch_bloc.dart';
import 'package:bloc_counter/bloc/todo/todo_bloc.dart';
import 'package:bloc_counter/postScreen.dart';
import 'package:bloc_counter/repository/favourite_repository.dart';
import 'package:bloc_counter/ui/counter_screen.dart';
import 'package:bloc_counter/ui/favouriteApp/favourite_app.dart';
import 'package:bloc_counter/ui/image_picker.dart';
import 'package:bloc_counter/ui/switch_example/switch_screen.dart';
import 'package:bloc_counter/ui/todo/todo_screen.dart';
import 'package:bloc_counter/ui/util/image_picker_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => CounterBloc(),
        ),
        BlocProvider(
          create: (context) => SwitchBloc(),
        ),
        BlocProvider(
          create: (context) => ImagePickerBloc(ImagePickerUtil()),
        ),
        BlocProvider(
          create: (context) => TodoBloc(),
        ),
        BlocProvider(
            create: (context)=>FavouriteBloc(FavouriteRepository()),
        ),
        BlocProvider(
          create: (_)=> PostBloc()
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: PostScreen(),
      ),
    );
  }
}




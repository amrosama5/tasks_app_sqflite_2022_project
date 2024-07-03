import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/pages/home_page.dart';
import 'package:todo_app/shared/cubits/bloc_observer.dart';
import 'package:todo_app/shared/cubits/cubit.dart';

void main()
{
  Bloc.observer = MyBlocObserver();
  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (context) => AppCubit()..getDataFromDatabase(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home:HomePage(),
      ),
    );
  }
}





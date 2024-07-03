import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/shared/cubits/states.dart';
import '../../pages/archive_tasks_page.dart';
import '../../pages/done_tasks_page.dart';
import '../../pages/new_tasks_page.dart';
import '../componets/constans.dart';
import '../network/local/sqldb.dart';

class AppCubit extends Cubit<AppStates>{
  AppCubit() : super(AppInitialState());


  static AppCubit get(context) => BlocProvider.of(context);

  List<Widget> screens = [NewTasksPage(), DoneTasksPage(), ArchiveTasksPage()];
  List<String> titles = ['New Tasks', 'Done Tasks', 'Archive Tasks'];

  int currentIndex = 0;

  void changeIndex(int index)
  {
  currentIndex = index;
  emit(AppChangeBottomNavBarState());
  }

  SqlDb  sqldb = SqlDb();

  void insertIntoDatabase(List<Map<dynamic, dynamic>> value)
  {
  newTasks = value;
  emit(AppCreateFromDataBaseState());
  emit(AppGetFromDataBaseState());
  print('inserted form database');
  }

  void getDataFromDatabase(){
    sqldb.getDatabase()?.then((value)
    {
      newTasks = [];
      archiveTasks = [];
      doneTasks = [ ];
      
     value.forEach((element) {
       if(element['status']=='new')
         newTasks.add(element);
       else if(element['status']=='done')
         doneTasks.add(element);
       else
         archiveTasks.add(element);
     });
     emit(AppGetFromDataBaseState());
    });
  }


  void updateDatabase(status,id){
    sqldb.updateDatabase(status: status, id: id).then((value)
    {
        getDataFromDatabase();
        emit(AppUpdateFromDataBaseState());
        print('updated form database');
    });
  }

  void deleteFromDatabase(id){
    sqldb.deleteDatabase(id).then((value) {
      getDataFromDatabase();
      emit(AppDeleteFromDataBaseState());
      print('deleted form database');
    });
  }
}

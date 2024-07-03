import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/pages/archive_tasks_page.dart';
import 'package:todo_app/pages/done_tasks_page.dart';
import 'package:todo_app/pages/new_tasks_page.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/shared/componets/constans.dart';
import 'package:todo_app/shared/cubits/cubit.dart';
import 'package:todo_app/shared/cubits/states.dart';
import '../shared/componets/widgtes.dart';
import '../shared/network/local/sqldb.dart';
class HomePage extends StatelessWidget
{
  /// variables
  var formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  /// Objects
  SqlDb  sqldb = SqlDb();
  @override
  Widget build(BuildContext context)
  {
    AppCubit cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit,AppStates>(
      builder: (BuildContext context ,AppStates state)
      {
        return Scaffold(
          appBar: AppBar(
            title:  Text(cubit.titles[cubit.currentIndex]),
            centerTitle: true,
          ),
          body: cubit.screens[cubit.currentIndex],
          /// FloatingActionButton to show showModalBottomSheet and enter information
          floatingActionButton: FloatingActionButton(
            onPressed: ()
            {
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return SingleChildScrollView(
                      child: Container(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Form(
                            key: formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomFormField(
                                  labelText: 'Task Title',
                                  controller: titleController,
                                  keyboardType: TextInputType.text,
                                  prefixIcon: const Icon(Icons.title),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'title must not be empty';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                CustomFormField(
                                  labelText: 'Task Time',
                                  controller: timeController,
                                  keyboardType: TextInputType.datetime,
                                  prefixIcon: const Icon(Icons.watch_later),
                                  onTap: (){
                                    showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now()
                                    ).then((value) {
                                      timeController.text = value!.format(context);
                                    });
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Time must not be empty';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                CustomFormField(
                                  labelText: 'Task  Date',
                                  controller: dateController,
                                  prefixIcon: Icon(Icons.date_range),
                                  onTap: (){
                                    showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime.parse('2024-12-30'),
                                    ).then((value) {
                                      dateController.text = DateFormat.yMMMd().format(value!);
                                    });
                                  },
                                  validator: (value)
                                  {
                                    if (value!.isEmpty) {
                                      return 'Date must not be empty';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                CustomMaterialButton(
                                  color: Colors.deepPurple,
                                  text: 'Add',
                                  onPressed: ()async
                                  {
                                    if (formKey.currentState!.validate()) {
                                      const CircularProgressIndicator();
                                      sqldb.insertDatabase(
                                          title:titleController.text,
                                          time: timeController.text,
                                          date: dateController.text
                                      )?.then((value)
                                      {
                                        sqldb.getDatabase()?.then((value)
                                        {
                                          cubit.insertIntoDatabase(value);
                                          cubit.getDataFromDatabase();
                                        });
                                      });
                                      dateController.text='';
                                      timeController.text='';
                                      titleController.text='';
                                      Navigator.pop(context);
                                    }
                                  },
                                  borderRadius: BorderRadius.circular(10),
                                  textStyle: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                CustomMaterialButton(
                                  color: Colors.deepPurple,
                                  text: 'Close',
                                  onPressed: () {
                                    titleController.text= '';
                                    timeController.text= '';
                                    dateController.text= '';
                                    Navigator.pop(context);
                                  },
                                  borderRadius: BorderRadius.circular(10),
                                  textStyle: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  });
            },
            child: const Icon(Icons.add),
          ),
          /// Navigating between  3 screens
          bottomNavigationBar: BottomNavigationBar(
            elevation: 15,
            type: BottomNavigationBarType.fixed,
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeIndex(index);
            },
            items: const
            [
              BottomNavigationBarItem(
                  icon: Icon(Icons.menu), label: 'Tasks'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.done_outline), label: 'done tasks'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.archive), label: 'archive tasks'),
            ],
          ),
        );
      },
      listener: (BuildContext context ,AppStates state){},
    );
  }
}


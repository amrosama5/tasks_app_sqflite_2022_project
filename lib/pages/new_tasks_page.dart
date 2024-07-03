import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/shared/cubits/cubit.dart';
import 'package:todo_app/shared/cubits/states.dart';
import 'package:todo_app/shared/network/local/sqldb.dart';
import '../shared/componets/constans.dart';

class NewTasksPage extends StatelessWidget {
   NewTasksPage({super.key});
  SqlDb sqlDb = SqlDb();
  @override
  Widget build(BuildContext context)
  {
    AppCubit cubit = AppCubit.get(context);
    return Scaffold(
      body: BlocConsumer<AppCubit , AppStates>(
        listener: (context , state){

        },
        builder: (context, state){
          return  newTasks.isEmpty ?
          const Center(child: Text('Not have New Tasks.',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)) :
          ListView.separated(
            itemBuilder: (BuildContext context , i) => Dismissible(
              key: Key(newTasks[i]['id'].toString()),
              onDismissed: (direction){
                cubit.deleteFromDatabase(newTasks[i]['id']);
              },
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.deepPurple,
                          child: Center(
                            child: Text(
                              '${newTasks[i]['time']}',
                              style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '${newTasks[i]['title']}',
                              style: const TextStyle(fontSize: 25),
                            ),
                            Text(
                              '${newTasks[i]['date']}',
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 20),
                            ),
                          ],
                        ),
                        IconButton(
                            onPressed: (){
                              cubit.updateDatabase('done', newTasks[i]['id']);
                              print(newTasks);
                            },
                            icon: const Icon(Icons.check_box,color: Colors.green,),
                        ),
                        IconButton(
                            onPressed: (){
                              cubit.updateDatabase('archive', newTasks[i]['id']);
                              print(newTasks);
                            },
                            icon: const Icon(Icons.archive),
                        ),

                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
            itemCount: newTasks.length,
            separatorBuilder: (context , i) => const Divider(
              height: 1,
              thickness: 2,
            ),
          );
        },
      ),
    );
  }
}

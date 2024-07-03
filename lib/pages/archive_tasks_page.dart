import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/shared/cubits/cubit.dart';
import 'package:todo_app/shared/cubits/states.dart';
import 'package:todo_app/shared/network/local/sqldb.dart';
import '../shared/componets/constans.dart';

class ArchiveTasksPage extends StatelessWidget {
  ArchiveTasksPage({super.key});
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
          return  archiveTasks.isEmpty ?
          const Center(child: Text('Not have Archive Tasks.',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)) :
          ListView.separated(
            itemBuilder: (BuildContext context , i) => Dismissible(
              key: Key(archiveTasks[i]['id'].toString()),
              onDismissed: (direction){
                cubit.deleteFromDatabase(archiveTasks[i]['id']);
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
                              '${archiveTasks[i]['time']}',
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
                              '${archiveTasks[i]['title']}',
                              style: const TextStyle(fontSize: 25),
                            ),
                            Text(
                              '${archiveTasks[i]['date']}',
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 20),
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: (){
                            cubit.updateDatabase('done', archiveTasks[i]['id']);
                          },
                          icon: const Icon(Icons.check_box,color: Colors.green,),
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
            itemCount: archiveTasks.length,
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
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
class SqlDb
{

  static Database? _db;

  Future<Database?> get db async {
  if(_db == null ){
    return await intialDb();
  }else {
    return _db;
  }
  }

  intialDb() async
  {
   String databasePath = await getDatabasesPath();
   String path = join(databasePath,'todoApp.db');
   Database database = await openDatabase(path,onCreate: _onCreate, version: 1,onUpgrade: _onUpgrade);
   print('database opened');
   return database;
  }

  _onUpgrade(Database database ,int oldVersion , int newVersion)
  {
   print('database onUpgrade');
  }

  _onCreate(Database db, int index)async {
    await db.execute('''
    CREATE TABLE tasks (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL,
    date TEXT NOT NULL,
    time TEXT NOT NULL,
    status TEXT NOT NULL
    )
    ''');
    print('database created =======================');
  }


  Future<List<Map>>? getDatabase()async {
    Database? database = await db;
    List<Map> response = await database!.rawQuery('SELECT * FROM tasks');
    print('get database');
    return response;
  }

  Future<dynamic>? insertDatabase({required String title, required String date, required String time})async
  {
    Database? database = await db;
    int response = await database!.rawInsert("INSERT INTO 'tasks' ('title','date','time','status') VALUES('$title','$date','$time','new')");
    print('inserted database');
    return response;
  }

  Future<int> deleteDatabase(int id)async
  {
    Database? database = await db;
    int response = await database!.rawDelete('DELETE FROM tasks WHERE id = ?',
        [id]);
    return response;
  }

  Future<int> updateDatabase({required String status,required id})async
  {
    Database? database = await db;
     int response = await database!.rawUpdate('UPDATE tasks SET status = ? WHERE id = ?',
        ['$status', id]);
     return response;
  }
}
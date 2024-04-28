import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqlite_app/model/students.dart';

class DatabaseHandler {
  Future<Database> initializeDB() async {
    //initial 위치 알려주는
    String path = await getDatabasesPath(); //앱 위치가 다르다.
    return openDatabase(
      join(path, 'student.db'),
      onCreate: (db, version) async {
        await db.execute(
            "create table students(id integer primary key autoincrement, code text, name text, dept text, phone text)" //컬럼 이름이 id
            );
      },
      version: 1,
    );
  }

  //검색하기
  Future<List<Students>> queryStudents() async {
    final Database db = await initializeDB(); //db 어디있고 만들어져있는지 없는지 보기
    final List<Map<String, Object?>> queryResults =
        await db.rawQuery('select * from students');
    return queryResults
        .map((e) => Students.fromMap(e))
        .toList(); //db정보 가져오기 query에 남는다.
  }

  //입력하기
  Future<int> insertStudents(Students student) async {
    int result = 0;
    final Database db = await initializeDB();
    result = await db.rawInsert(
        'insert into students(code,name,dept,phone) values (?,?,?,?)',
        [student.code, student.name, student.dept, student.phone]);
    return result;
  }

  //수정하기
  Future<int> updateStudents(Students student) async {
    int result = 0;
    final Database db = await initializeDB();
    result = await db.rawUpdate(
        'update students set name=?,dept=?,phone=? where code = ?',
        [student.name, student.dept, student.phone, student.code]);
    return result;
  }
}

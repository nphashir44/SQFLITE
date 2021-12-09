import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflitedb/model/model_student.dart';

ValueNotifier<List<StudentModel>> studentListNotifier = ValueNotifier([]);

late Database _db;

Future<void> openDB() async {
  _db = await openDatabase('studentDB', version: 1,
      onCreate: (Database db, int version) async {
    await db.execute(
        'CREATE TABLE students (id INTEGER PRIMARY KEY,name TEXT,age TEXT)');
  });
}

Future<void> addStudentDB(StudentModel value) async {
  //studentListNotifier.value.add(value);
  await _db.rawInsert(
      'INSERT INTO students(name,age)VALUES(?,?)', [value.name, value.age]);

      
  // studentListNotifier.value.add(value);
  // studentListNotifier.notifyListeners();
  getAllStudents();
}

Future<void> getAllStudents() async {
  final data = await _db.rawQuery('SELECT * FROM students');
  studentListNotifier.value.clear();

  for (var map in data) { 
    
    final student = StudentModel.fromMap(map);
    studentListNotifier.value.add(student);
    // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
    studentListNotifier.notifyListeners();
  }
}


Future<void> updateStudentSQL(String name, String age,int id) async {
  await _db.rawUpdate(
      'UPDATE students SET name= ?, age= ? WHERE id= ?', [name, age , id]);

  getAllStudents();
}
Future<void> deleteStudentSQL(int id)async{
  await _db.rawDelete('DELETE FROM students WHERE id = ?',[id]);
  // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
  studentListNotifier.notifyListeners();
  getAllStudents();
}
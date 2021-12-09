import 'package:flutter/material.dart';
import 'package:sqflitedb/functions/database.dart';
import 'package:sqflitedb/widgets/add_students_widget.dart';
import 'package:sqflitedb/widgets/list_student_widget.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    getAllStudents();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Student with Hive"),
      ),
      body: SafeArea(
          child: Column(
        children: [
          AddStudentWidget(),
          const Expanded(child: ListStudentWidget())
        ],
      )),
    );
  }
}

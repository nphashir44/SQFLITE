import 'package:flutter/material.dart';
import 'package:sqflitedb/functions/database.dart';
import 'package:sqflitedb/model/model_student.dart';

class AddStudentWidget extends StatelessWidget {
  AddStudentWidget({
    Key? key,
  }) : super(key: key);
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
   
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            TextFormField(
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return "Enter Name";
                }
              },
              controller: nameController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: "Enter Name"),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return "Enter Age";
                }
              },
              controller: ageController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: "Enter Age"),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  addStudent();
                },
                child:const Text("Add"),
                style: const ButtonStyle(),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> addStudent() async {
    if (formKey.currentState!.validate()) {
      final student =
          StudentModel(name: nameController.text, age: ageController.text);
      await addStudentDB(student);
      
    }
  }
}

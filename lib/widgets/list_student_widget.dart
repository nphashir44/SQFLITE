import 'package:flutter/material.dart';
import 'package:sqflitedb/functions/database.dart';
import 'package:sqflitedb/model/model_student.dart';

class ListStudentWidget extends StatelessWidget {
  const ListStudentWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      builder: (BuildContext context, List<StudentModel> studentList,
          Widget? child) {
        return ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            final data = studentList[index];

            return ListTile(
                title: Text(data.name),
                subtitle: Text(data.age),
                trailing: Wrap(
                  spacing: 12,
                  children: <Widget>[
                    IconButton(
                      onPressed: () {
                         deleteStudentSQL(data.id!);
                      },
                      icon: const Icon(Icons.delete, color: Colors.red),
                    ),
                    IconButton(
                        onPressed: () {
                          openDialog(data.name, data.age, data.id!, context);
                          
                        },
                        icon: const Icon(Icons.edit))
                  ],
                ));
          },
          itemCount: studentList.length,
          separatorBuilder: (BuildContext context, int index) {
            return const Divider();
          },
        );
      },
      valueListenable: studentListNotifier,
    );
  }

  openDialog(String name, String age, int id, BuildContext ctx) {
    // AlertDialog(
    //   title: Text("Update $name"),
    // );
    final newNameController = TextEditingController();
    final newAgeController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    newNameController.text = name;
    newAgeController.text = age;
    showDialog(
        context: ctx,
        builder: (ctx) {return AlertDialog(content: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return "Enter Name";
                          }
                        },
                        controller: newNameController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Enter Name"),
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
                        controller: newAgeController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Enter Age"),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: ()async {
                            await updateStudentSQL(newNameController.text, newAgeController.text, id);
                            Navigator.of(ctx).pop();
                          },
                          child:const Text("Update"), 
                          style: const ButtonStyle(),
                        ),
                      )
                    ],))
                );
         
        });
  }
}

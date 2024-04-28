import 'package:flutter/material.dart';
import 'package:sqlite_app/model/students.dart';
import 'package:sqlite_app/vm/database_handler.dart';

class insertStudents extends StatefulWidget {
  const insertStudents({super.key});

  @override
  State<insertStudents> createState() => _insertStudentsState();
}

class _insertStudentsState extends State<insertStudents> {
  late DatabaseHandler handler;
  late TextEditingController codeController;
  late TextEditingController nameController;
  late TextEditingController deptController;
  late TextEditingController phoneController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    handler = DatabaseHandler();
    codeController = TextEditingController();
    nameController = TextEditingController();
    deptController = TextEditingController();
    phoneController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('insert for SQLite'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: codeController,
              decoration: const InputDecoration(labelText: '학번을 입력 하세요'),
            ),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: '이름을 입력 하세요'),
            ),
            TextField(
              controller: deptController,
              decoration: const InputDecoration(labelText: '전공을 입력 하세요'),
            ),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(labelText: '전화번호를 입력 하세요'),
            ),
            ElevatedButton(
              onPressed: () => insertAction(),
              child: const Text('입력'),
            ),
          ],
        ),
      ),
    );
  }

  //functions
  insertAction() async {
    Students students = Students(
        code: codeController.text,
        name: nameController.text,
        dept: deptController.text,
        phone: phoneController.text); //생성

    await handler.insertStudents(students); //넣어준다.
    _showDialog();
  }

  _showDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('입력 결과'),
            content: const Text('입력이 완료 되었습니다.'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.pop(context);
                  },
                  child: const Text('OK'))
            ],
          );
        });
  }
}//end

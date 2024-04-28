import 'package:flutter/material.dart';

import '../model/students.dart';
import '../vm/database_handler.dart';

class UpdateStudents extends StatefulWidget {
  final String code;
  final String name;
  final String dept;
  final String phone;

  const UpdateStudents(
      {super.key,
      required this.code,
      required this.name,
      required this.dept,
      required this.phone});

  @override
  State<UpdateStudents> createState() => _UpdateStudentsState();
}

class _UpdateStudentsState extends State<UpdateStudents> {
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

    codeController.text = widget.code;
    nameController.text = widget.name;
    deptController.text = widget.dept;
    phoneController.text = widget.phone;
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
              readOnly: true,
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
              onPressed: () => updateAction(),
              child: const Text('수정'),
            ),
          ],
        ),
      ),
    );
  }

  //functions
  updateAction() async {
    Students students = Students(
        code: codeController.text,
        name: nameController.text,
        dept: deptController.text,
        phone: phoneController.text); //생성

    await handler.updateStudents(students); //넣어준다.
    _showDialog();
  }

  _showDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('수정 결과'),
            content: const Text('수정이 완료 되었습니다.'),
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

//   // @override
//   // Widget build(BuildContext context) {
//   //   return const Placeholder();
//   // }
// }

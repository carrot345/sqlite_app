import 'package:flutter/material.dart';
import 'package:sqlite_app/view/insert_students.dart';
import 'package:sqlite_app/view/update_students.dart';
import 'package:sqlite_app/vm/database_handler.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late DatabaseHandler handler;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    handler = DatabaseHandler();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SQLite for Students'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const insertStudents(),
                  ),
                ).then((value) => reloadData());
              },
              icon: const Icon(Icons.add_outlined))
        ],
      ),
      body: FutureBuilder(
          //데이터 가져와서 메모리에 넣는다.
          future: handler.queryStudents(), //hanler db를 불러온다.
          builder: (context, snapshot) {
            //데이타가 있는지 없는지 아는애가 snapshot이다.
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return UpdateStudents(
                              code: snapshot.data![index].code,
                              name: snapshot.data![index].name,
                              dept: snapshot.data![index].dept,
                              phone: snapshot.data![index].phone);
                        }),
                      ).then((value) => reloadData());
                    },
                    child: Card(
                      child: Column(
                        children: [
                          Text("Code: ${snapshot.data![index].code}"),
                          Text("Name: ${snapshot.data![index].name}"),
                          Text("Dept: ${snapshot.data![index].dept}"),
                          Text("Phone: ${snapshot.data![index].phone}")
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }), //담아둔다.
    );
  }

  //functions
  reloadData() {
    handler.queryStudents();
    setState(() {});
  }
}//end

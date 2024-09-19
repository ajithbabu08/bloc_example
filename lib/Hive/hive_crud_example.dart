import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('myapp_box');
  runApp(MaterialApp(
    home: HiveCrudExample(),
  ));
}

class HiveCrudExample extends StatefulWidget {
  const HiveCrudExample({super.key});

  @override
  State<HiveCrudExample> createState() => _HiveCrudExampleState();
}

class _HiveCrudExampleState extends State<HiveCrudExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hive New Example'),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () => showbottomtab(context, null),
          icon: Icon(Icons.add),
          label: Text('Add Task')),
      body: titlelist.isEmpty
          ? Center(
              child: CircleAvatar(),
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(titlelist[index]['titlename']),
                );
              },
              itemCount: titlelist.length,
            ),
    );
  }

  TextEditingController titlecontroller = TextEditingController();
  List<Map<String, dynamic>> titlelist = [];

  final databox = Hive.box('myapp_box');

  //load data when the page displays
  @override
  void initState() {
    loadTask();
    super.initState();
  }

  //function displayin bottomsheet which pops up when the user clicks on add new task

  void showbottomtab(BuildContext context, int? itemkey) {
    if (itemkey != null) {
      final alltasks =
          titlelist.firstWhere((element) => element['id'] == itemkey);
      titlecontroller.text = alltasks['titlename'];
    }
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(25.0),
            child: Container(
              child: Column(
                children: [
                  TextField(
                    controller: titlecontroller,
                    decoration: InputDecoration(
                        hintText: "Title",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (titlecontroller.text != '') {
                          if (itemkey == null) {
                        addNewTask({'titlename': titlecontroller.text.trim()});

                          }
                        }
                        Navigator.pop(context);
                      },
                      child: Text('Save'))
                ],
              ),
            ),
          );
        });
  }

  //function for adding data into hive box, databox is the variable which contains hivebox
  Future<void> addNewTask(Map<String, dynamic> titlelist) async {
    print('new task added');
    await databox.add(titlelist);
    loadTask();
  }

  //function for loading data added
  void loadTask() {
    final taskloaded = databox.keys.map((key) {
      final value = databox.get(key);
      return {'id': key, 'titlename': value['titlename']};
    }).toList();
    setState(() {
      titlelist = taskloaded.reversed.toList();
    });
  }
}

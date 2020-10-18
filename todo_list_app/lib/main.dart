import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To do list',
      home: MyHome(),
    );
  }
}

class MyHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyHomeState();
  }
}

class MyHomeState extends State<MyHome> {
  final TextEditingController taskController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<String> _tasks = List();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do list'),
        backgroundColor: Colors.black87,
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Form(
                key: _formKey,
                child: Row(
                  children: [
                    Expanded(
                        child: TextFormField(
                      controller: taskController,
                      style: TextStyle(fontSize: 28, color: Colors.black87),
                      decoration: InputDecoration(
                          hintText: 'Type a new task',
                          hintStyle: TextStyle(fontSize: 20)),
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value.trim().isEmpty) {
                          return 'Task field is required';
                        }
                        return null;
                      },
                    )),
                    Container(
                        margin: EdgeInsets.only(left: 20),
                        child: RaisedButton(
                            child: Text(
                              '+',
                              style: TextStyle(fontSize: 20),
                            ),
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                setState(() {
                                  _tasks.add(taskController.text);
                                });
                                taskController.clear();
                              }
                            },
                            color: Colors.lightGreen[800],
                            textColor: Colors.white))
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: _tasks.length,
                  itemBuilder: (context, index) {
                    return Card(
                        child: Row(children: [
                      Expanded(
                        child: ListTile(title: Text(_tasks[index])),
                      ),
                      Container(
                        child: RaisedButton(
                          child: Text(
                            '-',
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {
                            print('remove ${_tasks[index]}');
                            setState(() {
                              _tasks.removeAt(index);
                            });
                          },
                          color: Colors.white,
                          textColor: Colors.deepOrange,
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 0),
                        margin: EdgeInsets.only(right: 10),
                        width: 50,
                      )
                    ]));
                  }),
            )
          ],
        ),
      ),
    );
  }
}

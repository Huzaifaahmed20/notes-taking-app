import 'package:flutter/material.dart';
import './services/todo_services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todoService = TodoServices();

  TextEditingController _titleController = TextEditingController();

  Widget buildTextField() {
    return TextField(
      controller: _titleController,
      decoration: InputDecoration(border: OutlineInputBorder()),
    );
  }

  void openBottomDialog() {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                  top: 10,
                  left: 10,
                  right: 10,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: buildTextField()),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: RaisedButton(
                        child: Text('Add'),
                        onPressed: () {
                          if (_titleController.text.isNotEmpty) {
                            setState(() {
                              todoService.addTodos(_titleController.text);
                            });
                            Navigator.of(context).pop();
                            _titleController.clear();
                          }
                        }),
                  )
                ],
              ),
            ),
          );
        });
  }

  void showUpdatePopup(int index) {
    showDialog(
        context: context,
        builder: (context) {
          _titleController.text = todoService.todos[index].title;
          return AlertDialog(
            title: Text('Edit note!'),
            content: buildTextField(),
            actions: <Widget>[
              FlatButton(
                child: new Text('CANCEL'),
                onPressed: () {
                  Navigator.of(context).pop();
                  _titleController.clear();
                },
              ),
              FlatButton(
                child: new Text('UPDATE'),
                onPressed: () {
                  setState(() {
                    todoService.updateTodo(index, _titleController.text);
                  });
                  Navigator.of(context).pop();
                  _titleController.clear();
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton.extended(
          label: Text('Add'),
          icon: Icon(Icons.add),
          backgroundColor: Colors.blue,
          onPressed: () => openBottomDialog()),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            'My Notes',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w700, fontSize: 25),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: todoService.todos.length,
        itemBuilder: (ctx, index) => Padding(
          padding: const EdgeInsets.all(15),
          child: Card(
            elevation: 5,
            child: ListTile(
              title: Text(todoService.todos[index].title),
              subtitle: Text(
                '${todoService.todos[index].createdAt}',
                softWrap: false,
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () => showUpdatePopup(index)),
                  IconButton(
                      icon: Icon(Icons.delete),
                      color: Colors.red,
                      onPressed: () {
                        setState(() {
                          todoService.removeTodo(index);
                        });
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

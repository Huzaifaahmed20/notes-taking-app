import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool cardPressed = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              'My Notes',
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 25),
            ),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: cardPressed
                  ? Row(
                      children: <Widget>[
                        IconButton(
                            icon: Icon(
                              Icons.edit,
                              color: Colors.purple,
                            ),
                            onPressed: () {}),
                        IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            onPressed: () {})
                      ],
                    )
                  : IconButton(
                      icon: Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                      onPressed: () {}),
            )
          ],
        ),
        body: Container(
          padding: EdgeInsets.all(15),
          child: GridView.builder(
            itemCount: 20,
            gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  if (cardPressed) {
                    setState(() {
                      cardPressed = false;
                    });
                  }
                },
                onLongPress: () {
                  setState(() {
                    cardPressed = true;
                  });
                },
                child: Card(
                  elevation: 5.0,
                  child: new Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(width: 4.0, color: Colors.purple),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: new Text('Item $index'),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

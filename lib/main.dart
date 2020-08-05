import 'dart:html';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

void main() {
  runApp(TextFieldWebDemo());
}

class TextFieldWebDemo extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TextFieldWebDemo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(
          title: 'Text Field Web Demo (Press Button to add 20 rows)'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String viewID = "test-html";
  int numOfRows = 20;

  @override
  void initState() {
    super.initState();
    ui.platformViewRegistry.registerViewFactory(
      viewID,
      (int id) => IFrameElement()
          ..style.border = 'none'
          ..src = './assets/test.html');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Scrollbar(
          child: HtmlElementView(
                viewType: 'test-html',
              ),
        ),
      );
        // body: Scrollbar(
        //     child: ListView.builder(
        //   itemCount: numOfRows,
        //   itemBuilder: (BuildContext context, int index) {
        //     if (index % 5 == 0)
        //       return Divider(
        //         height: 20,
        //         thickness: 2,
        //         color: Colors.red,
        //       );
        //     return Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //       children: [
        //         Padding(
        //             padding: const EdgeInsets.symmetric(horizontal: 24),
        //             child: Container(
        //                 width: 50,
        //                 child: Text(
        //                   index.toString(),
        //                   textAlign: TextAlign.center,
        //                 ))),
        //         Expanded(
        //             child: Padding(
        //           padding: const EdgeInsets.symmetric(horizontal: 12),
        //           child: TextField(
        //             decoration: InputDecoration(
        //                 border: OutlineInputBorder(), labelText: 'Test1'),
        //             maxLines: null,
        //           ),
        //         )),
        //         Expanded(
        //             child: Padding(
        //           padding: const EdgeInsets.symmetric(horizontal: 12),
        //           child: TextField(
        //             decoration: InputDecoration(
        //                 border: OutlineInputBorder(), labelText: 'Test2'),
        //             maxLines: null,
        //           ),
        //         )),
        //         Expanded(
        //             child: Padding(
        //           padding: const EdgeInsets.symmetric(horizontal: 12),
        //           child: TextField(
        //             decoration: InputDecoration(
        //                 border: OutlineInputBorder(), labelText: 'Test3'),
        //             maxLines: null,
        //           ),
        //         )),
        //       ],
        //     );
        //   },
        // )),
        // floatingActionButton: FloatingActionButton(
        //     onPressed: () {
        //       setState(() {
        //         numOfRows = numOfRows + 20;
        //       });
        //     },
        //     child: Icon(Icons.add)));
  }
}

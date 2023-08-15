import 'dart:async';

import 'package:flutter/material.dart';

class streem extends StatefulWidget {
  const streem({super.key});

  @override
  State<streem> createState() => _streemState();
}

class _streemState extends State<streem> {
  @override
  Widget build(BuildContext context) {
    StreamController<int> streamController = StreamController<int>();
    streamController.addStream(gen().generateNumbers);
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
            child: Column(
          children: [
            ElevatedButton(
                onPressed: () async {
                  streamController.addStream(gen().generateNumbers);
                },
                child: Text("subscribe")),
            StreamBuilder<int>(
              stream: streamController.stream,
              initialData: 100,
              builder: (context, snapshot) {
                return Text(snapshot.data.toString());
              },
            )
          ],
        )),
      ),
    );
  }
}

class gen {
  Stream<int> generateNumbers = (() async* {
    for (int i = 1; i <= 10; i++) {
      await Future<void>.delayed(Duration(seconds: 1));
      yield i;
    }
  })();

  void getstream() {
    generateNumbers;
  }
}

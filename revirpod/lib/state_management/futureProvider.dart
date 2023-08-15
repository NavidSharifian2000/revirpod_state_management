import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

bool ex = false;

class posts extends ConsumerWidget {
  posts({super.key});

  final postsprovider = FutureProvider<List<String>>((ref) async {
    await Future.delayed(Duration(seconds: 5));
    if (ex == false) {
      ex = false;
      return ["navid", "ali"];
    } else {
      ex = true;
      return ["ali", "navid"];
    }
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var posts = ref.watch(postsprovider);
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
            child: Column(
          children: [
            if (posts.isRefreshing) ...{CircularProgressIndicator()},
            posts.when(data: ((data) {
              return Text(data[0].toString());
            }), error: (Object error, StackTrace stackTrace) {
              return Text(error.toString());
            }, loading: () {
              return CircularProgressIndicator();
            }),
            ElevatedButton(
                onPressed: () {
                  ref.refresh(postsprovider);
                },
                child: Text("refresh"))
          ],
        )),
      ),
    );
  }
}

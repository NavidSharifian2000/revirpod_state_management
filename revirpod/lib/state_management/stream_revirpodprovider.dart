import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class streamriverpod extends ConsumerWidget {
  streamriverpod({super.key});
  final counterprovider = StreamProvider<int>((ref) async* {
    for (int i = 1; i <= 10; i++) {
      await Future<void>.delayed(Duration(seconds: 1));
      yield i;
    }
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final adad = ref.watch(counterprovider);
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
            child: Column(
          children: [
            adad.when(data: (data) {
              return Text(data.toString());
            }, error: (error, StackTrace) {
              return Text(error.toString());
            }, loading: () {
              return CircularProgressIndicator();
            }),
            ElevatedButton(
                onPressed: () {
                  ref.refresh(counterprovider);
                },
                child: Text("press"))
          ],
        )),
      ),
    );
  }
}

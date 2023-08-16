import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:revirpod/state_management/Fruit_state.dart';
import 'package:revirpod/state_management/futureProvider.dart';
import 'package:revirpod/state_management/stream_revirpodprovider.dart';
import 'package:revirpod/state_management/streamcoin.dart';
import 'package:revirpod/state_management/streems.dart';
import 'package:riverpod/riverpod.dart';

void main() {
  runApp(ProviderScope(child: coinstream()));
}

class MyApp extends ConsumerWidget {
  MyApp({super.key});
  final frutsProvider =
      StateNotifierProvider<FruitsNotifier, fruitState>((ref) {
    return FruitsNotifier();
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var fruits = ref.watch(frutsProvider);
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
            child: Column(
          children: [
            if (fruits is fruitinitstate) ...{
              Text(fruits.miveha![0].toString())
            },
            if (fruits is fruitloadingstate) ...{CircularProgressIndicator()},
            if (fruits is fruitsuccess) ...{Text(fruits.fruits[0].toString())},
            Center(
              child: Text("navid"),
            ),
            ElevatedButton(
                onPressed: () {
                  ref.read(frutsProvider.notifier).state = fruitloadingstate();
                },
                child: Text("press"))
          ],
        )),
      ),
    );
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';

class FruitsNotifier extends StateNotifier<fruitState> {
  FruitsNotifier() : super(fruitinitstate());

  void changestate() async {
    state = fruitloadingstate();
    await Future.delayed(Duration(seconds: 5));
    state = fruitsuccess(["sib", "moz"]);
  }
}

//states
abstract class fruitState {}

class fruitinitstate extends fruitState {
  List<String>? miveha = ["nist"];
}

class fruitloadingstate extends fruitState {}

class fruitsuccess extends fruitState {
  List<String> fruits;
  fruitsuccess(this.fruits);
}

//events
abstract class fruitEvent {}

class fruitadd extends fruitEvent {}

import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

class coinstream extends ConsumerWidget {
  coinstream({super.key});

  @override
  final providerofsocket = StreamProvider.autoDispose((ref) async* {
    StreamController stream = StreamController();
    var socket = new SocketService.initial();
    socket.socket!.on("Broadcaster", (data) {
      stream.add(data);
    });

    //  socket.socket!.on("Broadcaster", (data) {
    //     log(data);
    //     stream.add(data);
    //   });
    await for (final value in stream.stream) {
      print(value[1]["timestamp"]);
      yield value;
    }
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var data2 = ref.watch(providerofsocket);
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              data2.when(data: (data) {
                return Text(data[1]["timestamp"].toString());
              }, error: (error, stacktTrace) {
                return Text("error");
              }, loading: () {
                return CircularProgressIndicator();
              }),
              ElevatedButton(onPressed: () {}, child: Text("press"))
            ],
          ),
        ),
      ),
    );
  }
}

class SocketService {
  IO.Socket? socket;
  SocketService.initial() {
    socket = IO.io(
        'https://api.wallex.ir/',
        OptionBuilder().setTransports(['websocket']) // for Flutter or Dart VM
            .build());
    socket!.connect();
    socket!.onConnect((data) {
      print("connected");
    });
    socket!.emit('subscribe', {"channel": "USDTTMN@trade"});
  }
}

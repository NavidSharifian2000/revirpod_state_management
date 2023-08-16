import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

class coinstream extends StatelessWidget {
  coinstream({super.key});
  IO.Socket? socket;

  @override
  Widget build(BuildContext context) {
    socket = IO.io(
        'https://api.wallex.ir/',
        OptionBuilder().setTransports(['websocket']) // for Flutter or Dart VM
            .build());
    socket!.onConnect((_) {
      print('connected');
    });
    socket!.onConnectError((data) => {print(data.toString())});
    socket!.connect();
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: [Text("navid")],
          ),
        ),
      ),
    );
  }
}

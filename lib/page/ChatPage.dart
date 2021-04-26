import 'dart:io';

import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart';

class ChatPage extends StatefulWidget {

  @override
  ChatPageState createState() => ChatPageState();
}

class ChatPageState extends State<ChatPage> {

  Socket socket;

  List EVENTS = [
    'connect',
    'connect_error',
    'connect_timeout',
    'connecting',
    'disconnect',
    'error',
    'reconnect',
    'reconnect_attempt',
    'reconnect_failed',
    'reconnect_error',
    'reconnecting',
    'new message',
    'add user'
  ];

  @override
  void initState() {
    _connectServer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.pinkAccent,
      ),
    );
  }

  _connectServer(){
    demonstrateSocket().then((_) => {
      socket.on('login', (data) => {
        print('onLogin : ${data}'),
      }),
      socket.on('connection', (data) => {
        print('connection : ${data}'),
      }),
      socket.on('connect_error', (data) => {
        print('connect_error : ${data}'),
      }),
      socket.on('connect_timeout', (data) => {
        print('connect_timeout : ${data}'),
      }),
      socket.on('connecting', (data) => {
        print('connecting : ${data}'),
      }),
      socket.emit('add user', 'Tum'),
    },
    );
  }

  Future<void> demonstrateSocket() async {
    // Create a socket instance
    socket = await io('http://10.98.13.42:3000');
  }

  @override
  void dispose() {
    // ignore: unnecessary_statements
    socket.disconnected;
    super.dispose();
  }
}
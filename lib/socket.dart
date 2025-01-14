import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class Socket extends StatefulWidget {
  const Socket({Key? key}) : super(key: key);

  @override
  State<Socket> createState() => _SocketState();
}

class _SocketState extends State<Socket> {



  final TextEditingController _controller = TextEditingController();
  final _channel = WebSocketChannel.connect(
    Uri.parse('ws://192.168.136.229:8080/audio/read_audio'),
  );

  @override
  Widget build(BuildContext context) {
    return 

      Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              child: TextFormField(
                controller: _controller,
                decoration: const InputDecoration(labelText: 'Send a message'),
              ),
            ),
            const SizedBox(height: 24),
            StreamBuilder(
              stream: _channel.stream,
              builder: (context, snapshot) {
                return Text(snapshot.hasData ? '${snapshot.data}' : '');
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _sendMessage,
        tooltip: 'Send message',
        child: const Icon(Icons.send),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      _channel.sink.add(_controller.text);
    }
  }

  @override
  void dispose() {
    // _channel.sink.close();
    _controller.dispose();
    super.dispose();
  }

  
}

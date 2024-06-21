
// chat_screen.dart
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  final String doctorName;

  const ChatScreen({super.key, required this.doctorName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          doctorName,
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.call, color:Color.fromRGBO(11, 143, 172, 1.0)),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.videocam, color:Color.fromRGBO(11, 143, 172, 1.0)),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                _buildMessageTile('Dr. Jesús', '¿Presenta algún dolor?', true),
                _buildMessageTile('Tú', 'El dolor sigue cada vez que me acuesto', false),
                _buildMessageTile('Dr. Jesús', '¿Está tomando las pastillas para el dolor?', true),
                _buildMessageTile('Tú', 'Estoy siguiendo con base en la receta', false),
                _buildMessageTile('Dr. Jesús', 'Entiendo, en un momento le llamo', true),
                _buildMessageTile('Tú', 'Entendido doc', false),
                _buildMessageTile('Dr. Jesús', 'Deme 5 min. Para la llamada', true),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.mic, color:Color.fromRGBO(11, 143, 172, 1.0)),
                  onPressed: () {},
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Escribe aquí',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.camera_alt, color:Color.fromRGBO(11, 143, 172, 1.0)),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.send, color:Color.fromRGBO(11, 143, 172, 1.0)),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageTile(String sender, String message, bool isDoctor) {
    return Align(
      alignment: isDoctor ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: isDoctor ? Colors.grey[200] : Color.fromRGBO(11, 143, 172, 1.0),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              sender,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isDoctor ? Colors.black :Color.fromRGBO(255, 254, 254, 0.935),
                fontSize: 18,
              ),
            ),
            SizedBox(height: 5),
            Text(
              message,
              style: TextStyle(
              color: isDoctor ? Colors.black : Colors.white, 
              fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

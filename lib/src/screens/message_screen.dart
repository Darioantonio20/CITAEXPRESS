// message_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/screens/chat_screen.dart';

class MessageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mensajes', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Buscar un doctor',
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                CircleAvatar(radius: 30, backgroundColor: Colors.grey),
                SizedBox(width: 10),
                CircleAvatar(radius: 30, backgroundColor: Colors.grey),
                SizedBox(width: 10),
                CircleAvatar(radius: 30, backgroundColor: Colors.grey),
                SizedBox(width: 10),
                CircleAvatar(radius: 30, backgroundColor: Colors.grey),
                SizedBox(width: 10),
                CircleAvatar(radius: 30, backgroundColor: Colors.grey),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildDoctorTile(context, 'Dr. Cristian', 'Lorem consectetur adipiscing elit.', '12:50'),
                _buildDoctorTile(context, 'Dr. Francisco', 'Lorem consectetur adipiscing elit.', '12:50'),
                _buildDoctorTile(context, 'Dr. Alana', 'Lorem consectetur adipiscing elit.', '12:50'),
                _buildDoctorTile(context, 'Dr. Jesús', 'Lorem consectetur adipiscing elit.', '12:50'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDoctorTile(BuildContext context, String name, String subtitle, String time) {
    return ListTile(
      leading: CircleAvatar(backgroundColor: Colors.grey),
      title: Text(name),
      subtitle: Text(subtitle),
      trailing: Text(time),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatScreen(doctorName: name),
          ),
        );
      },
    );
  }
}

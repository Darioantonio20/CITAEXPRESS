
// notifications_screen.dart
import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notificaciones', style: TextStyle(color:Color.fromRGBO(11, 143, 172, 1.0))),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color:Color.fromRGBO(11, 143, 172, 1.0)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nuevo', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: [
                  _buildNotificationItem('Junio 2024', '15 Min'),
                  _buildNotificationItem('Junio 2024', '15 Min'),
                  _buildNotificationItem('Junio 2024', '15 Min'),
                  _buildNotificationItem('Junio 2024', '15 Min'),
                  _buildNotificationItem('Junio 2024', '15 Min'),
                ],
              ),
            ),
            Center(
              child: TextButton(
                onPressed: () {
                  // Aquí puedes agregar la navegación a la pantalla de todas las notificaciones
                },
                child: Text('Ver todas', style: TextStyle(color:Color.fromRGBO(11, 143, 172, 1.0), fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationItem(String date, String time) {
    return ListTile(
      leading: Icon(Icons.notifications, color:Color.fromRGBO(11, 143, 172, 1.0)),
      title: Text(date),
      subtitle: Text('Lorem ipsum dolor sit amet, adipiscing elit.'),
      trailing: Text(time),
      onTap: () {
        // Aquí puedes agregar la acción a realizar al hacer clic en la notificación
      },
    );
  }
}

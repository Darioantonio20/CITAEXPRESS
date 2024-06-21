import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/screens/notifications_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil', style: TextStyle(color: Color.fromRGBO(11, 143, 172, 1.0))),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Color.fromRGBO(11, 143, 172, 1.0)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey,
            ),
            SizedBox(height: 10),
            Text('Samuel Escobar', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            _buildProfileOption(context, Icons.notifications, 'Notificaciones', () {
              // Navega a NotificationsScreen cuando se toca "Notificaciones"
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationsScreen()),
              );
            }),
            _buildProfileOption(context, Icons.person, 'Detalles personales', () {}),
            _buildProfileOption(context, Icons.location_on, 'Ubicación', () {}),
            _buildProfileOption(context, Icons.payment, 'Método de pago', () {}),
            _buildProfileOption(context, Icons.settings, 'Configuración', () {}),
            _buildProfileOption(context, Icons.help, 'Ayuda', () {}),
            _buildProfileOption(context, Icons.exit_to_app, 'Salir', () {}),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileOption(BuildContext context, IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Color.fromRGBO(11, 143, 172, 1.0)),
      title: Text(title),
      trailing: Icon(Icons.arrow_forward_ios, color: Color.fromRGBO(11, 143, 172, 1.0)),
      onTap: onTap,
    );
  }
}
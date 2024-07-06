// profile_screen.dart
import 'package:flutter_application_1/src/screens/notifications_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String nombreUsuario = 'Cargando...';

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    const url = 'http://52.44.178.25:8080/api/user'; // URL para obtener los datos del usuario

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        setState(() {
          nombreUsuario = responseBody['nombre'];
        });
      } else {
        print('Error al obtener datos del usuario: ${response.body}');
      }
    } catch (e) {
      print('Error en la solicitud: $e');
    }
  }

  void _showPersonalDetailsAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Detalles personales'),
          content: Text('¿Desea cambiar los campos de su registro?'),
          actions: [
            TextButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Sí'),
              onPressed: () {
                Navigator.of(context).pop();
                // Navegar a la vista de edición de detalles personales
              },
            ),
          ],
        );
      },
    );
  }

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
            Text(nombreUsuario, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            _buildProfileOption(context, Icons.notifications, 'Notificaciones', () {
              // Navega a NotificationsScreen cuando se toca "Notificaciones"
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationsScreen()),
              );
            }),
            _buildProfileOption(context, Icons.person, 'Detalles personales', _showPersonalDetailsAlert),
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
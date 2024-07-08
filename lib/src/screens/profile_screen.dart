// profile_screen.dart
import 'package:flutter_application_1/src/screens/notifications_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  String nombreUsuario = 'Cargando...';

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    if (token != null) {
      final parts = token.split('.');
      if (parts.length != 3) {
        print('El token no es válido');
        return;
      }

      final payload = json.decode(utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))));
      final String uid = payload['uid'];

      final url = 'http://52.44.178.25:8080/api/user/$uid'; // Asegúrate de reemplazar 52.44.178.25 por la IP adecuada si es necesario

      try {
        final response = await http.get(Uri.parse(url), headers: {
          'Authorization': 'Bearer $token', // Asegúrate de enviar el token en la cabecera si es necesario
        });
        if (response.statusCode == 200) {
          final responseBody = jsonDecode(response.body);
          setState(() {
            nombreUsuario = responseBody['nombre']; // Asegúrate de que el campo 'nombre' exista en la respuesta
          });
        } else {
          print('Error al obtener datos del usuario: ${response.body}');
        }
      } catch (e) {
        print('Error en la solicitud: $e');
      }
    } else {
      print('Token no encontrado');
    }
  }

   void _showPersonalDetailsAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Detalles personales'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Ingrese su nuevo nombre:'),
              TextField(
                controller: _nameController,
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Guardar'),
              onPressed: () async {
                Navigator.of(context).pop();
                await _updateUserName();
              },
            ),
          ],
        );
      },
    );
  }

Future<void> _updateUserName() async {
  final prefs = await SharedPreferences.getInstance();
  final String? token = prefs.getString('token');
  if (token != null) {
    final parts = token.split('.');
    if (parts.length != 3) {
      print('El token no es válido');
      return;
    }
    final payload = json.decode(utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))));
    final String uid = payload['uid'];
    final url = 'http://52.44.178.25:8080/api/user/$uid';
    try {
      final response = await http.put(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'nombre': _nameController.text}),
      );
      if (response.statusCode == 200) {
        print('Nombre actualizado con éxito');
        await _fetchUserData(); // Recargar los datos del usuario después de una actualización exitosa
      } else {
        print('Error al actualizar el nombre: ${response.body}');
      }
    } catch (e) {
      print('Error en la solicitud: $e');
    }
  } else {
    print('Token no encontrado');
  }
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
            _buildProfileOption(context, Icons.person, 'Cambiar nombre de usuario', _showPersonalDetailsAlert),
            
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
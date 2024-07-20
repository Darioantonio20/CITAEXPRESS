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
  final TextEditingController _providerNameController = TextEditingController();
  String nombreUsuarioYProveedor = 'Cargando...';
  String providerName = 'Cargando...';

  @override
  void initState() {
    super.initState();
    _fetchUserData();
    _fetchProviderData();
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

      final url = 'http://52.44.178.25:8080/api/user/$uid';

      try {
        final response = await http.get(Uri.parse(url), headers: {
          'Authorization': 'Bearer $token',
        });
        if (response.statusCode == 200) {
          final responseBody = jsonDecode(response.body);
          setState(() {
            nombreUsuarioYProveedor = responseBody['nombre'];
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

  Future<void> _fetchProviderData() async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    final String? providerId = prefs.getString('providerId');
    if (token != null && providerId != null) {
      final url = 'http://52.44.178.25:8080/api/providers/$providerId';

      try {
        final response = await http.get(Uri.parse(url), headers: {
          'Authorization': 'Bearer $token',
        });
        if (response.statusCode == 200) {
          final responseBody = jsonDecode(response.body);
          setState(() {
            providerName = responseBody['nameProvider'];
          });
        } else {
          print('Error al obtener datos del proveedor: ${response.body}');
        }
      } catch (e) {
        print('Error en la solicitud: $e');
      }
    } else {
      print('Token o providerId no encontrado');
    }
  }

  Future<void> _updateProviderName(String providerId) async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    if (token != null) {
      final url = 'http://52.44.178.25:8080/api/providers/$providerId';
      try {
        final response = await http.put(
          Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: jsonEncode({'nameProvider': _providerNameController.text}),
        );
        if (response.statusCode == 200) {
          print('Nombre del proveedor actualizado con éxito');
          await _fetchProviderData();
        } else {
          print('Error al actualizar el nombre del proveedor: ${response.body}');
        }
      } catch (e) {
        print('Error en la solicitud: $e');
      }
    } else {
      print('Token no encontrado');
    }
  }

  Future<void> _deleteProvider(String providerId) async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    if (token != null) {
      final url = 'http://52.44.178.25:8080/api/providers/$providerId';
      try {
        final response = await http.delete(
          Uri.parse(url),
          headers: {
            'Authorization': 'Bearer $token',
          },
        );
        if (response.statusCode == 200) {
          print('Proveedor eliminado con éxito');
        } else {
          print('Error al eliminar el proveedor: ${response.body}');
        }
      } catch (e) {
        print('Error en la solicitud: $e');
      }
    } else {
      print('Token no encontrado');
    }
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
          await _fetchUserData();
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

  Future<void> _deleteAccount() async {
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
        final response = await http.delete(
          Uri.parse(url),
          headers: {
            'Authorization': 'Bearer $token',
          },
        );
        if (response.statusCode == 200) {
          print('Cuenta eliminada con éxito');
          Navigator.of(context).pushReplacementNamed('/login');
        } else {
          print('Error al eliminar la cuenta: ${response.body}');
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

  void _showProviderDetailsAlert(String providerId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Detalles del proveedor'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Ingrese el nuevo nombre del proveedor:'),
              TextField(
                controller: _providerNameController,
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
                await _updateProviderName(providerId);
              },
            ),
          ],
        );
      },
    );
  }

  void _showDeleteAccountAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Eliminar cuenta'),
          content: Text('¿Está seguro de que desea eliminar su cuenta? Esta acción no se puede deshacer.'),
          actions: [
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Eliminar'),
              onPressed: () async {
                Navigator.of(context).pop();
                await _deleteAccount();
              },
            ),
          ],
        );
      },
    );
  }

  void _showDeleteProviderAlert(String providerId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Eliminar proveedor'),
          content: Text('¿Está seguro de que desea eliminar este proveedor? Esta acción no se puede deshacer.'),
          actions: [
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Eliminar'),
              onPressed: () async {
                Navigator.of(context).pop();
                await _deleteProvider(providerId);
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
            Text(nombreUsuarioYProveedor, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text(providerName, style: TextStyle(fontSize: 20)),
            SizedBox(height: 20),
            _buildProfileOption(context, Icons.notifications, 'Notificaciones', () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NotificationsScreen()),
              );
            }),
            _buildProfileOption(context, Icons.person, 'Cambiar nombre de usuario', _showPersonalDetailsAlert),
            _buildProfileOption(context, Icons.location_on, 'Ubicación', () {}),
            _buildProfileOption(context, Icons.payment, 'Método de pago', () {}),
            _buildProfileOption(context, Icons.settings, 'Configuración', () {}),
            _buildProfileOption(context, Icons.help, 'Ayuda', () {}),
            _buildProfileOption(context, Icons.exit_to_app, 'Eliminar cuenta', _showDeleteAccountAlert),
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

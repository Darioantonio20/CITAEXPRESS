import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _registerUser() async {
    final fullName = _fullNameController.text;
    final phone = _phoneController.text;
    final email = _emailController.text;
    final password = _passwordController.text;

    const url = 'http://10.0.2.2:8080/api/user/'; // Cambia esta URL según tu configuración

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'nombre': fullName,
          'numeroTel': phone,
          'correo': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        // Si el servidor devuelve una respuesta 200 OK, parsea el JSON
        final responseBody = jsonDecode(response.body);
        print('Registro exitoso: $responseBody');
        // Mostrar una alerta de éxito y redirigir a la vista de login
        _showAlertDialog('Registro exitoso', 'El usuario se registró correctamente.', true);
      } else {
        // Si el servidor no devuelve una respuesta 200 OK, lanza un error.
        print('Error en el registro: ${response.body}');
        // Mostrar una alerta de error
        _showAlertDialog('Error en el registro', 'Hubo un problema al registrar el usuario. Inténtalo de nuevo.', false);
      }
    } catch (e) {
      print('Error en la solicitud: $e');
      // Mostrar una alerta de error
      _showAlertDialog('Error en la solicitud', 'Hubo un problema con la solicitud. Inténtalo de nuevo.', false);
    }
  }

  void _showAlertDialog(String title, String message, bool success) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                if (success) {
                  Navigator.of(context).pushReplacementNamed('/login');
                }
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
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'REGISTRO',
                style: TextStyle(
                  color: Color(0xFF0B8FAC),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Llene el siguiente formulario',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _fullNameController,
                decoration: InputDecoration(
                  labelText: 'Nombre completo',
                  labelStyle: const TextStyle(color: Color.fromRGBO(11, 143, 172, 1.0)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color.fromRGBO(11, 143, 172, 1.0)),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  hintText: 'Ingrese su nombre completo',
                ),
                style: const TextStyle(color: Color.fromRGBO(11, 143, 172, 1.0)),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _phoneController,
                decoration: InputDecoration(
                  labelText: 'Número de teléfono',
                  labelStyle: const TextStyle(color: Color.fromRGBO(11, 143, 172, 1.0)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color.fromRGBO(11, 143, 172, 1.0)),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  hintText: 'Ingrese su número de teléfono',
                ),
                style: const TextStyle(color: Color.fromRGBO(11, 143, 172, 1.0)),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Correo',
                  labelStyle: const TextStyle(color: Color.fromRGBO(11, 143, 172, 1.0)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color.fromRGBO(11, 143, 172, 1.0)),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  hintText: 'Ingrese su correo',
                ),
                style: const TextStyle(color: Color.fromRGBO(11, 143, 172, 1.0)),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  labelStyle: const TextStyle(color: Color.fromRGBO(11, 143, 172, 1.0)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color.fromRGBO(11, 143, 172, 1.0)),
                    borderRadius: BorderRadius.circular(10.0)),
                  hintText: 'Ingrese su contraseña',
                  suffixIcon: const Icon(Icons.visibility_off),
                ),
                style: const TextStyle(color: Color.fromRGBO(11, 143, 172, 1.0)),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _registerUser();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(11, 143, 172, 1.0),
                  padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: const Text(
                  'Registrarse',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('¿Ya tienes una cuenta?'),
                  TextButton(
                    onPressed: () {
                      // Navegar a la vista de inicio de sesión
                      Navigator.of(context).pushNamed('/login');
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: const Color.fromRGBO(11, 143, 172, 1.0)),
                    child: const Text('Inicia sesión'),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/registerServiceProvider');
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: const Color.fromRGBO(11, 143, 172, 1.0)),            
                    child: const Text('¡Registrarte como proveedor de servicios!',
                      style: TextStyle(
                      fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ), 
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _loginUser() async {
    final email = _emailController.text;
    final password = _passwordController.text;

    const url = 'http://localhost:8080/api/auth/login'; // URL correcta

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'correo': email,
          'password': password,
        }),
      );
     
      if (response.statusCode == 200) {

       final responseBody = jsonDecode(response.body);
       final String token = responseBody['token'];

  // Obtén una instancia de SharedPreferences
        final prefs = await SharedPreferences.getInstance();

  // Guarda el token usando SharedPreferences
        await prefs.setString('token', token);
        // Si el servidor devuelve una respuesta 200 OK, parsea el JSON
       
        print('Inicio de sesión exitoso: $responseBody');
        // Mostrar una alerta de éxito y redirigir a la vista de home
        _showAlertDialog('Inicio de sesión exitoso', 'El usuario ha iniciado sesión correctamente.', true);
      } else {
        // Si el servidor no devuelve una respuesta 200 OK, lanza un error.
        print('Error en el inicio de sesión: ${response.body}');
        // Mostrar una alerta de error
        _showAlertDialog('Error', 'Usuario no registrado o verificar los campos.', false);
      }
    } catch (e) {
      print('Error en la solicitud: $e');
      // Mostrar una alerta de error
      _showAlertDialog('Error', 'Hubo un problema con la solicitud. Inténtalo de nuevo. $e', false);
    }
  }

  void _showAlertDialog(String title, String message, bool success) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Row(
          children: [
            Icon(
              success ? Icons.check_circle : Icons.error,
              color: success ? Colors.green : Colors.red,
            ),
            SizedBox(width: 10),
            Text(
              title,
              style: TextStyle(
                color: success ? Colors.green : Colors.red,
              ),
            ),
          ],
        ),
        content: Text(message),
        actions: [
          TextButton(
            child: Text(
              'OK',
              style: TextStyle(
                color: success ? Colors.green : Colors.red,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
              if (success) {
                Navigator.of(context).pushReplacementNamed('/home');
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
                'BIENVENIDO',
                style: TextStyle(
                  color: Color(0xFF0B8FAC),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Inicio sesión',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Llene el siguiente formulario',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Correo',
                  labelStyle: const TextStyle(color: Color.fromRGBO(11, 143, 172, 1.0)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color.fromRGBO(11, 143, 172, 1.0)),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  hintText: 'Ingrese su correo',
                ),
                style: const TextStyle(color: Color.fromRGBO(11, 143, 172, 1.0)), // Estilo del texto dentro del input
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
                style: const TextStyle(color: Color.fromRGBO(11, 143, 172, 1.0)), // Estilo del texto dentro del input
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    // Acción para olvidar contraseña
                  },
                  child: const Text(
                    'Olvide mi contraseña',
                    style: TextStyle(color: Color.fromRGBO(11, 143, 172, 1.0)),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _loginUser,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(11, 143, 172, 1.0),
                  padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: const Text(
                  'Iniciar sesión',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),
              const Text('ó', style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Image.network(
                      'https://upload.wikimedia.org/wikipedia/commons/5/51/Facebook_f_logo_%282019%29.svg',
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.error);
                      },
                    ),
                    iconSize: 40,
                    onPressed: () {
                      // Acción para iniciar sesión con Facebook
                    },
                  ),
                  const SizedBox(width: 20),
                  IconButton(
                    icon: Image.network(
                      'https://upload.wikimedia.org/wikipedia/commons/4/4f/Google_2015_logo.svg',
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.error);
                      },
                    ),
                    iconSize: 40,
                    onPressed: () {
                      // Acción para iniciar sesión con Google
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('No tengo una cuenta?'),
                  TextButton(
                    onPressed: () {
                      // Navegar a la vista de registro
                      Navigator.of(context).pushNamed('/register');
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Color.fromRGBO(11, 143, 172, 1.0),
                    ),
                    child: const Text('Registrarse'),
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
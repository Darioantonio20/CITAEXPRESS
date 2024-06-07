import 'package:flutter/material.dart';

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
                  color: Colors.teal,
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
                  labelStyle: TextStyle(color: Color.fromRGBO(11, 143, 172, 1.0)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromRGBO(11, 143, 172, 1.0),
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  hintText: 'Ingrese su nombre completo',
                ),
                style: TextStyle(color: Color.fromRGBO(11, 143, 172, 1.0)),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _phoneController,
                decoration: InputDecoration(
                  labelText: 'Número de teléfono',
                  labelStyle: TextStyle(color: Color.fromRGBO(11, 143, 172, 1.0)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromRGBO(11, 143, 172, 1.0),
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  hintText: 'Ingrese su número de teléfono',
                ),
                style: TextStyle(color: Color.fromRGBO(11, 143, 172, 1.0)),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Correo',
                  labelStyle: TextStyle(color: Color.fromRGBO(11, 143, 172, 1.0)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromRGBO(11, 143, 172, 1.0),
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  hintText: 'Ingrese su correo',
                ),
                style: TextStyle(color: Color.fromRGBO(11, 143, 172, 1.0)),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  labelStyle: TextStyle(color: Color.fromRGBO(11, 143, 172, 1.0)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromRGBO(11, 143, 172, 1.0),
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  hintText: 'Ingrese su contraseña',
                  suffixIcon: const Icon(Icons.visibility_off),
                ),
                style: TextStyle(color: Color.fromRGBO(11, 143, 172, 1.0)),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Acción para registrarse
                  final fullName = _fullNameController.text;
                  final phone = _phoneController.text;
                  final email = _emailController.text;
                  final password = _passwordController.text;
                  print('Nombre: $fullName, Teléfono: $phone, Correo: $email, Contraseña: $password');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(11, 143, 172, 1.0),
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
                      foregroundColor: Color.fromRGBO(11, 143, 172, 1.0),
                    ),
                    child: const Text('Inicia sesión'),
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

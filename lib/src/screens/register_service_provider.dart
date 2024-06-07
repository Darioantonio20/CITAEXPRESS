import 'package:flutter/material.dart';

class RegisterServiceProvider extends StatefulWidget {
  const RegisterServiceProvider({super.key});

  @override
  _RegisterServiceProviderState createState() => _RegisterServiceProviderState();
}

class _RegisterServiceProviderState extends State<RegisterServiceProvider> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _serviceController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _serviceController.dispose();
    _locationController.dispose();
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
            crossAxisAlignment: CrossAxisAlignment.center, // Centrar el contenido
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Center(
                child: Text(
                  'REGISTRO DE PROVEEDOR DE SERVICIOS',
                  style: TextStyle(
                    color: Colors.teal,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
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
                      color: Color.fromRGBO(11, 143, 172, 1.0),
                    ),
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
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color.fromRGBO(11, 143, 172, 1.0),
                    ),
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
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color.fromRGBO(11, 143, 172, 1.0),
                    ),
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
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color.fromRGBO(11, 143, 172, 1.0),
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  hintText: 'Ingrese su contraseña',
                  suffixIcon: const Icon(Icons.visibility_off),
                ),
                style: const TextStyle(color: Color.fromRGBO(11, 143, 172, 1.0)),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _serviceController,
                decoration: InputDecoration(
                  labelText: 'Servicio',
                  labelStyle: const TextStyle(color: Color.fromRGBO(11, 143, 172, 1.0)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color.fromRGBO(11, 143, 172, 1.0),
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  hintText: 'Ingrese el servicio',
                ),
                style: const TextStyle(color: Color.fromRGBO(11, 143, 172, 1.0)),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _locationController,
                decoration: InputDecoration(
                  labelText: 'Ubicación',
                  labelStyle: const TextStyle(color: Color.fromRGBO(11, 143, 172, 1.0)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color.fromRGBO(11, 143, 172, 1.0)),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  hintText: 'Ingrese la ubicación',
                ),
                style: const TextStyle(color: Color.fromRGBO(11, 143, 172, 1.0)),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Acción para registrarse
                  final fullName = _fullNameController.text;
                  final phone = _phoneController.text;
                  final email = _emailController.text;
                  final password = _passwordController.text;
                  final service = _serviceController.text;
                  final location = _locationController.text;
                  print('Nombre: $fullName, Teléfono: $phone, Correo: $email, Contraseña: $password, Servicio: $service, Ubicación: $location');
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
                      Navigator.of(context).pushNamed('/');
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: const Color.fromRGBO(11, 143, 172, 1.0),
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

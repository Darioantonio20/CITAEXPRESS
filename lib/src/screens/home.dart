import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {
  String userName = 'Cargando...'; // Valor inicial mientras se carga el nombre

  @override
  void initState() {
    super.initState();
    _fetchUserName();
  }


@override
void didChangeDependencies() {
  super.didChangeDependencies();
  _fetchUserName(); // Llama a _fetchUserName cada vez que las dependencias cambian
}


  Future<void> _fetchUserName() async {
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
          final data = json.decode(response.body);
          setState(() {
            userName = data['nombre']; // Actualiza el nombre del usuario
          });
        } else {
          print('Error al obtener el nombre del usuario: ${response.body}');
        }
      } catch (e) {
        print('Error en la solicitud: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {

  WidgetsBinding.instance.addPostFrameCallback((_) {
    if (ModalRoute.of(context)?.isCurrent == true) {
      _fetchUserName(); // Se asegura de llamar a _fetchUserName solo si la pantalla está actualmente visible
    }
  }); 
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(160.0),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: false,
          flexibleSpace: Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.grey[300],
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Hola', style: TextStyle(fontSize: 18, color: Colors.black)),
                          Text(userName, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black)),
                        ],
                      ),
                      Spacer(),
                      IconButton(
                        icon: Icon(Icons.notifications, color: Colors.black),
                        onPressed: () {
                          Navigator.pushNamed(context, '/notifications');
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search, color: Colors.teal),
                      hintText: 'Buscar',
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(11, 143, 172, 1.0),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('CITAEXPRESS',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: const Color.fromARGB(255, 248, 248, 248))),
                          SizedBox(height: 8),
                          Text(
                              '¡Ahorra tiempo, encuentra servicios y evita filas con nuestra app!',
                              style: TextStyle(color: const Color.fromARGB(255, 225, 226, 226))),
                        ],
                      ),
                    ),
                    Container(
                      width: 60,
                      height: 60,
                      color: Colors.grey[300], 
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Text('Servicios', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
             Container(
                height: 100, 
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildServiceButton(context, 'Salud'),
                    _buildServiceButton(context, 'Belleza y Bienestar'),
                    _buildServiceButton(context, 'Servicios Profesional'),
                    _buildServiceButton(context, 'Educación y Capacitación'),
                    _buildServiceButton(context, 'Reparación y Mantenimiento'),
                    _buildServiceButton(context, 'Ocio y Entretenimiento'),
                    _buildServiceButton(context, 'Inmobiliario'),
                    _buildServiceButton(context, 'Atención al Cliente'),
                    _buildServiceButton(context, 'Otros'),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Todos los doctores', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/all_items'); 
                    },
                    child: Text(
                      'Ver todos',
                      style: TextStyle(color: Color.fromARGB(255, 23, 162, 236)),
                      ),
                  ),
                ],
              ),
              _buildDoctorCard(
                'Dr. Jesúruga',
                'La salud de cada uno de mis pacientes, es vital para ayudar a recuperarse y tener una vida sana.',
                5.0,
              ),
            ],
          ),
        ),
      ),
    bottomNavigationBar: BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home, color: Color.fromARGB(255, 0, 0, 0)),
          label: 'Inicio',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.access_time, color: Color.fromARGB(255, 0, 0, 0)),
          label: 'Historial',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat, color: Color.fromARGB(255, 0, 0, 0)),
          label: 'Mensajes',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle, color: Color.fromARGB(255, 0, 0, 0)),
          label: 'Perfil',
        ),
      ],
      onTap: (index) {
        if (index == 2) {
          Navigator.pushNamed(context, '/messages_screen');
        } else if (index == 3) {
          Navigator.pushNamed(context, '/profile_screen');
        }
      },
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.black,
      selectedLabelStyle: TextStyle(color: Colors.black),
      unselectedLabelStyle: TextStyle(color: Colors.black),
      showSelectedLabels: true,
      showUnselectedLabels: true,
      ),
    );
  }




  Widget _buildServiceButton(BuildContext context, String title) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4.0),
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Color.fromRGBO(11, 143, 172, 1.0),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(title, style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }

  Widget _buildDoctorCard(String name, String description, double rating) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.grey[300], 
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text(description),
                SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 20),
                    SizedBox(width: 4),
                    Text(rating.toString(), style: TextStyle(fontSize: 16)),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.favorite_border),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

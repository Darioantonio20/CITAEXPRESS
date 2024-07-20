import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AllItemsScreen extends StatefulWidget {
  const AllItemsScreen({Key? key}) : super(key: key);

  @override
  _AllItemsScreenState createState() => _AllItemsScreenState();
}

class _AllItemsScreenState extends State<AllItemsScreen> {
  List<dynamic> providers = [];

  @override
  void initState() {
    super.initState();
    fetchProviders();
  }

  Future<void> fetchProviders() async {
    final response = await http.get(Uri.parse('http://localhost:8080/api/providers'));
    if (response.statusCode == 200) {
      setState(() {
        providers = json.decode(response.body)['providers'];
      });
    } else {
      throw Exception('Failed to load providers');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
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
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text('Servicio')),
                    DataColumn(label: Text('Ubicación')),
                    DataColumn(label: Text('Teléfono')),
                  ],
                  rows: providers.map((provider) {
                    return DataRow(
                      cells: [
                        DataCell(Text(provider['serviceProvider'])),
                        DataCell(Text(provider['ubication'])),
                        DataCell(Text(provider['numberTelProvider'].toString())),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

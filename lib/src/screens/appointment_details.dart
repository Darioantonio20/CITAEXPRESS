import 'package:flutter/material.dart';

class AppointmentDetailsScreen extends StatefulWidget {
  const AppointmentDetailsScreen({Key? key}) : super(key: key);

  @override
  _AppointmentDetailsScreenState createState() => _AppointmentDetailsScreenState();
}

class _AppointmentDetailsScreenState extends State<AppointmentDetailsScreen> {
  String selectedTime = '11.00 AM'; // Valor predeterminado seleccionado

  void _selectTime(String time) {
    setState(() {
      selectedTime = time;
    });
  }

  String selectedDate = 'Lun. 4'; // Valor predeterminado seleccionado

  void _selectDate(String date) {
    setState(() {
      selectedDate = date;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cita'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.grey[300], // Placeholder sin imagen
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dr. Cristian',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Dentista',
                      style: TextStyle(color: Colors.teal),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Payment',
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                    Text(
                      '\$120.00',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal),
                    ),
                  ],
                ),
                Spacer(),
                Column(
                  children: [
                    IconButton(
                      icon: Icon(Icons.chat_bubble, color: Colors.teal),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(Icons.phone, color: Colors.teal),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(Icons.videocam, color: Colors.teal),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              'Detallles',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Un dentista es un profesional de la salud encargado de la prevención, diagnóstico y tratamiento de enfermedades y condiciones de los dientes y la cavidad oral. Realiza procedimientos como limpiezas, empastes, extracciones y ortodoncia para mantener la salud bucal de sus pacientes. ',
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Horarios',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text('Ver todos'),
                ),
              ],
            ),
            Container(
              height: 70,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildTimeSlot('10.00 AM'),
                  _buildTimeSlot('11.00 AM'),
                  _buildTimeSlot('12.00 PM'),
                  _buildTimeSlot('1.00 PM'),
                  _buildTimeSlot('2.00 PM'),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Fecha',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text('Ver todos'),
                ),
              ],
            ),
            Container(
              height: 70,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildDateSlot('Lun. 4'),
                  _buildDateSlot('Mar. 5'),
                  _buildDateSlot('Mier. 6'),
                  _buildDateSlot('Jue. 7'),
                  _buildDateSlot('Vier. 8'),
                  _buildDateSlot('Sab. 9'),
                ],
              ),
            ),
            SizedBox(height: 17),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Acción para el botón Reservar cita
                },
                child: const Text(
                  'Reservar cita',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeSlot(String time) {
    bool isSelected = time == selectedTime;
    return GestureDetector(
      onTap: () => _selectTime(time),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
        padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        decoration: BoxDecoration(
          color: isSelected ? Colors.teal : Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            time,
            style: TextStyle(color: isSelected ? Colors.white : Colors.black),
          ),
        ),
      ),
    );
  }

  Widget _buildDateSlot(String date) {
    bool isSelected = date == selectedDate;
    return GestureDetector(
      onTap: () => _selectDate(date),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
        padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        decoration: BoxDecoration(
          color: isSelected ? Colors.teal : Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            date,
            style: TextStyle(color: isSelected ? Colors.white : Colors.black),
          ),
        ),
      ),
    );
  }
}

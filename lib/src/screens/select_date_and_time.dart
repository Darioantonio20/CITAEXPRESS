import 'package:flutter/material.dart';

class SelectDateAndTimeScreen extends StatefulWidget {
  const SelectDateAndTimeScreen({Key? key}) : super(key: key);

  @override
  _SelectDateAndTimeScreenState createState() => _SelectDateAndTimeScreenState();
}

class _SelectDateAndTimeScreenState extends State<SelectDateAndTimeScreen> {
  DateTime selectedDate = DateTime.now();
  String selectedTime = '';

  void _selectTime(String time) {
    setState(() {
      selectedTime = time;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selecciona Fecha Y Hora'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CalendarDatePicker(
              initialDate: selectedDate,
              firstDate: DateTime(DateTime.now().year, DateTime.now().month - 1),
              lastDate: DateTime(DateTime.now().year, DateTime.now().month + 1),
              onDateChanged: (date) {
                setState(() {
                  selectedDate = date;
                });
              },
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Horario disponible',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text('Ver todas'),
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
}

import 'data.dart';
import 'package:flutter/material.dart';
import 'datepicker.dart'; // Replace with the correct path to your DatePicker file

class EventsController extends StatefulWidget {
  @override
  _EventsControllerState createState() => _EventsControllerState();
}

class _EventsControllerState extends State<EventsController> {
  late Data data;
  late List<dynamic> events;

  @override
  void initState() {
    super.initState();
    data = Data();
    events = data.getAllEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Events'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () async {
              // Open the DatePicker and wait for the selected date and time
              final DateTime? selectedDate = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DatePicker()),
              );

              // If a date was selected, do something with it
              if (selectedDate != null) {
                // For example, add a new event with the selected date and time
                setState(() {
                    events.add({
                        'title': 'New Event',
                        'description': 'Description for the new event',
                        'startTime': selectedDate.toString(),
                        'endTime': selectedDate.add(Duration(hours: 2)).toString(), // Example: adding 2 hours
                        'location': 'Location for the new event',
                    });
                });

                // Optionally, show a confirmation message
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('New event created for $selectedDate')),
                );
              }
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) {
          final event = events[index];
          return Card(
            margin: EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event['title'],
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    event['description'],
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.schedule, color: Colors.grey),
                      SizedBox(width: 5),
                      Text(
                        'Start: ${event['startTime']}',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(Icons.schedule, color: Colors.grey),
                      SizedBox(width: 5),
                      Text(
                        'End: ${event['endTime']}',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.grey),
                      SizedBox(width: 5),
                      Text(
                        'Location: ${event['location']}',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:final_project_flights_list/database/database.dart';
import 'package:final_project_flights_list/entity/flight.dart';

class FlightListPage extends StatefulWidget {
  final AppDatabase database;

  FlightListPage({required this.database});

  @override
  _FlightListPageState createState() => _FlightListPageState();
}

class _FlightListPageState extends State<FlightListPage> {
  late Future<List<Flight>> flights;

  @override
  void initState() {
    super.initState();
    refreshFlights();
  }

  Future refreshFlights() async {
    setState(() {
      flights = widget.database.flightDao.findAllFlights();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flights'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () async {
              final newFlight = Flight(
                departureCity: 'New York',
                destinationCity: 'Los Angeles',
                departureTime: '08:00 AM',
                arrivalTime: '11:00 AM',
              );
              await widget.database.flightDao.insertFlight(newFlight);
              refreshFlights();
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Flight>>(
        future: flights,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('An error occurred!'));
          } else {
            final flights = snapshot.data;

            if (flights == null || flights.isEmpty) {
              return Center(child: Text('No flights available.'));
            }

            return ListView.builder(
              itemCount: flights.length,
              itemBuilder: (context, index) {
                final flight = flights[index];

                return ListTile(
                  title: Text('${flight.departureCity} to ${flight.destinationCity}'),
                  subtitle: Text('${flight.departureTime} - ${flight.arrivalTime}'),
                  onTap: () async {
                    final updatedFlight = Flight(
                      id: flight.id,
                      departureCity: flight.departureCity,
                      destinationCity: flight.destinationCity,
                      departureTime: flight.departureTime,
                      arrivalTime: flight.arrivalTime,
                    );
                    await widget.database.flightDao.updateFlight(updatedFlight);
                    refreshFlights();
                  },
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () async {
                      await widget.database.flightDao.deleteFlight(flight);
                      refreshFlights();
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
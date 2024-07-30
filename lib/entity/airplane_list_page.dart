// airplane_list_page.dart
import 'package:flutter/material.dart';
import '/models/airplane.dart';

class AirplaneListPage extends StatefulWidget {
  const AirplaneListPage({super.key});

  @override
  State<AirplaneListPage> createState() => _AirplaneListPageState();
}

class _AirplaneListPageState extends State<AirplaneListPage> {
  final List<Airplane> _airplanes = [];

  void _addAirplane(Airplane airplane) {
    setState(() {
      _airplanes.add(airplane);
    });
  }

  void _updateAirplane(int index, Airplane airplane) {
    setState(() {
      _airplanes[index] = airplane;
    });
  }

  void _deleteAirplane(int index) {
    setState(() {
      _airplanes.removeAt(index);
    });
  }

  void _navigateToAddAirplanePage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AirplaneFormPage(
          onSubmit: _addAirplane,
        ),
      ),
    );
  }

  void _navigateToEditAirplanePage(BuildContext context, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AirplaneFormPage(
          airplane: _airplanes[index],
          onSubmit: (updatedAirplane) {
            _updateAirplane(index, updatedAirplane);
          },
          onDelete: () {
            _deleteAirplane(index);
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Airplane List Page'),
      ),
      body: ListView.builder(
        itemCount: _airplanes.length,
        itemBuilder: (context, index) {
          final airplane = _airplanes[index];
          return ListTile(
            title: Text(airplane.type),
            subtitle: Text('Passengers: ${airplane.passengers}, Speed: ${airplane.maxSpeed}, Range: ${airplane.range}'),
            onTap: () => _navigateToEditAirplanePage(context, index),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAddAirplanePage(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class AirplaneFormPage extends StatefulWidget {
  final Airplane? airplane;
  final void Function(Airplane) onSubmit;
  final VoidCallback? onDelete;

  const AirplaneFormPage({super.key, this.airplane, required this.onSubmit, this.onDelete});

  @override
  State<AirplaneFormPage> createState() => _AirplaneFormPageState();
}

class _AirplaneFormPageState extends State<AirplaneFormPage> {
  final _formKey = GlobalKey<FormState>();
  late String _type;
  late int _passengers;
  late double _maxSpeed;
  late double _range;

  @override
  void initState() {
    super.initState();
    if (widget.airplane != null) {
      _type = widget.airplane!.type;
      _passengers = widget.airplane!.passengers;
      _maxSpeed = widget.airplane!.maxSpeed;
      _range = widget.airplane!.range;
    } else {
      _type = '';
      _passengers = 0;
      _maxSpeed = 0;
      _range = 0;
    }
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final airplane = Airplane(
        type: _type,
        passengers: _passengers,
        maxSpeed: _maxSpeed,
        range: _range,
      );
      widget.onSubmit(airplane);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Airplane Form Page'),
        actions: [
          if (widget.airplane != null && widget.onDelete != null)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: widget.onDelete,
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                initialValue: _type,
                decoration: const InputDecoration(labelText: 'Airplane Type'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the airplane type';
                  }
                  return null;
                },
                onSaved: (value) {
                  _type = value!;
                },
              ),
              TextFormField(
                initialValue: _passengers.toString(),
                decoration: const InputDecoration(labelText: 'Number of Passengers'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty || int.tryParse(value) == null) {
                    return 'Please enter a valid number of passengers';
                  }
                  return null;
                },
                onSaved: (value) {
                  _passengers = int.parse(value!);
                },
              ),
              TextFormField(
                initialValue: _maxSpeed.toString(),
                decoration: const InputDecoration(labelText: 'Maximum Speed'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty || double.tryParse(value) == null) {
                    return 'Please enter a valid maximum speed';
                  }
                  return null;
                },
                onSaved: (value) {
                  _maxSpeed = double.parse(value!);
                },
              ),
              TextFormField(
                initialValue: _range.toString(),
                decoration: const InputDecoration(labelText: 'Range'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty || double.tryParse(value) == null) {
                    return 'Please enter a valid range';
                  }
                  return null;
                },
                onSaved: (value) {
                  _range = double.parse(value!);
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submit,
                child: Text(widget.airplane == null ? 'Submit' : 'Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

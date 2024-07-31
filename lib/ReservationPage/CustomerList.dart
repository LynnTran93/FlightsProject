import 'package:final_project_flights_list/customer_list_app/customer.dart';
import 'package:flutter/widgets.dart';

class CustomerList extends StatelessWidget {
  CustomerList({super.key});

  List<Customer> customer = [];


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
              itemCount: customer.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {

                  },
                  child: SizedBox(
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('Reservation $index'),
                      ],
                    ),
                  ),
                );
              }
          ),
        ),
      ],
    );
  }
}
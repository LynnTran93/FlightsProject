import 'package:flutter/material.dart';

import 'CustomerList.dart';

class BookButton extends StatelessWidget{
  BookButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column( mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(onPressed: () {
          CustomerList();
        },
          child: const Text("Book a Flight"),
        )
      ],
    );
  }

}
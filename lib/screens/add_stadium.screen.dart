import 'package:flutter/material.dart';

class AddStadium extends StatefulWidget {
  const AddStadium({super.key});

  @override
  State<AddStadium> createState() => _AddStadiumState();
}

class _AddStadiumState extends State<AddStadium> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Stadiums'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: const Center(
        child: Text('Add Stadiums'),
      ),
    );
  }
}

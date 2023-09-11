import 'package:emf_detector/models/magnitude_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainReading extends StatefulWidget {
  const MainReading({super.key});

  @override
  State<MainReading> createState() => _MainReadingState();
}

class _MainReadingState extends State<MainReading> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20,),
        Consumer<MagnitudeProvider>(
          builder: (context, model, child) => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width /2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      model.magnitude.toStringAsFixed(2),
                      style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width /2,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      " µTesla",
                      style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
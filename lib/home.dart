import 'package:emf_detector/pages/visuals.dart';
import 'package:emf_detector/utils/colors.dart';
import 'package:emf_detector/widgets/mainReading.dart';
import 'package:emf_detector/widgets/meter_reading.dart';
import 'package:emf_detector/widgets/xyzReading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/magnitude_provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const MainReading(),
              const XYZReading(),
              const MeterReading(),
              Container(
                width: 200,
                height: 50,
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(100),side: const BorderSide(color: Colors.white))),
                    backgroundColor: MaterialStatePropertyAll(AppColor.primaryColor),
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> const Visuals() ));
                  }, 
                  child: const Text('Visualize')
                ),
              ),
              const SizedBox(height: 10,),

              Consumer<MagnitudeProvider>(
                builder: (context, model, child) => Container(
                  width: 200,
                height: 50,
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(100),side: const BorderSide(color: Colors.white))),
                    backgroundColor: MaterialStatePropertyAll(AppColor.primaryColor),
                  ),
                  onPressed: () {
                    model.changeValues();
                  }, 
                  child: const Text('Start')
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
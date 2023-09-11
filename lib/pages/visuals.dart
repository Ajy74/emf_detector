import 'package:emf_detector/models/magnitude_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Visuals extends StatefulWidget {
  const Visuals({super.key});

  @override
  State<Visuals> createState() => _VisualsState();
}

class _VisualsState extends State<Visuals> {
  late ChartSeriesController _chartSeriesController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(title: const Text("Visuals"),),
      body: Container(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(5),
              child: Card(
                color: Colors.grey.shade800,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Consumer<MagnitudeProvider>(
                  builder: (context, model, child) => SfCartesianChart(
                    title: ChartTitle(text: 'x,y,z with Time'),
                    legend: Legend(isVisible: true,title: LegendTitle(text: 'Legend')),
                    series: <LineSeries<LiveData, int>>[
                      LineSeries<LiveData, int>(
                        legendItemText: 'x',
                        onRendererCreated: (ChartSeriesController controller) {
                          _chartSeriesController = controller;
                        },
                        dataSource: model.values,
                        color: Colors.red, 
                        xValueMapper: (LiveData values, _) => values.time, 
                        yValueMapper: (LiveData values, _) => values.x,
                      ),

                      LineSeries<LiveData, int>(
                        legendItemText: 'y',
                        onRendererCreated: (ChartSeriesController controller) {
                          _chartSeriesController = controller;
                        },
                        dataSource: model.values,
                        color: Colors.blue, 
                        xValueMapper: (LiveData values, _) => values.time, 
                        yValueMapper: (LiveData values, _) => values.y,
                      ),

                      LineSeries<LiveData, int>(
                        legendItemText: 'z',
                        onRendererCreated: (ChartSeriesController controller) {
                          _chartSeriesController = controller;
                        },
                        dataSource: model.values,
                        color: Colors.green, 
                        xValueMapper: (LiveData values, _) => values.time, 
                        yValueMapper: (LiveData values, _) => values.z,
                      ),

                    ],
                    primaryXAxis: NumericAxis(
                      isVisible: false,
                      majorGridLines: const MajorGridLines(width: 0),
                      edgeLabelPlacement:  EdgeLabelPlacement.shift,
                      interval: 3,
                      title: AxisTitle(text: 'Time(s)')
                    ),
                    primaryYAxis: NumericAxis(
                      axisLine: const AxisLine(width: 0),
                      majorTickLines: const MajorTickLines(size: 0),
                      title: AxisTitle(text: 'µTesla')
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
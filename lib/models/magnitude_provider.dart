import 'dart:math';
import 'dart:math' as math;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:motion_sensors/motion_sensors.dart';
import 'package:vector_math/vector_math_64.dart';
import 'package:sensors_plus/sensors_plus.dart';

class MagnitudeProvider extends ChangeNotifier{
  double x = 0;
  double y = 0;
  double z = 0;
  double magnitude = 0;
  int time = 0;
  List<LiveData> values = [];


  Vector3 magnetometer = Vector3.zero();
  Vector3 _accelerometer = Vector3.zero();
  Vector3 _absoluteOrientation2 = Vector3.zero();
  int? groupValue = 2;

  changeValues(){
    
    magnetometerEvents.listen((MagnetometerEvent event) { 
      magnetometer.setValues(event.x, event.y, event.z);
      var matrix = getRotationMatrix(_accelerometer, magnetometer);
      
      _absoluteOrientation2.setFrom(getOrientation(matrix));

      x = magnetometer.x;
      y = magnetometer.y;
      z = magnetometer.z;

      magnitude = sqrt( (pow(magnetometer.x, 2)) + (pow(magnetometer.y, 2)) + (pow(magnetometer.z, 2)) );

      values.add( LiveData(x, y, z, time++) );

      if(values.length > 40){
        values.removeAt(0);
      }

      notifyListeners();
    });
    
  }

  Matrix4 getRotationMatrix(Vector3 gravity, Vector3 geomagnetic) {
    Vector3 a = gravity.normalized();
    Vector3 e = geomagnetic.normalized();
    Vector3 h = e.cross(a).normalized();
    Vector3 m = a.cross(h).normalized();
    return Matrix4(
      h.x, m.x, a.x, 0, //
      h.y, m.y, a.y, 0,
      h.z, m.z, a.z, 0,
      0, 0, 0, 1,
    );
  }

  Vector3 getOrientation(Matrix4 m) {
    final r = m.storage;
    return Vector3(
      math.atan2(-r[4], r[5]),
      math.asin(r[6]),
      math.atan2(-r[2], r[10]),
    );
  }

  setUpdateInterval(int? groupValue, int interval){
    // motionSensors.magnetometerUpdateInterval = interval;
    groupValue =  groupValue;
    if (kDebugMode) {
      print(groupValue);
    }
    notifyListeners();
  }

}

class LiveData {

  LiveData(this.x,this.y,this.z,this.time);

  final double x;
  final double y;
  final double z;
  final int time;
}
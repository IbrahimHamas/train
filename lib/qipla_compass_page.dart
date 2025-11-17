import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'dart:math' as math;

//1- install flutter_qiblah package in pubspec.yaml before using this code.
//2- Add compass.png image to assets folder and declare it in pubspec.yaml.
//3-Add  <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"/> in AndroidManifest.xml above <application>
//4-Add  <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION"/> in AndroidManifest.xml above <application>
class QiblaCompassScreen extends StatefulWidget {
  const QiblaCompassScreen({super.key});

  @override
  _QiblaCompassScreenState createState() => _QiblaCompassScreenState();
}

class _QiblaCompassScreenState extends State<QiblaCompassScreen> {
  @override
  void initState() {
    super.initState();
    FlutterQiblah.requestPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Qibla Direction")),
      body: Center(
        child: StreamBuilder<QiblahDirection>(
          stream: FlutterQiblah.qiblahStream,
          builder: (_, snapshot) {
            if (!snapshot.hasData) {
              return const CircularProgressIndicator();
            }

            final qiblahDirection = snapshot.data!;
            final angle = qiblahDirection.qiblah *
                (math.pi / 180); // زاوية القبلة بالراديان
            final deviceAngle =
                qiblahDirection.direction * (math.pi / 180); // اتجاه الجهاز

            // دوران البوصلة
            final compassRotation = -deviceAngle;

            // دوران سهم القبلة
            final qiblaRotation = angle - deviceAngle;

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // صورة البوصلة
                Transform.rotate(
                  angle: compassRotation,
                  child: Image.asset(
                    "assets/compass.png",
                    width: 250,
                  ),
                ),
                const SizedBox(height: 20),

                // سهم يشير باتجاه القبلة
                Transform.rotate(
                  angle: qiblaRotation,
                  child: const Icon(
                    Icons.navigation,
                    size: 80,
                    color: Colors.green,
                  ),
                ),

                const SizedBox(height: 20),

                Text(
                  "Qibla: ${qiblahDirection.qiblah.toStringAsFixed(2)}°",
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    FlutterQiblah().dispose(); // ← هذا هو الصحيح
    super.dispose();
  }
}

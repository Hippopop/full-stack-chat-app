import 'dart:io';

import 'package:chat_client/src/services/initializer/root.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => false;
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const ProviderScope(child: AppRoot()));
}


// import 'dart:math' as math;

// void main() {
//   runApp(
//     MaterialApp(
//       home: Home(),
//       debugShowCheckedModeBanner: false,
//     ),
//   );
// }

// class Home extends StatefulWidget {
//   const Home({super.key});

//   @override
//   _HomeState createState() => _HomeState();
// }

// class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       backgroundColor: Colors.black,
//       body: SizedBox.expand(child: CupertinoBreathe()),
//     );
//   }
// }

// class CupertinoBreathe extends StatefulWidget {
//   const CupertinoBreathe({super.key});

//   @override
//   _CupertinoBreatheState createState() => _CupertinoBreatheState();
// }

// class _CupertinoBreatheState extends State<CupertinoBreathe>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(seconds: 3),
//       vsync: this,
//     )..repeat(reverse: true);
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: AspectRatio(
//         aspectRatio: 1.0,
//         child: CustomPaint(
//           painter: _BreathePainter(
//             CurvedAnimation(
//               parent: _controller,
//               curve: Curves.ease,
//             ),
//           ),
//           size: Size.infinite,
//         ),
//       ),
//     );
//   }
// }

// class _BreathePainter extends CustomPainter {
//   _BreathePainter(
//     this.animation, {
//     this.count = 6,
//     Color color = const Color(0xFF61bea2),
//   })  : circlePaint = Paint()
//           ..color = color
//           ..blendMode = BlendMode.screen,
//         super(repaint: animation);

//   final Animation<double> animation;
//   final int count;
//   final Paint circlePaint;

//   @override
//   void paint(Canvas canvas, Size size) {
//     final center = size.center(Offset.zero);
//     final radius = (size.shortestSide * 0.25) * animation.value;
//     for (int index = 0; index < count; index++) {
//       final indexAngle = (index * math.pi / count * 2);
//       final angle = indexAngle + (math.pi * 1.5 * animation.value);
//       final offset = Offset(math.sin(angle), math.cos(angle)) * radius * 0.985;
//       canvas.drawCircle(center + offset * animation.value, radius, circlePaint);
//     }
//   }

//   @override
//   bool shouldRepaint(_BreathePainter oldDelegate) =>
//       animation != oldDelegate.animation;
// }

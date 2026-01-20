import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDark = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: isDark ? ThemeData.dark() : ThemeData.light(),
      home: CalculatorPage(
        isDark: isDark,
        onToggle: () => setState(() => isDark = !isDark),
      ),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  final bool isDark;
  final VoidCallback onToggle;

  const CalculatorPage({
    super.key,
    required this.isDark,
    required this.onToggle,
  });

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String display = "0";
  double first = 0;
  String op = "";

  void press(String v) {
    setState(() {
      if (v == "C") {
        display = "0";
        first = 0;
        op = "";
      } else if (["+", "-", "×", "÷"].contains(v)) {
        first = double.parse(display);
        op = v;
        display = "0";
      } else if (v == "=") {
        double second = double.parse(display);
        switch (op) {
          case "+":
            display = (first + second).toString();
            break;
          case "-":
            display = (first - second).toString();
            break;
          case "×":
            display = (first * second).toString();
            break;
          case "÷":
            display = second == 0 ? "Error" : (first / second).toString();
            break;
        }
      } else if (v == "√") {
        display = sqrt(double.parse(display)).toString();
      } else if (v == "x²") {
        display = pow(double.parse(display), 2).toString();
      } else if (v == "sin") {
        display = sin(double.parse(display)).toStringAsFixed(4);
      } else if (v == "cos") {
        display = cos(double.parse(display)).toStringAsFixed(4);
      } else if (v == "tan") {
        display = tan(double.parse(display)).toStringAsFixed(4);
      } else if (v == "log") {
        display = log(double.parse(display)).toStringAsFixed(4);
      } else {
        display == "0" ? display = v : display += v;
      }
    });
  }

  Widget glassButton(String text, {Color? color}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: InkWell(
              onTap: () => press(text),
              child: Container(
                height: 60,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: (color ?? Colors.white).withOpacity(0.18),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: Colors.white24),
                ),
                child: Text(
                  text,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.isDark ? Colors.black : Colors.blueGrey.shade200,
      appBar: AppBar(
        title: const Text("Glass Scientific Calculator"),
        actions: [
          IconButton(
            icon: Icon(widget.isDark ? Icons.light_mode : Icons.dark_mode),
            onPressed: widget.onToggle,
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.all(20),
            child: Text(
              display,
              style: const TextStyle(fontSize: 42, fontWeight: FontWeight.bold),
            ),
          ),

          Row(
            children: [
              glassButton("sin"),
              glassButton("cos"),
              glassButton("tan"),
              glassButton("log"),
            ],
          ),
          Row(
            children: [
              glassButton("√"),
              glassButton("x²"),
              glassButton("C", color: Colors.red),
              glassButton("÷", color: Colors.orange),
            ],
          ),
          Row(
            children: [
              glassButton("7"),
              glassButton("8"),
              glassButton("9"),
              glassButton("×", color: Colors.orange),
            ],
          ),
          Row(
            children: [
              glassButton("4"),
              glassButton("5"),
              glassButton("6"),
              glassButton("-", color: Colors.orange),
            ],
          ),
          Row(
            children: [
              glassButton("1"),
              glassButton("2"),
              glassButton("3"),
              glassButton("+", color: Colors.orange),
            ],
          ),
          Row(
            children: [
              glassButton("0"),
              glassButton("."),
              glassButton("=", color: Colors.green),
            ],
          ),
        ],
      ),
    );
  }
}

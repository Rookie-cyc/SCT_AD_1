import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simple Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CalculatorHomePage(),
    );
  }
}

class CalculatorHomePage extends StatefulWidget {
  @override
  _CalculatorHomePageState createState() => _CalculatorHomePageState();
}

class _CalculatorHomePageState extends State<CalculatorHomePage> {
  String display = "0"; // Display output
  String operator = "";
  double num1 = 0;
  double num2 = 0;

  // Button press handler
  void buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        display = "0"; // Clear the display
      } else if (buttonText == "=") {
        num2 = double.tryParse(display) ?? 0;

        switch (operator) {
          case "+":
            display = (num1 + num2).toString();
            break;
          case "-":
            display = (num1 - num2).toString();
            break;
          case "*":
            display = (num1 * num2).toString();
            break;
          case "/":
            display = (num2 != 0) ? (num1 / num2).toString() : "Error";
            break;
        }
        operator = ""; // Reset operator after calculation
      } else {
        if (operator.isEmpty) {
          num1 = double.tryParse(display) ?? 0; // Set first number
        }
        if (display == "0") {
          display = buttonText; // Replace zero with the first number
        } else {
          display += buttonText; // Append number or operator
        }
        if (["+", "-", "*", "/"].contains(buttonText)) {
          operator = buttonText; // Set operator
          display = "0"; // Reset display for the next number
        }
      }
    });
  }

  Widget buildButton(String buttonText) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () => buttonPressed(buttonText),
        child: Text(buttonText, style: TextStyle(fontSize: 24)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.all(24.0),
            child: Text(
              display,
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Divider()),
          Row(
            children: <Widget>[
              buildButton("7"),
              buildButton("8"),
              buildButton("9"),
              buildButton("/"),
            ],
          ),
          Row(
            children: <Widget>[
              buildButton("4"),
              buildButton("5"),
              buildButton("6"),
              buildButton("*"),
            ],
          ),
          Row(
            children: <Widget>[
              buildButton("1"),
              buildButton("2"),
              buildButton("3"),
              buildButton("-"),
            ],
          ),
          Row(
            children: <Widget>[
              buildButton("C"),
              buildButton("0"),
              buildButton("="),
              buildButton("+"),
            ],
          ),
        ],
      ),
    );
  }
}

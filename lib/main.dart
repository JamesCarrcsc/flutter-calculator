import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'James Carr - Calculator App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'James Carr - Calculator App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _expression = '';
  String _result = '';

  void _addToExpression(String value) {
    setState(() {
      _expression += value;
    });
  }

  void _calculateResult() {
    final expression = Expression.parse(_expression);
    final evaluator = const ExpressionEvaluator();

    final context = Map<String, dynamic>();

    setState(() {
      try {
        _result = evaluator.eval(expression, context).toString();
      } catch (e) {
        _result = 'Error';
      }
    });
  }

  void _clearExpression() {
    setState(() {
      _expression = '';
      _result = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.all(16),
              child: Text(
                _expression,
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.all(16),
              child: Text(
                _result,
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      _buildCalculatorButton('7'),
                      _buildCalculatorButton('8'),
                      _buildCalculatorButton('9'),
                      _buildCalculatorButton('+'),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      _buildCalculatorButton('4'),
                      _buildCalculatorButton('5'),
                      _buildCalculatorButton('6'),
                      _buildCalculatorButton('-'),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      _buildCalculatorButton('1'),
                      _buildCalculatorButton('2'),
                      _buildCalculatorButton('3'),
                      _buildCalculatorButton('*'),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      _buildCalculatorButton('0'),
                      _buildCalculatorButton('.'),
                      _buildCalculatorButton('='),
                      _buildCalculatorButton('/'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: _clearExpression,
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }

  Widget _buildCalculatorButton(String value) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          if (value == '=') {
            _calculateResult();
          } else {
            _addToExpression(value);
          }
        },
        child: Text(
          value,
          style: TextStyle(fontSize: 24), // Increase the font size
        ),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(16), // Increase the button padding
        ),
      ),
    );
  }
}

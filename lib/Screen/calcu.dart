//import 'package:calculator_app/main.dart';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalcuScreen extends StatefulWidget {
  const CalcuScreen({super.key});

  @override
  State<CalcuScreen> createState() {
    return _CalcuScreenState();
  }
}

class _CalcuScreenState extends State<CalcuScreen> {
  String output = "0";
  //String _output="0";
  double num1 = 0.0;
  double num2 = 0.0;
  int num3=100;
  double pie=3.142;
  String operand = "";
  bool hasOpenParentheses =false;

  void buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "AC") {
        output = "";
        num1 = 0.0;
        num2 = 0.0;
        operand = "";
        hasOpenParentheses =false;
      } else if (buttonText == "+" ||
          buttonText == "-" ||
          buttonText == "X" ||
          buttonText == "+" ||
          buttonText == "%" ||
          buttonText == "√" ||
          buttonText == "/" ||
          buttonText == "!" ||
          buttonText == "^" ||
          buttonText == "()" ||
          buttonText == "π") {
        if(!hasOpenParentheses){
        num1 = double.parse(output);
        operand = buttonText;
        output = "";
         } else {
           output +=buttonText;
          }
      } else if (buttonText == ".") {
        if (!output.contains(".")) {
          output = output + buttonText;
        }
      } else if (buttonText == "=") {
        if (hasOpenParentheses) {
          output ="Invalid Expression";
        }else {
        num2 = double.parse(output);

        if (operand == "+") {
          output = (num1 + num2).toString();
        }
        if (operand == "-") {
          output = (num1 - num2).toString();
        }
        if (operand == "X") {
          output = (num1 * num2).toString();
        }
        if (operand == "/") {
          output = (num1 / num2).toString();
        }
        if (operand == "%") {
          output = (num1 % num2).toString();
        }
        if (operand == "√") {
          output = sqrt(num1).toString();
        }
        if (operand == "π") {
          output = (num1*pie*num2).toString();
        }
        if (operand == "^") {
          output = pow(num1,num2).toString();
        }
        if (operand == "!") {
          output = factorial(num1).toString();
        }
        num1 = 0.0;
        num2 = 0.0;
        operand = "";
        hasOpenParentheses =false;
        }
      } else if(buttonText =="(") {
        if(output.isEmpty||operand=="(") {
          output +=buttonText;
        }else {
          output +=" $buttonText";
        }
        hasOpenParentheses =true;
      } else if(buttonText ==")" ) {
        if (hasOpenParentheses) {
          if(output.isNotEmpty) {
            output +=")";
          }
          try {
            output = evaluateExpressionWithinParentheses(output).toString();
          }catch (e) {
            output ="Invalid Expression";
          }
          hasOpenParentheses =false;
        }
      }
      else {
        output +=buttonText;
      }
    });
  }

  double evaluateExpressionWithinParentheses(String expression) {
    expression = expression.replaceAll('π', pie.toString());
    expression = expression.replaceAll('^', 'pow');
    return eval(expression);
  }

  double eval(String expression) {
    Parser p = Parser();
    ContextModel cm = ContextModel();
    Expression exp = p.parse(expression);
    return exp.evaluate(EvaluationType.REAL, cm);
  }

  double factorial(double n){
      if(n<0) {return double.nan;}
      if(n==0||n==1){return 1;}
      double result=1;
      for(int i=2;i <=n;i++) {
        result*=i;
      }
      return result;
    }

  Widget buildButton(String buttonText) {
    return Expanded(
      child: Container(
        margin:const EdgeInsets.all(10),
        child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.all(20),
              textStyle: const TextStyle(fontSize: 24.0),//24
              //alignment: Alignment.center,
            ),
            
            onPressed: () => buttonPressed(buttonText),
            child: Text(buttonText),
            //textAlign:TextAlign.center,
          ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.bottomRight,
              child: Container(
                padding: const EdgeInsets.only(
                  top: 12.0,
                ),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    padding: const EdgeInsets.only(
                      right: 2.0,
                      bottom: 2.0,
                    ),
                    child: Text(
                      output,
                      style: const TextStyle(
                        fontSize: 40,
                        color: Color.fromARGB(255, 121, 181, 230),
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const Divider(
            thickness: 3,
            height: 1,
          ),
          SizedBox(
            height: 500,
            child: Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      buildButton("AC"),
                      buildButton("( )"),
                      buildButton("%"),
                      buildButton("/"),
                    ],
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        buildButton("7"),
                        buildButton("8"),
                        buildButton("9"),
                        buildButton("X"),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        buildButton("4"),
                        buildButton("5"),
                        buildButton("6"),
                        buildButton("-"),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        buildButton("1"),
                        buildButton("2"),
                        buildButton("3"),
                        buildButton("+"),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        buildButton("0"),
                        buildButton("."),
                        buildButton("00"),
                        buildButton("="),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        buildButton("√"),
                        buildButton("π"),
                        buildButton("^"),
                        buildButton("!"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ignore_for_file: slash_for_doc_comments, prefer_interpolation_to_compose_strings, prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Variables para identificar los dos campos de texto
  var txtPeso = TextEditingController();
  var txtAltura = TextEditingController();

  // Variable para IMC
  String imc = "IMC: 0.0";
  // Variable para el valor del IMC
  double imcVal = 0.0;

  /**
  * Función para calcular el valor del IMC
  */
  double calcularIMC() {
    double peso = double.parse(txtPeso.text);
    double altura = double.parse(txtAltura.text);
    double imcValue = peso / pow(altura, 2);

    setState(() {
      imc = categoriaIMC(imcValue);
    });

    imcVal = imcValue;
    return imcVal;
  }

  /**
   * Función para determinar la categoría del IMC
   * 
   */

  String categoriaIMC(double imc) {
    if (imc == 0.0) {
      return "IMC: " + imc.toStringAsFixed(2) + "\n                ";
    }
    if (imc >= 35.0) {
      return "IMC: " + imc.toStringAsFixed(2) + "\nTienes obesidad extrema";
    }
    if (imc >= 30.0 && imc <= 35.0) {
      return "IMC: " + imc.toStringAsFixed(2) + "\nTienes obesidad";
    }
    if (imc >= 25.0 && imc <= 29.99) {
      return "IMC: " + imc.toStringAsFixed(2) + "\nTienes sobrepeso";
    }
    if (imc >= 18.5 && imc <= 24.99) {
      return "IMC: " + imc.toStringAsFixed(2) + "\nTienes peso normal";
    }
    if (imc < 18.5) {
      return "IMC: " + imc.toStringAsFixed(2) + "\nTienes delgadez severa";
    }

    return "Valor fuera de rango";
  }

  /**
  * Función para otro cálculo
  */

  void reiniciar() {
    txtAltura.clear();
    txtPeso.clear();

    _buildImcText(0.0);
  }

  /**
   * Función para imprimir recuadro con IMC y categoría
   */

  Widget _buildImcText(double imcValue) {
    String imcCategory = categoriaIMC(imcValue);
    Color textColor;

    if (imcValue >= 35) {
      textColor = Colors.red;
    } else if (imcValue >= 30.0) {
      textColor = Colors.orange;
    } else if (imcValue >= 25.0) {
      textColor = Colors.yellow;
    } else if (imcValue >= 18.5) {
      textColor = Colors.green;
    } else {
      textColor = Colors.blueAccent;
      imcCategory = " ";
    }

    return Container(
        padding: EdgeInsets.all(10), // Padding dentro del contenedor
        decoration: BoxDecoration(
          color: textColor, // Color de fondo de la caja
          borderRadius: BorderRadius.circular(10.0), // Bordes redondeados
        ),
        child: Text(
          imcCategory,
          style: TextStyle(
            fontSize: 22,
            color: Colors.black,
            backgroundColor: textColor,
          ),
        ));
  }

  /**
   * Widget Principal
   */

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Calculadora de IMC",
      theme: ThemeData.dark(),
      home: Scaffold(
          appBar: AppBar(
            title: Text("Calculadora IMC"),
          ),
          body: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Image(
                  image: AssetImage('images/imclogo.jpg'),
                  height: 200,
                ),
              ),
              Padding(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    textAlign: TextAlign.center,
                    decoration:
                        InputDecoration(hintText: "Tu Estatura en Metros"),
                    style: TextStyle(fontSize: 20, color: Colors.white),
                    controller: txtAltura,
                  )),
              Padding(
                  padding: EdgeInsets.all(30),
                  child: TextField(
                    textAlign: TextAlign.center,
                    decoration:
                        InputDecoration(hintText: "Tu Peso en Kilogramos"),
                    style: TextStyle(fontSize: 20, color: Colors.white),
                    controller: txtPeso,
                  )),
              Padding(
                  padding: EdgeInsets.all(30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          mostrarResultados(
                              context, categoriaIMC(calcularIMC()));
                        },
                        style: ElevatedButton.styleFrom(
                            fixedSize: Size(150, 50),
                            backgroundColor: Colors.green),
                        child: Text(
                          "Calcular IMC",
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: reiniciar,
                        style: ElevatedButton.styleFrom(
                            fixedSize: Size(150, 50),
                            backgroundColor: Colors.red),
                        child: Text("Otro Cálculo"),
                      )
                    ],
                  )),
              Padding(
                padding: EdgeInsets.all(10),
                child: _buildImcText(imcVal),
              ),
            ],
          )),
    );
  }

/**
 * Función para mostrar el resultado 
 * en una ventana de dialogo
 * 
 */
  void mostrarResultados(BuildContext context, String resultado) {
    // construir un alertDialog
    var alert = AlertDialog(
      title: Text("Resultado"),
      content: Text(resultado),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, 'Ok'),
          child: Text("Ok"),
        )
      ],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }
}

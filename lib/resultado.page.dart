// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'styles.dart';

class ResultadoPage extends StatelessWidget {
  const ResultadoPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "IETEL Solar",
          style: ietelSolar,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: const Color(0xFF082b59),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(6),
                ),
              ),
            child: Column(
              children: const [
                Padding(
                  padding: EdgeInsets.only(
                    top: 30
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Esta é a estimativa do seu ",
                        style: titulo,
                      ),
                      Text(
                        "Gerador Solar",
                        style: palavraChave,
                      ),
                      Text(
                        ":",
                        style: titulo,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text('Área mínima necessária: ', style: resultadofont),
                          Text('', style: resultadofontA),
                        ],
                      ),
                      SizedBox(height: 15), // Espaço entre as linhas
                      Row(
                        children: [
                          Text('Potência instalada: ', style: resultadofont),
                          Text('', style: resultadofontA),
                        ],
                      ),
                      SizedBox(height: 15), // Espaço entre as linhas
                      Row(
                        children: [
                          Text('Quantidade de placas: ', style: resultadofont),
                          Text('', style: resultadofontA),
                        ],
                      ),
                      SizedBox(height: 15), // Espaço entre as linhas
                      Row(
                        children: [
                          Text('Produção mensal: ', style: resultadofont),
                          Text('', style: resultadofontA),
                        ],
                      ), 
                      SizedBox(height: 15), // Espaço entre as linhas
                      Row(
                        children: [
                          Text('Tempo de payback: ', style: resultadofont),
                          Text('', style: resultadofontA),
                        ],
                      ), 
                      SizedBox(height: 15), // Espaço entre as linhas
                      Row(
                        children: [
                          Text('Economia anual: ', style: resultadofont),
                          Text('', style: resultadofontA),
                        ],
                      ),
                      // Adicione mais linhas conforme necessário
                    ],
                  ),
                ),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}

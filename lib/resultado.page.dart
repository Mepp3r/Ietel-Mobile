import 'package:flutter/material.dart';
import 'styles.dart';

class ResultadoPage extends StatelessWidget {
  final Map<String, dynamic> resultados;

  const ResultadoPage({required this.resultados, super.key});

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
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(6),
                ),
              ),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 30),
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
                    padding: const EdgeInsets.only(top: 30, right: 15, left: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text('Área mínima necessária: ', style: resultadofont),
                            Text('${resultados['areaMinima']} m²', style: resultadofontA),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            const Text('Potência instalada: ', style: resultadofont),
                            Text('${resultados['potenciaInstalada']} kWp', style: resultadofontA),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            const Text('Quantidade de placas: ', style: resultadofont),
                            Text('${resultados['quantidadeDePlacas']} placas', style: resultadofontA),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            const Text('Produção mensal: ', style: resultadofont),
                            Text('${resultados['producaoMensal']} kWh', style: resultadofontA),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            const Text('Tempo de payback: ', style: resultadofont),
                            Text('${resultados['tempoDePayback']} anos', style: resultadofontA),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            const Text('Economia anual: ', style: resultadofont),
                            Text('${resultados['economiaAnual']} reais', style: resultadofontA),
                          ],
                        ),
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

import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ietel_solar/resultado.page.dart';
import 'styles.dart';

class CalculadoraPage extends StatefulWidget {
  const CalculadoraPage({super.key});

  @override
  State<CalculadoraPage> createState() => _CalculadoraPageState();
}

class _CalculadoraPageState extends State<CalculadoraPage> {
  final TextEditingController _cepController = TextEditingController();
  final TextEditingController _valorEnergiaController = TextEditingController();
  String? _concessionariaSelecionada;
  final List<String> _concessionarias = ['CPFL', 'ENEL SP', 'EDP SP'];

  void _simular() {
    if (_cepController.text.isNotEmpty && _valorEnergiaController.text.isNotEmpty && _concessionariaSelecionada != null) {
      double valorEnergia = double.parse(_valorEnergiaController.text);
      double taxaConcessionaria = _concessionariaSelecionada == 'CPFL' ? 0.5 : (_concessionariaSelecionada == 'ENEL SP' ? 0.6 : 0.7);

      // Chamada para a função de simulação
      Map<String, dynamic> resultados = simuladorSolar(valorEnergia, taxaConcessionaria);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultadoPage(resultados: resultados),
        ),
      );
    }
  }

  Map<String, dynamic> simuladorSolar(double valorEnergia, double taxaConcessionaria) {
    var producaoDoAparalho = 57.50;
    var kwpDoAparelho = 0.56;
    var areaDoAparelho = 2.157;
    var eficienciaDoAparelho = 0.55;
    var diasDoAno = 365;
    var imprevistos = 0.55;
    var precoDoAparalho = 1000;
    var maoDeObra = 1200;
    var kwhMes = valorEnergia / taxaConcessionaria;
    var quantidadeDePlacasInstaladas = (kwhMes / producaoDoAparalho).ceil();
    var producaoMensal = quantidadeDePlacasInstaladas * producaoDoAparalho;
    var potenciaInstalada = quantidadeDePlacasInstaladas * kwpDoAparelho;
    var areaMinima = areaDoAparelho * quantidadeDePlacasInstaladas;
    var producaoAnual = potenciaInstalada * eficienciaDoAparelho * diasDoAno * imprevistos;
    var economiaAnual = producaoAnual * taxaConcessionaria;
    var investimentoInicial = (quantidadeDePlacasInstaladas * precoDoAparalho) + maoDeObra;
    var tempoDePayback = investimentoInicial / (economiaAnual * 10);


    return {
      'areaMinima': areaMinima,
      'potenciaInstalada': potenciaInstalada,
      'quantidadeDePlacas': quantidadeDePlacasInstaladas,
      'producaoMensal': producaoMensal,
      'tempoDePayback': tempoDePayback,
      'economiaAnual': economiaAnual,
    };
  }

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
                        "Faça uma simulação do seu ",
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

                // CEP
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 30),
                  child: TextFormField(
                    controller: _cepController,
                    cursorColor: const Color(0xFF082b59),
                    cursorWidth: 1.5,
                    style: const TextStyle(fontSize: 14, color: Colors.black),
                    decoration: const InputDecoration(
                      hintText: "CEP",
                      prefixIcon: Icon(Icons.share_location),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF082b59),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFFF58934),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      )),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      CepInputFormatter(),
                    ],
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (cargo) =>
                          cargo!.isEmpty ? 'Preencha o campo !' : null,
                    keyboardType: TextInputType.text,
                  ),
                ),


                //Tipo
                Padding(
                  padding:
                      const EdgeInsets.only(left: 15, right: 15, top: 15),
                  child: SizedBox(
                    height: 60,
                    child: DropdownButtonFormField(
                      value: _concessionariaSelecionada,
                      hint: const Text("Selecione a Concessionária"),
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color(0xFFF58934), width: 2),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color(0xFFF58934), width: 2),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                      ),
                      dropdownColor: const Color(0xfffdf0e6),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                      items: _concessionarias.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value, style: font),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _concessionariaSelecionada = newValue;
                        });
                      },
                      style: const TextStyle(
                          fontSize: 14, color: Colors.black),
                    ),
                  ),
                ),


                // Conta de Luz
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: TextFormField(
                      controller: _valorEnergiaController,
                      cursorColor: const Color(0xFF082b59),
                      cursorWidth: 1.5,
                      style: const TextStyle(fontSize: 14, color: Colors.black),
                      decoration: const InputDecoration(
                        hintText: "Valor gasto com a energia",
                        prefixIcon: Icon(Icons.attach_money),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF082b59),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFF58934),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      )),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (cargo) =>
                          cargo!.isEmpty ? 'Preencha o campo !' : null,
                    keyboardType: TextInputType.number,
                    ),
                  ),
                ),

                // Botão
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, bottom: 32),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: SizedBox(
                      width: 200,
                      height: 36,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          overlayColor: MaterialStateProperty.resolveWith<Color?>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.hovered)) return const Color(0xFF082b59);
                              return null;
                            },
                          ),
                        ),
                        child: const Text(
                          "SIMULAR",
                          style: button,
                        ),
                        onPressed: _simular,
                      ),
                    ),
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

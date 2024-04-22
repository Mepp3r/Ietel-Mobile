import 'package:flutter/material.dart';
import 'package:ietel_solar/resultado.page.dart';
import 'styles.dart';

Map<String, double> Concessionarias = {'CPFL': 0.702, 'EDP SP': 0.698, 'ENEL SP': 0.649};

class CalculadoraPage extends StatelessWidget {
  const CalculadoraPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "IETEL Solar",
          style: ietelSolar,
        ),
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
              children: [
                const Padding(
                  padding: EdgeInsets.only(
                    top: 30
                  ),
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
                
                //CEP
                const Padding(
                  padding: EdgeInsets.only(
                    left: 15,
                    right: 15,
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: TextField(
                      cursorColor: Color(0xFF082b59),
                      cursorWidth: 1.5,
                      style: TextStyle(fontSize: 14, color: Colors.black),
                      decoration: InputDecoration(
                        hintText: "CEP",
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
                      ),
                      keyboardType: TextInputType.text,
                    ),
                  ),
                ),

                //Concessionaria
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: DropdownButton<String>(
                    items: <String>['CPFL', 'ENEL SP', 'EDP SP'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child:
                          Text(value, style: font),
                      );
                    }).toList(),
                    onChanged: (_) {},
                  ),
                ),

                //Conta de Luz
                const Padding(
                  padding: EdgeInsets.only(
                    left: 15,
                    right: 15,
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: TextField(
                      cursorColor: Color(0xFF082b59),
                      cursorWidth: 1.5,
                      style: TextStyle(fontSize: 14, color: Colors.black),
                      decoration: InputDecoration(
                        hintText: "Valor gasto com a energia",
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
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ),

                //Botão
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, bottom: 32),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15),
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
                        onPressed: () {
                    
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ResultadoPage()));
                        },
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

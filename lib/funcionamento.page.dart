// ignore_for_file: prefer_const_constructors

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'styles.dart';

class FuncionamentoPage extends StatefulWidget {
  const FuncionamentoPage({super.key});

  @override
  State<FuncionamentoPage> createState() => _FuncionamentoState();
}

class _FuncionamentoState extends State<FuncionamentoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Funcionamento ",
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
                              "ENERGIA SOLAR: ",
                              style: palavraChave,
                            ),
                          ],
                        ),
                      ),

                      Padding(
                        padding:  EdgeInsets.only(
                            top: 30, left: 30, right: 30, bottom: 15),
                        child: Container(
                          // margin: EdgeInsets.all(10),

                          decoration: BoxDecoration(
                            color: const Color(0xfffdf0e6),
                            border: Border.all(color: const Color(0xFFF58934)),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(6),
                            ),
                          ),
                          child: Column(children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  border: Border.all(
                                      color: const Color(0xFFF58934))),
                              child: const Text(
                                overflow: TextOverflow.ellipsis,
                                'O que é?',
                                style: contato,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 20, right: 20),
                              child: const Text(
                                'A Energia Solar Fotovoltaica é obtida a partir da conversão direta da luz emitida pelo sol em eletricidade. Quando as partículas de energia provenientes do Sol (fotóns) incidem sobre os painéis, ocorre a geração de uma corrente elétrica que pode ser direcionada e utilizada tanto nas áreas urbanas, quanto nas rurais.',
                                textAlign: TextAlign.justify,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 20, bottom: 20),
                              decoration: BoxDecoration(
                                color: const Color(0xfffdf0e6),
                                border:
                                    Border.all(color: const Color(0xFFF58934)),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(6),
                                ),
                              ),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                       "images/fabrica_solar.gif",
                                      width: 300,
                                      height: 200,
                                      fit: BoxFit.cover,
                                    ),
                                  ]),
                            ),
                          ]),
                        ),
                      ),

                      // SISTEMA ON-GRID E OFF-GRID

                      Padding(
                        padding:  EdgeInsets.only(
                            top: 15, left: 30, right: 30, bottom: 15),
                        
                        child: Container(
                          // margin: EdgeInsets.all(10),

                          decoration: BoxDecoration(
                            color: const Color(0xfffdf0e6),
                            border: Border.all(color: const Color(0xFFF58934)),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(6),
                            ),
                          ),
                          child: Column(children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  border: Border.all(
                                      color: const Color(0xFFF58934))),
                              child: const Text(
                                overflow: TextOverflow.ellipsis,
                                'Sistema on-grid',
                                style: contato,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 20, right: 20),
                              child: const Text(
                                'Sistema ligado à rede pública de distribuição, na qual o excesso de energia vai para a distribuidora gerando créditos que podem ser usados em até 5 anos. Da mesma maneira, se a produção estiver baixa, a concessionária entra automaticamente para suprir qualquer necessidade. Esse modelo costuma ter um valor de investimento menor.',
                                textAlign: TextAlign.justify,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 20, bottom: 20),
                              decoration: BoxDecoration(
                                color: const Color(0xfffdf0e6),
                                border:
                                    Border.all(color: const Color(0xFFF58934)),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(6),
                                ),
                              ),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      "images/on_grid.gif",
                                      width: 300,
                                      height: 200,
                                      fit: BoxFit.cover,
                                    ),
                                  ]),
                            ),
                          ]),
                        ),
                      ),

                      Padding(
                        padding:  EdgeInsets.only(
                            top: 15, left: 30, right: 30, bottom: 15),
                        child: Container(
                          // margin: EdgeInsets.all(10),

                          decoration: BoxDecoration(
                            color: const Color(0xfffdf0e6),
                            border: Border.all(color: const Color(0xFFF58934)),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(6),
                            ),
                          ),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(10),
                                  margin: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      border: Border.all(
                                          color: const Color(0xFFF58934))),
                                  child: const Text(
                                    overflow: TextOverflow.ellipsis,
                                    'Sistema off-grid',
                                    style: contato,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 20, right: 20),
                                  child: const Text(
                                    'Sistema que utiliza baterias próprias, as quais são responsáveis por armazenar a energia excedente produzida. Possui funcionamento completamente autônomo e um controlador de carga para a proteção dos equipamentos. Assim, abastece os componentes elétricos no local. Esse modelo costuma ter um valor de investimento maior.',
                                    textAlign: TextAlign.justify,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 20, bottom: 20),
                                  decoration: BoxDecoration(
                                    color: const Color(0xfffdf0e6),
                                    border: Border.all(
                                        color: const Color(0xFFF58934)),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(6),
                                    ),
                                  ),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          "images/off_grid.gif",
                                          width: 300,
                                          height: 200,
                                          fit: BoxFit.cover,
                                        ),
                                      ]),
                                ),
                              ]),
                        ),
                      ),

                      // SISTEMA ON-GRID E OFF-GRID final

                      Padding(
                        padding: const EdgeInsets.only(
                            top: 15, left: 30, right: 30, bottom: 15),
                        child: Container(
                            width: 750,
                            decoration: BoxDecoration(
                              color: const Color(0xfffdf0e6),
                              border:
                                  Border.all(color: const Color(0xFFF58934)),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(6),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Container da imagem
                                Container(
                                    margin: const EdgeInsets.only(
                                        top: 20, left: 20, right: 20),
                                    decoration: BoxDecoration(
                                      color: const Color(0xfffdf0e6),
                                      border: Border.all(
                                          color: const Color(0xFFF58934)),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Image.asset(
                                          "images/energia.png",
                                          width: 700,
                                          fit: BoxFit.cover,
                                        ),
                                      ],
                                    )),
                                Container(
                                  margin: EdgeInsets.all(20),
                                  width: 700,
                                  padding: EdgeInsets.all(10),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      border: Border.all(
                                          color: const Color(0xFFF58934))),
                                  child: const Text(
                                    overflow: TextOverflow.ellipsis,
                                    'Vantagens:',
                                    style: contato,
                                  ),
                                ),

                                Container(
                                  margin: EdgeInsets.only(left: 20, right: 20,top: 5),
                                  width: 700,
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      border: Border.all(
                                          color: const Color(0xFFF58934))),
                                  child: const Text(
                                    overflow: TextOverflow.ellipsis,
                                    'Econômica, pois permite redução no valor na conta de luz',
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 20, right: 20,top: 5),
                                  width: 700,
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      border: Border.all(
                                          color: const Color(0xFFF58934))),
                                  child: const Text(
                                    overflow: TextOverflow.ellipsis,
                                    'Segura, com risco de acidentes reduzidos',
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 20, right: 20,top: 5),
                                  width: 700,
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 255, 255, 255),
                                      border: Border.all(
                                          color: const Color(0xFFF58934))),
                                  child: const Text(
                                    overflow: TextOverflow.ellipsis,
                                    'Necessidade de navegação mínima',
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 20, right: 20,top: 5),
                                  width: 700,
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 255, 255, 255),
                                      border: Border.all(
                                          color: const Color(0xFFF58934))),
                                  child: const Text(
                                    overflow: TextOverflow.ellipsis,
                                    'Alta durabilidade',
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 20, right: 20,top: 5,),
                                  width: 700,
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 255, 255, 255),
                                      border: Border.all(
                                          color: const Color(0xFFF58934))),
                                  child: const Text(
                                    overflow: TextOverflow.ellipsis,
                                    'Instalação rápida',
                                  ),
                                ),

                                Container(
                                  margin: const EdgeInsets.only(
                                    left: 20,
                                    right: 20,
                                    top: 5,
                                  ),
                                  width: 700,
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 255, 255, 255),
                                      border: Border.all(
                                          color: const Color(0xFFF58934))),
                                  child: const Text(
                                    overflow: TextOverflow.ellipsis,
                                    'Sustentável',
                                  ),
                                ),

                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 20, right: 20, bottom: 20,top: 5),
                                  width: 700,
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 255, 255, 255),
                                      border: Border.all(
                                          color: const Color(0xFFF58934))),
                                  child: const Text(
                                    overflow: TextOverflow.ellipsis,
                                    'Renovável',
                                  ),
                                ),
                              ],
                            )),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(
                          top: 15,
                          bottom: 30,
                          left: 30,
                          right: 30,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xfffdf0e6),
                            border: Border.all(color: const Color(0xFFF58934)),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(6),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(
                                    left: 20, right: 20, bottom: 20, top: 20),
                                width: 700,
                                padding: const EdgeInsets.all(10),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 255, 255, 255),
                                    border: Border.all(
                                        color: const Color(0xFFF58934))),
                                child: const Text(
                                  overflow: TextOverflow.ellipsis,
                                  'Projetos',
                                  style: contato,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                    left: 20, right: 20, bottom: 20, top: 20),
                                width: 700,
                                height: 200,
                                padding: const EdgeInsets.all(10),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 255, 255, 255),
                                    border: Border.all(
                                        color: const Color(0xFFF58934))),
                                child: CarouselSlider(
                                  options: CarouselOptions(height: 500),
                                  items: [
                                    'images/img_casa.png',
                                    'images/img_conversor.png',
                                    'images/img_placa_solar1.png',
                                    'images/img_placa_solar2.png',
                                    'images/img_placa_solar3.png',
                                  ].map((i) {
                                    return Builder(
                                        builder: (BuildContext context) {
                                      return Container(
                                        padding: EdgeInsets.all(10),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 5.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(i,
                                          fit: BoxFit.cover,)
                                          ],
                                        ),
                                      );
                                    });
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ));
  }
}

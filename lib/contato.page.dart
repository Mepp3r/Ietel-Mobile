// ignore_for_file: prefer_const_constructors, unnecessary_const

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'styles.dart';

class ContatoPage extends StatelessWidget {
  const ContatoPage({super.key});

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
          Center(
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
                      padding: EdgeInsets.only(top: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Entre em ",
                            style: titulo,
                          ),
                          Text(
                            "Contato ",
                            style: palavraChave,
                          ),
                          Text(
                            "conosco:",
                            style: titulo,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 30, left: 15, right: 15),
                      child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xfffdf0e6),
                            border: Border.all(color: const Color(0xFFF58934)),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(6),
                            ),
                          ),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(top: 15),
                                  child: Text("Matriz em Potirendaba - SP",
                                      style: contato),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 15, left: 30, right: 30, bottom: 15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.all(1),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFF58934),
                                            border: Border.all(
                                                color: const Color(0xFFF58934)),
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(6),
                                            ),
                                          ),
                                          child: SizedBox(
                                            height: 200,
                                            child: FlutterMap(
                                              options: const MapOptions(
                                                initialCenter: LatLng(
                                                  -21.04786557408915,
                                                  -49.36682122539187,
                                                ),
                                                initialZoom: 17.2,
                                               interactionOptions:
                                                      InteractionOptions(
                                                          flags: InteractiveFlag
                                                                  .all &
                                                              ~InteractiveFlag
                                                                  .rotate)
                                              ),
                                              children: [
                                                TileLayer(
                                                  urlTemplate:
                                                      'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                                  userAgentPackageName:
                                                      'com.example.app',
                                                ),
                                                MarkerLayer(
                                                  markers: [
                                                    Marker(
                                                      width: 80.0,
                                                      height: 80.0,
                                                      point: const LatLng(
                                                          -21.04786557408915,
                                                          -49.36682122539187), // Localização do marcador
                                                      child: Container(
                                                        child: const Icon(
                                                          Icons.location_pin,
                                                          color: const Color
                                                              .fromARGB(
                                                              255, 255, 17, 0),
                                                          size: 40,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(bottom: 8),
                                  child: Icon(
                                    Icons.phone,
                                    color: Colors.black,
                                    size: 24.0,
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(bottom: 15),
                                  child: Text(
                                      "Telefones: (17) 98139-2242 e (17) 3249-1065",
                                      style: contato),
                                ),
                              ])),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 30, left: 15, right: 15),
                      child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xfffdf0e6),
                            border: Border.all(color: const Color(0xFFF58934)),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(6),
                            ),
                          ),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(top: 15),
                                  child: Text("Filial em Potirendaba - SP",
                                      style: contato),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 15, left: 30, right: 30, bottom: 15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.all(1),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFF58934),
                                            border: Border.all(
                                                color: const Color(0xFFF58934)),
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(6),
                                            ),
                                          ),
                                          child: SizedBox(
                                            height: 200,
                                            child: FlutterMap(
                                              options: const MapOptions(
                                                  initialCenter: LatLng(
                                                    -21.041696347108733,
                                                    -49.38010003047861,
                                                  ),
                                                  initialZoom: 17.2,
                                                  interactionOptions:
                                                      InteractionOptions(
                                                          flags: InteractiveFlag
                                                                  .all &
                                                              ~InteractiveFlag
                                                                  .rotate)),
                                              children: [
                                                TileLayer(
                                                  urlTemplate:
                                                      'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                                  userAgentPackageName:
                                                      'com.example.app',
                                                ),
                                                MarkerLayer(
                                                  markers: [
                                                    Marker(
                                                      width: 80.0,
                                                      height: 80.0,
                                                      point: const LatLng(
                                                          -21.041696347108733,
                                                          -49.38010003047861), // Localização do marcador
                                                      child: Container(
                                                        child: const Icon(
                                                          Icons.location_pin,
                                                          color: Color.fromARGB(
                                                              255, 255, 17, 0),
                                                          size: 40,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(bottom: 8),
                                  child: Icon(
                                    Icons.phone,
                                    color: Colors.black,
                                    size: 24.0,
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(bottom: 15),
                                  child: Text(
                                      "Telefones: (17) 98139-2242 e (17) 3249-1065",
                                      style: contato),
                                ),
                              ])),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 30, left: 15, right: 15),
                      child: Container(
                        margin: EdgeInsets.only(bottom: 30),
                        decoration: BoxDecoration(
                          color: const Color(0xfffdf0e6),
                          border: Border.all(color: const Color(0xFFF58934)),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(6),
                          ),
                        ),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(top: 15),
                                child: Text(
                                    "Filial em São José do Rio Preto - SP",
                                    style: contato),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 15, left: 30, right: 30, bottom: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        padding: EdgeInsets.all(1),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFF58934),
                                          border: Border.all(
                                              color: const Color(0xFFF58934)),
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(6),
                                          ),
                                        ),
                                        child: SizedBox(
                                          height: 200,
                                          child: FlutterMap(
                                            options: MapOptions(
                                              initialCenter: LatLng(
                                                -20.839346267267395,
                                                -49.37777652539932,
                                              ),
                                              initialZoom: 17.2,
                                              interactionOptions:
                                                      InteractionOptions(
                                                          flags: InteractiveFlag
                                                                  .all &
                                                              ~InteractiveFlag
                                                                  .rotate)
                                            ),
                                            children: [
                                              TileLayer(
                                                urlTemplate:
                                                    'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                                userAgentPackageName:
                                                    'com.example.app',
                                              ),
                                              MarkerLayer(
                                                markers: [
                                                  Marker(
                                                    width: 80.0,
                                                    height: 80.0,
                                                    point: const LatLng(
                                                        -20.839346267267395,
                                                        -49.37777652539932), // Localização do marcador
                                                    child: Container(
                                                      child: Icon(
                                                        Icons.location_pin,
                                                        color: Color.fromARGB(
                                                            255, 255, 17, 0),
                                                        size: 40,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: 15),
                                child: Icon(
                                  Icons.phone,
                                  color: Colors.black,
                                  size: 24.0,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: 15),
                                child: Text(
                                    "Telefones:(17) 98139-2242 e (17) 3226-4007",
                                    style: contato),
                              ),
                            ]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

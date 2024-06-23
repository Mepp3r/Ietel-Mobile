// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ietel_solar/cadastraCandidatos.page.dart';
import 'styles.dart';

class ListaVagasPage extends StatelessWidget {
  ListaVagasPage({super.key});

  final firestore = FirebaseFirestore.instance;

  void _telaCadastraCandidatos(BuildContext context, id_vaga) {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => CadastraCandidatosPage(id_vaga: id_vaga)));
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
      body: Padding(
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
                      "Lista de ",
                      style: titulo,
                    ),
                    Text(
                      "Vagas",
                      style: palavraChave,
                    ),
                    Text(
                      ":",
                      style: titulo,
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      stream: firestore
                          .collection('vagas')
                          .orderBy('cargo')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const CircularProgressIndicator();
                        }

                        var docs = snapshot.data!.docs;

                        return SizedBox(
                          height: 600,
                          child: ListView(children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: docs
                                  .map(
                                    (doc) => Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15, right: 15, top: 20),
                                      child: InkWell(
                                        onTap: () =>
                                            _telaCadastraCandidatos(context, doc.id),
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.9,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                              color: const Color(0xFFF58934),
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(6),
                                            ),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.all(15.0),
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: 10),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        doc['cargo'],
                                                        style: listaTitulo,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: 10),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        doc['modelo'] +
                                                            ' - ' +
                                                            doc['tipo'],
                                                        style: lista,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: 10),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        doc['local'],
                                                        style: listaSubtitulo,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(Icons.arrow_right,
                                                        color:
                                                            Color(0xFF082b59)),
                                                    Text(
                                                      "Descrição:",
                                                      style: listaDescricao,
                                                    ),
                                                  ],
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 10, left: 20),
                                                  child: Row(
                                                    children: [
                                                      SizedBox(
                                                        width: 300,
                                                        child: Text(
                                                          doc['descricao'],
                                                          style: lista,
                                                          textAlign:
                                                              TextAlign.justify,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ]),
                        );
                      }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

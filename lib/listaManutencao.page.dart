import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'styles.dart';

class ListaManuntencao extends StatelessWidget {
  ListaManuntencao({super.key});

  final firestore = FirebaseFirestore.instance;

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
                      "Manutenções",
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
                          .collection('manutencao')
                          .orderBy('dia')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const CircularProgressIndicator();
                        }

                        var docs = snapshot.data!.docs;

                        return SizedBox(
                          height: 600,
                          child: ListView(children: [
                            Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: docs
                                    .map(
                                      (doc) => Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15, right: 15, top: 20),
                                        child: InkWell(
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
                                              padding: const EdgeInsets.all(15.0),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        doc['nome'],
                                                        style: listaTitulo,
                                                      )
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                        top: 10),
                                                    child: Row(
                                                      children: [
                                                        Flexible(
                                                            child: Column(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                const Text(
                                                                  'CPF: ',
                                                                  style:
                                                                      listaCampos,
                                                                ),
                                                                Text(
                                                                  doc['cpf'],
                                                                  style: lista,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .justify,
                                                                ),
                                                              ],
                                                            )
                                                          ],
                                                        )),
                                                        Flexible(
                                                          child: Column(
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  const Text(
                                                                    "Telefone: ",
                                                                    style:
                                                                        listaCampos,
                                                                  ),
                                                                  Text(
                                                                    doc['telefone'],
                                                                    style:
                                                                        lista,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .justify,
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                        top: 15),
                                                    child: Row(
                                                      children: [
                                                        Flexible(
                                                          child: Column(
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  const Text(
                                                                    "Bairro: ",
                                                                    style:
                                                                        listaCampos,
                                                                  ),
                                                                  Text(
                                                                    doc['bairro'],
                                                                    style:
                                                                        lista,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .justify,
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Flexible(
                                                          child: Column(
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  const Text(
                                                                    "Número: ",
                                                                    style:
                                                                        listaCampos,
                                                                  ),
                                                                  Text(
                                                                    doc['número'],
                                                                    style:
                                                                        lista,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .justify,
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                        top: 15),
                                                    child: Row(
                                                      children: [
                                                        Flexible(
                                                          child: Column(
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  const Text(
                                                                    "CEP: ",
                                                                    style:
                                                                        listaCampos,
                                                                  ),
                                                                  Text(
                                                                    doc['cep'],
                                                                    style:
                                                                        lista,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .justify,
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Flexible(
                                                          child: Column(
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  const Text(
                                                                    "Cidade: ",
                                                                    style:
                                                                        listaCampos,
                                                                  ),
                                                                  Text(
                                                                    doc['cidade'],
                                                                    style:
                                                                        lista,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .justify,
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                        top: 15),
                                                    child: Row(
                                                      children: [
                                                        Flexible(
                                                          child: Column(
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  const Text(
                                                                    "Data: ",
                                                                    style:
                                                                        listaCampos,
                                                                  ),
                                                                  Text(
                                                                    doc['dia'],
                                                                    style:
                                                                        lista,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .justify,
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Flexible(
                                                          child: Column(
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  const Text(
                                                                    "Horário: ",
                                                                    style:
                                                                        listaCampos,
                                                                  ),
                                                                  Text(
                                                                    doc['hora'],
                                                                    style:
                                                                        lista,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .justify,
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
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

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, prefer_typing_uninitialized_variables, must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'styles.dart';

class ListaCandidatosPage extends StatelessWidget {
  var id_vaga;
  ListaCandidatosPage({required this.id_vaga, super.key});

  final firestore = FirebaseFirestore.instance;

    void mostrarImagem(BuildContext context, arquivo) async {

    if (await canLaunchUrl(Uri.parse(arquivo))) {

      await launchUrl(Uri.parse(arquivo));

    } else {

      const snackBar = SnackBar(
        content: Text('Não foi possível realizar o download !'),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
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
                      "Candidatos",
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
                          .collection('candidatos')
                          .where('id_vaga', isEqualTo: id_vaga)
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
                                        child: Container(
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
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      doc['nome'],
                                                      style: listaTitulo,
                                                    )
                                                  ],
                                                ),
                                                Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 15),
                                                  child: Row(
                                                    children: [
                                                      Flexible(
                                                        child: Column(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  "CPF: ",
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
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Flexible(
                                                        child: Column(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  "Telefone: ",
                                                                  style:
                                                                      listaCampos,
                                                                ),
                                                                Text(
                                                                  doc['telefone'],
                                                                  style: lista,
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
                                                  padding:
                                                      EdgeInsets.only(top: 15),
                                                  child: Row(
                                                    children: [
                                                      Flexible(
                                                        child: Column(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  "Cidade: ",
                                                                  style:
                                                                      listaCampos,
                                                                ),
                                                                Text(
                                                                  doc['cidade'],
                                                                  style: lista,
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
                                                                Text(
                                                                  "Currículo: ",
                                                                  style:
                                                                      listaCampos,
                                                                ),
                                                                InkWell(
                                                                  onTap: () =>
                                                                      mostrarImagem(
                                                                          context,
                                                                          doc['url']),
                                                                  child: Text(
                                                                    doc['curriculo'],
                                                                    style:
                                                                        listaCurriculo,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .justify,
                                                                  ),
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
                                                  padding:
                                                      EdgeInsets.only(top: 15),
                                                  child: Row(
                                                    children: [
                                                      SizedBox(
                                                        width: 300,
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              "LinkedIn: ",
                                                              style:
                                                                  listaCampos,
                                                            ),
                                                            Text(
                                                              doc['linkedin'],
                                                              style: lista,
                                                              textAlign:
                                                                  TextAlign
                                                                      .justify,
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 15),
                                                  child: Row(
                                                    children: [
                                                      SizedBox(
                                                        width: 300,
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              "E-mail: ",
                                                              style:
                                                                  listaCampos,
                                                            ),
                                                            Text(
                                                              doc['email'],
                                                              style: lista,
                                                              textAlign:
                                                                  TextAlign
                                                                      .justify,
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 15),
                                                  child: Row(
                                                    children: [
                                                      SizedBox(
                                                        width: 300,
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              "Mensagem: ",
                                                              style:
                                                                  listaCampos,
                                                            ),
                                                            Text(
                                                              doc['mensagem'],
                                                              style: lista,
                                                              textAlign:
                                                                  TextAlign
                                                                      .justify,
                                                            ),
                                                          ],
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
                                    )
                                    .toList(),
                              ),
                            ]));
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

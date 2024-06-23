// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ietel_solar/os/editarOrdemDeServico.dart';
import 'package:ietel_solar/os/ordemDeServico.page.dart';
import 'package:ietel_solar/styles.dart';


class ListaOrdemDeServico extends StatelessWidget {
  ListaOrdemDeServico({super.key});

  final firestore = FirebaseFirestore.instance;
  
  void _OS(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => OrdemDeServicoPage()));
  }
  void _EditarOS(
      BuildContext context, id, cliente, cpf, telefone, endereco, tecnico, motivo, diagnostico, solucao) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => EditarOrdemDeServicoPage(
                  id: id,
                  cliente: cliente,
                  cpf: cpf,
                  telefone: telefone,
                  endereco: endereco,
                  tecnico: tecnico,
                  motivo: motivo,
                  diagnostico: diagnostico,
                  solucao: solucao
                )));
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFF58934),
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () => _OS(context),
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
                      "Ordem de Serviço",
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
                          .collection('os')
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
                                      child:
                                      Container(
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
                                                        doc['cliente'],
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
                                                        "CPF: ",
                                                        style: listaCampos,
                                                        ),
                                                      Text(
                                                        doc['cpf'],
                                                        style: lista
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
                                                        "Telefone: ",
                                                        style: listaCampos,
                                                        ),
                                                      Text(
                                                        doc['telefone'],
                                                        style: lista
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
                                                        "Endereço: ",
                                                        style: listaCampos,
                                                        ),
                                                      Text(
                                                        doc['endereco'],
                                                        style: lista
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
                                                        "Tecnico: ",
                                                        style: listaCampos,
                                                        ),
                                                      Text(
                                                        doc['tecnico'],
                                                        style: lista
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
                                                        "Motivo: ",
                                                        style: listaCampos,
                                                        ),
                                                      Text(
                                                        doc['motivo'],
                                                        style: lista
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
                                                        "Diagnostico: ",
                                                        style: listaCampos,
                                                        ),
                                                      Text(
                                                        doc['diagnostico'],
                                                        style: lista
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
                                                        "Solução: ",
                                                        style: listaCampos,
                                                        ),
                                                      Text(
                                                        doc['solucao'],
                                                        style: lista
                                                      )
                                                      
                                                    ],
                                                    
                                                  ),
                                                  
                                                  
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    left: 20),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                right: 40),
                                                        child: IconButton(
                                                          icon: Icon(
                                                              Icons.edit_note,
                                                              color: Color(
                                                                  0xFF082b59)),
                                                          iconSize: 30,
                                                          onPressed: () =>
                                                             _EditarOS(
                                                                  context,
                                                                  doc.id,
                                                                  doc['cliente'],
                                                                  doc['cpf'],
                                                                  doc['telefone'],
                                                                  doc['endereco'],
                                                                  doc['tecnico'],
                                                                  doc['motivo'],
                                                                  doc['diagnostico'],
                                                                  doc['solucao'],
                                                                ),
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

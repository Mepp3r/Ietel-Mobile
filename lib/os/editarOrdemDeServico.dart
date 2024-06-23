// ignore_for_file: curly_braces_in_flow_control_structures, must_be_immutable, prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ietel_solar/styles.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/services.dart';

class EditarOrdemDeServicoPage extends StatefulWidget {
  var id, cliente, cpf, telefone, endereco, tecnico, motivo, diagnostico, solucao;
  EditarOrdemDeServicoPage({
    required this.id,
    required this.cliente,
    required this.cpf,
    required this.telefone,
    required this.endereco,
    required this.tecnico,
    required this.motivo,
    required this.diagnostico,
    required this.solucao,
    super.key,
  });

  @override
  State<EditarOrdemDeServicoPage> createState() => _EditarOrdemDeServicoState();
}

class _EditarOrdemDeServicoState extends State<EditarOrdemDeServicoPage> {
  final _formKey = GlobalKey<FormState>();

  void _onSaved(BuildContext context) {
    if (widget.motivo.isEmpty || widget.diagnostico.isEmpty || widget.solucao.isEmpty 
    || widget.tecnico.isEmpty || widget.cliente.isEmpty || widget.endereco.isEmpty) {
      const snackBar = SnackBar(
        content: Text('Preencha todos os campos !'),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      FirebaseFirestore.instance
          .collection('os')
          .doc(widget.id)
          .set({
        'cliente': widget.cliente,
        'cpf': widget.cpf,
        'telefone': widget.telefone,
        'endereco': widget.endereco,
        'tecnico': widget.tecnico,
        'motivo': widget.motivo,
        'diagnostico': widget.diagnostico,
        'solucao': widget.solucao,
      });

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Alteração realizada com sucesso !'),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      ));

      Navigator.pop(context);
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
      body: ListView(
        children: [
          Center(
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
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Altere a ",
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

                      //Cargo
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 15, right: 15, top: 20),
                        child: TextFormField(
                          initialValue: widget.cliente,
                          onChanged: (String? novoItemSelecionado) {
                            setState(() {
                              widget.cliente = novoItemSelecionado!;
                            });
                          },
                          cursorColor: const Color(0xFF082b59),
                          cursorWidth: 1.5,
                          style: const TextStyle(
                              fontSize: 14, color: Colors.black),
                          decoration: const InputDecoration(
                              hintText: "Cliente",
                            prefixIcon: Icon(Icons.person),
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
                          validator: (cliente) =>
                              cliente!.isEmpty ? 'Preencha o campo !' : null,
                          keyboardType: TextInputType.text,
                        ),
                      ),

                      //Tipo
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 15, right: 15, top: 20),
                        child: TextFormField(
                          initialValue: widget.cpf,
                          onChanged: (String? novoItemSelecionado) {
                            setState(() {
                              widget.cpf = novoItemSelecionado!;
                            });
                          },
                          cursorColor: const Color(0xFF082b59),
                          cursorWidth: 1.5,
                          style: const TextStyle(
                              fontSize: 14, color: Colors.black),
                          decoration: const InputDecoration(
                              hintText: "CPF",
                            prefixIcon: Icon(Icons.portrait),
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
                                CpfInputFormatter(),
                              ],
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (cpf) =>
                              cpf!.isEmpty ? 'Preencha o campo !' : null,
                          keyboardType: TextInputType.text,
                        ),
                      ),

                      //Local
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 15, right: 15, top: 15),
                        child: TextFormField(
                          initialValue: widget.telefone,
                          onChanged: (String? novoItemSelecionado) {
                            setState(() {
                              widget.telefone = novoItemSelecionado!;
                            });
                          },
                          cursorColor: const Color(0xFF082b59),
                          cursorWidth: 1.5,
                          style: const TextStyle(
                              fontSize: 14, color: Colors.black),
                          decoration: const InputDecoration(
                              hintText: "Telefone",
                            prefixIcon: Icon(Icons.local_phone),
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
                          validator: (telefone) =>
                              telefone!.isEmpty ? 'Preencha o campo !' : null,
                          keyboardType: TextInputType.text,
                        ),
                      ),

                      //Modelo
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 15, right: 15, top: 20),
                        child: TextFormField(
                          initialValue: widget.endereco,
                          onChanged: (String? novoItemSelecionado) {
                            setState(() {
                              widget.endereco = novoItemSelecionado!;
                            });
                          },
                          cursorColor: const Color(0xFF082b59),
                          cursorWidth: 1.5,
                          style: const TextStyle(
                              fontSize: 14, color: Colors.black),
                          decoration: const InputDecoration(
                              hintText: "Endereço",
                            prefixIcon: Icon(Icons.location_city),
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
                          validator: (endereco) =>
                              endereco!.isEmpty ? 'Preencha o campo !' : null,
                          keyboardType: TextInputType.text,
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 15, right: 15, top: 20),
                        child: TextFormField(
                          initialValue: widget.tecnico,
                          onChanged: (String? novoItemSelecionado) {
                            setState(() {
                              widget.tecnico = novoItemSelecionado!;
                            });
                          },
                          cursorColor: const Color(0xFF082b59),
                          cursorWidth: 1.5,
                          style: const TextStyle(
                              fontSize: 14, color: Colors.black),
                          decoration: const InputDecoration(
                              hintText: "Tecnico",
                            prefixIcon: Icon(Icons.engineering),
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
                          validator: (tecnico) =>
                              tecnico!.isEmpty ? 'Preencha o campo !' : null,
                          keyboardType: TextInputType.text,
                        ),
                      ),
                      //Descrição
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 15, right: 15, top: 20),
                        child: TextFormField(
                          initialValue: widget.motivo,
                          onChanged: (String? novoItemSelecionado) {
                            setState(() {
                              widget.motivo = novoItemSelecionado!;
                            });
                          },
                          cursorColor: const Color(0xFF082b59),
                          cursorWidth: 1.5,
                          style: const TextStyle(
                              fontSize: 14, color: Colors.black),
                          decoration: const InputDecoration(
                              hintText: "Motivo",
                            prefixIcon: Icon(Icons.question_mark),
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
                          validator: (motivo) =>
                              motivo!.isEmpty ? 'Preencha o campo !' : null,
                          keyboardType: TextInputType.text,
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 15, right: 15, top: 20),
                        child: TextFormField(
                          initialValue: widget.diagnostico,
                          onChanged: (String? novoItemSelecionado) {
                            setState(() {
                              widget.diagnostico = novoItemSelecionado!;
                            });
                          },
                          cursorColor: const Color(0xFF082b59),
                          cursorWidth: 1.5,
                          style: const TextStyle(
                              fontSize: 14, color: Colors.black),
                          decoration: const InputDecoration(
                              hintText: "Diagnostico",
                            prefixIcon: Icon(Icons.content_paste_search),
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
                          validator: (diagonistco) =>
                              diagonistco!.isEmpty ? 'Preencha o campo !' : null,
                          keyboardType: TextInputType.text,
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 15, right: 15, top: 20),
                        child: TextFormField(
                          initialValue: widget.solucao,
                          onChanged: (String? novoItemSelecionado) {
                            setState(() {
                              widget.solucao = novoItemSelecionado!;
                            });
                          },
                          cursorColor: const Color(0xFF082b59),
                          cursorWidth: 1.5,
                          style: const TextStyle(
                              fontSize: 14, color: Colors.black),
                          decoration: const InputDecoration(
                              hintText: "Solução",
                            prefixIcon: Icon(Icons.tips_and_updates),
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
                          validator: (solucao) =>
                              solucao!.isEmpty ? 'Preencha o campo !' : null,
                          keyboardType: TextInputType.text,
                        ),
                      ),
                      //Botão
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 15, right: 15, top: 30),
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
                              overlayColor:
                                  MaterialStateProperty.resolveWith<Color?>(
                                (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.hovered))
                                    return const Color(0xFF082b59);
                                  return null;
                                },
                              ),
                            ),
                            child: const Text(
                              "ALTERAR",
                              style: button,
                            ),
                            onPressed: () => _onSaved(context),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

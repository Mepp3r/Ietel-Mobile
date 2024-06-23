// ignore_for_file: curly_braces_in_flow_control_structures, must_be_immutable, prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'styles.dart';

var _modelos = ['Tempo Integral', 'Estágio', 'Meio Período', 'Trainee'];

var _tipos = ['Presencial', 'Online', 'Híbrido'];

class AlteraVagasPage extends StatefulWidget {
  var id, cargo, tipo, local, modelo, descricao;
  AlteraVagasPage({
    required this.id,
    required this.cargo,
    required this.tipo,
    required this.local,
    required this.modelo,
    required this.descricao,
    super.key
  });

  @override
  State<AlteraVagasPage> createState() => _AlteraVagasState();
}

class _AlteraVagasState extends State<AlteraVagasPage> {
  final _formKey = GlobalKey<FormState>();

  void _onSaved(BuildContext context) {
    if (widget.cargo.isEmpty || widget.local.isEmpty || widget.descricao.isEmpty) {
      const snackBar = SnackBar(
        content: Text('Preencha todos os campos !'),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      FirebaseFirestore.instance
          .collection('vagas')
          .doc(widget.id)
          .set({
        'cargo': widget.cargo,
        'tipo': widget.tipo,
        'local': widget.local,
        'modelo': widget.modelo,
        'descricao': widget.descricao
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
                              "Vaga",
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
                          initialValue: widget.cargo,
                          onChanged: (String? novoItemSelecionado) {
                            setState(() {
                              widget.cargo = novoItemSelecionado!;
                            });
                          },
                          cursorColor: const Color(0xFF082b59),
                          cursorWidth: 1.5,
                          style: const TextStyle(
                              fontSize: 14, color: Colors.black),
                          decoration: const InputDecoration(
                              hintText: "Cargo",
                            prefixIcon: Icon(Icons.business_center),
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
                            items: _tipos.map((String dropDownStringItem) {
                              return DropdownMenuItem(
                                  value: dropDownStringItem,
                                  child: Text(dropDownStringItem));
                            }).toList(),
                            onChanged: (var novoItemSelecionado) {
                              setState(() {
                                widget.tipo = novoItemSelecionado;
                              });
                            },
                            value: widget.tipo,
                            style: const TextStyle(
                                fontSize: 14, color: Colors.black),
                          ),
                        ),
                      ),

                      //Local
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 15, right: 15, top: 15),
                        child: TextFormField(
                          initialValue: widget.local,
                          onChanged: (String? novoItemSelecionado) {
                            setState(() {
                              widget.local = novoItemSelecionado!;
                            });
                          },
                          cursorColor: const Color(0xFF082b59),
                          cursorWidth: 1.5,
                          style: const TextStyle(
                              fontSize: 14, color: Colors.black),
                          decoration: const InputDecoration(
                              hintText: "Local",
                            prefixIcon: Icon(Icons.add_location),
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
                          validator: (local) =>
                              local!.isEmpty ? 'Preencha o campo !' : null,
                          keyboardType: TextInputType.text,
                        ),
                      ),

                      //Modelo
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 15, right: 15, top: 15),
                        child: SizedBox(
                          height: 60,
                          child: DropdownButtonFormField(
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
                            items: _modelos.map((String dropDownStringItem) {
                              return DropdownMenuItem(
                                  value: dropDownStringItem,
                                  child: Text(dropDownStringItem));
                            }).toList(),
                            onChanged: (var novoItemSelecionado) {
                              setState(() {
                                widget.modelo = novoItemSelecionado;
                              });
                            },
                            value: widget.modelo,
                            style: const TextStyle(
                                fontSize: 14, color: Colors.black),
                          ),
                        ),
                      ),

                      //Descrição
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 15, right: 15, top: 15),
                        child: TextFormField(
                          initialValue: widget.descricao,
                          onChanged: (String? novoItemSelecionado) {
                            setState(() {
                              widget.descricao = novoItemSelecionado!;
                            });
                          },
                          minLines: 5,
                          maxLines: 5,
                          cursorColor: const Color(0xFF082b59),
                          cursorWidth: 1.5,
                          style: const TextStyle(
                              fontSize: 14, color: Colors.black),
                          decoration: const InputDecoration(
                              hintText: "Descrição",
                            prefixIcon: Icon(Icons.description),
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
                          validator: (descricao) =>
                              descricao!.isEmpty ? 'Preencha o campo !' : null,
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

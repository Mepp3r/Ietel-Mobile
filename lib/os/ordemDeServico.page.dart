// ignore_for_file: sort_child_properties_last, curly_braces_in_flow_control_structures, prefer_const_constructors, must_be_immutable, non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'package:brasil_fields/brasil_fields.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ietel_solar/styles.dart';

var _txtCliente = '';
var _txtCPF = '';
var _txtTelefone = '';
var _txtEndereco = '';
var _txtTecnico = '';
var _txtMotivo = '';
var _txtDiagnostico = '';
var _txtSolucao = '';


class OrdemDeServicoPage extends StatefulWidget {
  var id_os;
  OrdemDeServicoPage({super.key});

  @override
  State<OrdemDeServicoPage> createState() => _CadastraCandidatosState();
}

class _CadastraCandidatosState extends State<OrdemDeServicoPage> {
  final _formKey = GlobalKey<FormState>();

  FirebaseStorage storage = FirebaseStorage.instance;

  Future _onSaved(BuildContext context) async {
    if (_txtCliente.isEmpty ||
        _txtCPF.isEmpty ||
        _txtTelefone.isEmpty ||
        _txtTelefone.isEmpty ||
        _txtEndereco.isEmpty ||
        _txtTecnico.isEmpty ||
        _txtMotivo.isEmpty ||
        _txtDiagnostico.isEmpty ||
        _txtSolucao.isEmpty) {
      const snackBar = SnackBar(
        content: Text('Preencha todos os campos !'),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      try {

        FirebaseFirestore.instance.collection('os').add({
          'cliente': _txtCliente,
          'cpf': _txtCPF,
          'telefone': _txtTelefone,
          'endereco': _txtEndereco,
          'tecnico': _txtTecnico,
          'motivo': _txtMotivo,
          'diagnostico': _txtDiagnostico,
          'solucao': _txtSolucao
        });

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Cadastro realizado com sucesso !'),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
        ));

        Navigator.pop(context);
      } catch (e) {
        const snackBar = SnackBar(
          content: Text('Erro ! Tente novamente mais tarde...'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
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
          Padding(
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
                            "Cadastrar",
                            style: titulo,
                          ),
                          Text(
                            " Ordem de Serviço",
                            style: palavraChave,
                          ),
                          Text(
                            ":",
                            style: titulo,
                          ),
                        ],
                      ),
                    ),

                    //Nome
                    Padding(
                      padding: EdgeInsets.only(left: 15, right: 15, top: 20),
                      child: TextFormField(
                        onChanged: (String? novoItemSelecionado) {
                          setState(() {
                            _txtCliente = novoItemSelecionado!;
                          });
                        },
                        cursorColor: Color(0xFF082b59),
                        cursorWidth: 1.5,
                        style: TextStyle(fontSize: 14, color: Colors.black),
                        decoration: InputDecoration(
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
                          ),
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (nome) =>
                            nome!.isEmpty ? 'Preencha o campo !' : null,
                        keyboardType: TextInputType.text,
                      ),
                    ),

                    //CPF
                    Padding(
                      padding: EdgeInsets.only(left: 15, right: 15, top: 15),
                      child: TextFormField(
                        onChanged: (String? novoItemSelecionado) {
                          setState(() {
                            _txtCPF = novoItemSelecionado!;
                          });
                        },
                        cursorColor: Color(0xFF082b59),
                        cursorWidth: 1.5,
                        style: TextStyle(fontSize: 14, color: Colors.black),
                        decoration: InputDecoration(
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
                          ),
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          CpfInputFormatter(),
                        ],
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (cpf) =>
                            cpf!.isEmpty ? 'Preencha o campo !' : null,
                        keyboardType: TextInputType.number,
                      ),
                    ),

                    //Telefone
                    Padding(
                      padding: EdgeInsets.only(left: 15, right: 15, top: 15),
                      child: TextFormField(
                        onChanged: (String? novoItemSelecionado) {
                          setState(() {
                            _txtTelefone = novoItemSelecionado!;
                          });
                        },
                        cursorColor: Color(0xFF082b59),
                        cursorWidth: 1.5,
                        style: TextStyle(fontSize: 14, color: Colors.black),
                        decoration: InputDecoration(
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
                          ),
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          TelefoneInputFormatter(),
                        ],
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (telefone) =>
                            telefone!.isEmpty ? 'Preencha o campo !' : null,
                        keyboardType: TextInputType.number,
                      ),
                    ),

                    //Cidade
                    Padding(
                      padding: EdgeInsets.only(left: 15, right: 15, top: 15),
                      child: TextFormField(
                        onChanged: (String? novoItemSelecionado) {
                          setState(() {
                            _txtEndereco = novoItemSelecionado!;
                          });
                        },
                        cursorColor: Color(0xFF082b59),
                        cursorWidth: 1.5,
                        style: TextStyle(fontSize: 14, color: Colors.black),
                        decoration: InputDecoration(
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
                          ),
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (cidade) =>
                            cidade!.isEmpty ? 'Preencha o campo !' : null,
                        keyboardType: TextInputType.text,
                      ),
                    ),

                    //E-mail
                    Padding(
                      padding: EdgeInsets.only(left: 15, right: 15, top: 15),
                      child: TextFormField(
                        onChanged: (String? novoItemSelecionado) {
                          setState(() {
                            _txtTecnico = novoItemSelecionado!;
                          });
                        },
                        cursorColor: Color(0xFF082b59),
                        cursorWidth: 1.5,
                        style: TextStyle(fontSize: 14, color: Colors.black),
                        decoration: InputDecoration(
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
                          ),
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (tecnico) =>
                            tecnico!.isEmpty ? 'Preencha o campo !' : null,
                        keyboardType: TextInputType.text,
                      ),
                    ),

                    //LinkedIn
                    Padding(
                      padding: EdgeInsets.only(left: 15, right: 15, top: 15),
                      child: TextFormField(
                        onChanged: (String? novoItemSelecionado) {
                          setState(() {
                            _txtMotivo = novoItemSelecionado!;
                          });
                        },
                        cursorColor: Color(0xFF082b59),
                        cursorWidth: 1.5,
                        style: TextStyle(fontSize: 14, color: Colors.black),
                        decoration: InputDecoration(
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
                          ),
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (linkedin) =>
                            linkedin!.isEmpty ? 'Preencha o campo !' : null,
                        keyboardType: TextInputType.text,
                      ),
                    ),
                    
                    Padding(
                      padding: EdgeInsets.only(left: 15, right: 15, top: 15),
                      child: TextFormField(
                        onChanged: (String? novoItemSelecionado) {
                          setState(() {
                            _txtDiagnostico = novoItemSelecionado!;
                          });
                        },
                        cursorColor: Color(0xFF082b59),
                        cursorWidth: 1.5,
                        style: TextStyle(fontSize: 14, color: Colors.black),
                        decoration: InputDecoration(
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
                          ),
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (linkedin) =>
                            linkedin!.isEmpty ? 'Preencha o campo !' : null,
                        keyboardType: TextInputType.text,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15, right: 15, top: 15),
                      child: TextFormField(
                        onChanged: (String? novoItemSelecionado) {
                          setState(() {
                            _txtSolucao = novoItemSelecionado!;
                          });
                        },
                        cursorColor: Color(0xFF082b59),
                        cursorWidth: 1.5,
                        style: TextStyle(fontSize: 14, color: Colors.black),
                        decoration: InputDecoration(
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
                          ),
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (linkedin) =>
                            linkedin!.isEmpty ? 'Preencha o campo !' : null,
                        keyboardType: TextInputType.text,
                      ),
                    ),
                    //Botão
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15, right: 15, top: 30),
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
                            "ENVIAR",
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
        ],
      ),
    );
  }
}

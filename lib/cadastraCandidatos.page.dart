// ignore_for_file: sort_child_properties_last, curly_braces_in_flow_control_structures, prefer_const_constructors, must_be_immutable, non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'dart:io';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'styles.dart';

var _txtNome = '';
var _txtCPF = '';
var _txtTelefone = '';
var _txtCidade = '';
var _txtEmail = '';
var _txtLinkedin = '';
var _txtMensagem = '';
var nome;
var nomeArquivo = '';
var caminho;
var path;
var read;
var metadata;

class CadastraCandidatosPage extends StatefulWidget {
  var id_vaga;
  CadastraCandidatosPage({required this.id_vaga, super.key});

  @override
  State<CadastraCandidatosPage> createState() => _CadastraCandidatosState();
}

class _CadastraCandidatosState extends State<CadastraCandidatosPage> {
  final _formKey = GlobalKey<FormState>();

  FirebaseStorage storage = FirebaseStorage.instance;
  final ImagePicker _picker = ImagePicker();

  Future _onSaved(BuildContext context) async {
    if (_txtNome.isEmpty ||
        _txtCPF.isEmpty ||
        _txtTelefone.isEmpty ||
        _txtCidade.isEmpty ||
        _txtEmail.isEmpty ||
        !_txtEmail.contains("@") ||
        _txtLinkedin.isEmpty ||
        nomeArquivo.isEmpty ||
        _txtMensagem.isEmpty) {
      const snackBar = SnackBar(
        content: Text('Preencha todos os campos !'),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      try {
        metadata = SettableMetadata(
          contentType: 'image',
          customMetadata: {'picked-file-path': path},
        );

        final ref = FirebaseStorage.instance.ref().child(caminho);

        await ref.putData(await read, metadata);

        String url = await ref.getDownloadURL();

        FirebaseFirestore.instance.collection('candidatos').add({
          'id_vaga': widget.id_vaga,
          'nome': _txtNome,
          'cpf': _txtCPF,
          'telefone': _txtTelefone,
          'cidade': _txtCidade,
          'email': _txtEmail,
          'linkedin': _txtLinkedin,
          'url': url,
          'curriculo': nomeArquivo,
          'mensagem': _txtMensagem
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

  Future selecionarCurriculo() async {
    final pegaImg = await _picker.pickImage(source: ImageSource.gallery);

    if (pegaImg != null) {
      nomeArquivo = pegaImg.name;
      nome = File(pegaImg.name);
      caminho = 'files/$nome';
      path = pegaImg.path;
      read = pegaImg.readAsBytes();

      setState(() {});
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
                            "Faça parte da nossa ",
                            style: titulo,
                          ),
                          Text(
                            "Equipe",
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
                            _txtNome = novoItemSelecionado!;
                          });
                        },
                        cursorColor: Color(0xFF082b59),
                        cursorWidth: 1.5,
                        style: TextStyle(fontSize: 14, color: Colors.black),
                        decoration: InputDecoration(
                          hintText: "Nome",
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
                            _txtCidade = novoItemSelecionado!;
                          });
                        },
                        cursorColor: Color(0xFF082b59),
                        cursorWidth: 1.5,
                        style: TextStyle(fontSize: 14, color: Colors.black),
                        decoration: InputDecoration(
                          hintText: "Cidade",
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
                            _txtEmail = novoItemSelecionado!;
                          });
                        },
                        cursorColor: Color(0xFF082b59),
                        cursorWidth: 1.5,
                        style: TextStyle(fontSize: 14, color: Colors.black),
                        decoration: InputDecoration(
                          hintText: "E-mail",
                          prefixIcon: Icon(Icons.email),
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
                        validator: (email) =>
                            email!.isEmpty || !email.contains("@")
                                ? 'Informe um e-mail válido !'
                                : null,
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),

                    //LinkedIn
                    Padding(
                      padding: EdgeInsets.only(left: 15, right: 15, top: 15),
                      child: TextFormField(
                        onChanged: (String? novoItemSelecionado) {
                          setState(() {
                            _txtLinkedin = novoItemSelecionado!;
                          });
                        },
                        cursorColor: Color(0xFF082b59),
                        cursorWidth: 1.5,
                        style: TextStyle(fontSize: 14, color: Colors.black),
                        decoration: InputDecoration(
                          hintText: "LinkedIn",
                          prefixIcon: Icon(Icons.task_sharp),
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

                    //Currículo
                    Padding(
                      padding: EdgeInsets.only(left: 15, right: 15, top: 15),
                      child: TextFormField(
                        showCursor: false,
                        onTap: () => selecionarCurriculo(),
                        cursorColor: Color(0xFF082b59),
                        cursorWidth: 1.5,
                        style: TextStyle(fontSize: 14, color: Colors.black),
                        decoration: InputDecoration(
                          hintText: "Currículo",
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
                        validator: (curriculo) => curriculo!.isEmpty
                            ? 'Anexe um currículo válido !'
                            : null,
                      ),
                    ),

                    //Mensagem
                    Padding(
                      padding: EdgeInsets.only(left: 15, right: 15, top: 15),
                      child: TextFormField(
                        onChanged: (String? novoItemSelecionado) {
                          setState(() {
                            _txtMensagem = novoItemSelecionado!;
                          });
                        },
                        minLines: 5,
                        maxLines: 5,
                        cursorColor: Color(0xFF082b59),
                        cursorWidth: 1.5,
                        style: TextStyle(fontSize: 14, color: Colors.black),
                        decoration: InputDecoration(
                          hintText: "Mensagem",
                          prefixIcon: Icon(Icons.message),
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
                        validator: (mensagem) =>
                            mensagem!.isEmpty ? 'Preencha o campo !' : null,
                        keyboardType: TextInputType.text,
                      ),
                    ),

                    //Botão
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15, right: 15, top: 30, bottom: 32),
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

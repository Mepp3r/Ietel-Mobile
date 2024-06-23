// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, collection_methods_unrelated_type

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'styles.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

var _txtNome = '';
var _txtCpf = '';
var _txtTelefone = '';
var _txtEndereco = '';
var _txtBairro = '';
var _txtNumero = '';
var _txtCep = '';
var _txtCidade = '';
var _txtData = '';
var _txtHorario = '';

class CadastraManutencao extends StatefulWidget {
  CadastraManutencao({super.key});

  @override
  State<CadastraManutencao> createState() => CadastraManu();
}

class CadastraManu extends State<CadastraManutencao> {
  final _formKey = GlobalKey<FormState>();
  final firestore = FirebaseFirestore.instance;
  final TextEditingController _dataController = TextEditingController();
  List<String> data = [];
  List<String> hora = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final datas =
        await firestore.collection('horarioManutencao').orderBy('data').get();
    final docs = datas.docs;

    final dataIn = docs.map((doc) => doc['data']! as String).toList();

    setState(() {
      data = dataIn;
    });

    // print(dataIn);
    // print(data);
  }

  Future<void> _loadHora() async {
    final horas = await firestore
        .collection('horarioManutencao')
        .where('data', isEqualTo: _dataController.text)
        .get();
    final docs = horas.docs;

    final horaIn = docs.map((doc) => doc['hora']! as String).toList();

    setState(() {
      hora = horaIn;
    });
    // print(horaIn);
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
      selectableDayPredicate: (DateTime dateTime) {
        String diaTemp = "${dateTime.day}/${dateTime.month}/${dateTime.year}";
        bool isAbleDate = data.contains(diaTemp);

        if (isAbleDate) {
          return true;
        }
        return false;
      },
    );
    if (picked != null) {
      setState(() {
        _dataController.text = "${picked.day}/${picked.month}/${picked.year}";
        _txtData = _dataController.text;
      });
    }
    _loadHora();
  }

  void _onSaved(BuildContext context) {
    if (_txtNome.isEmpty ||
        _txtCpf.isEmpty ||
        _txtTelefone.isEmpty ||
        _txtEndereco.isEmpty ||
        _txtBairro.isEmpty ||
        _txtNumero.isEmpty ||
        _txtCep.isEmpty ||
        _txtCidade.isEmpty ||
        _txtData.isEmpty ||
        _txtHorario.isEmpty) {
      // print(_txtNome);
      // print(_txtCep);
      // print(_txtTelefone);
      // print(_txtBairro);
      // print(_txtNumero);
      // print(_txtCep);
      // print(_txtCidade);
      // print(_txtData);
      // print(_txtHorario);
      const snackBar = SnackBar(
        content: Text('Preencha todos os campos !'),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      FirebaseFirestore.instance.collection('manutencao').add({
        'nome': _txtNome,
        'cpf': _txtCpf,
        'telefone': _txtTelefone,
        'endereço': _txtEndereco,
        'bairro': _txtBairro,
        'número': _txtNumero,
        'cep': _txtCep,
        'cidade': _txtCidade,
        'dia': _txtData,
        'hora': _txtHorario
      }).then((value) async {
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('horarioManutencao')
            .where('data', isEqualTo: _txtData)
            .where('hora', isEqualTo: _txtHorario)
            .get();

        var idDel = querySnapshot.docs.first.id;

        FirebaseFirestore.instance
            .collection('horarioManutencao')
            .doc(idDel)
            .delete();
      });

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Cadastro realizado com sucesso !'),
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
        body: ListView(children: [
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
                      child: Form(
                          key: _formKey,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Agende a sua ",
                                        style: titulo,
                                      ),
                                      Text(
                                        "Manutenção",
                                        style: palavraChave,
                                      ),
                                      Text(
                                        ":",
                                        style: titulo,
                                      )
                                    ],
                                  ),
                                ),
                                //Nome
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 15, right: 15, top: 20),
                                  child: TextFormField(
                                    onChanged: (String? novoNome) {
                                      setState(() {
                                        _txtNome = novoNome!;
                                      });
                                    },
                                    cursorColor: Color(0xFF082b59),
                                    cursorWidth: 1.5,
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black),
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
                                                Radius.circular(10))),
                                        focusedErrorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.red,
                                              width: 2,
                                            ),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)))),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: (nome) => nome!.isEmpty
                                        ? 'Preencha o campo !'
                                        : null,
                                    keyboardType: TextInputType.text,
                                  ),
                                ),

                                //CPF
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 15, top: 15),
                                  child: TextFormField(
                                    onChanged: (String? novoCpf) {
                                      setState(() {
                                        _txtCpf = novoCpf!;
                                      });
                                    },
                                    cursorColor: const Color(0xFF082b59),
                                    cursorWidth: 1.5,
                                    style: const TextStyle(
                                        fontSize: 14, color: Colors.black),
                                    decoration: const InputDecoration(
                                        counterText: '',
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
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: (cpf) => cpf!.isEmpty
                                        ? 'Preencha o campo !'
                                        : null,
                                    keyboardType: TextInputType.number,
                                  ),
                                ),

                                //Telefone
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 15, top: 15),
                                  child: TextFormField(
                                    onChanged: (String? novoTelefone) {
                                      setState(() {
                                        _txtTelefone = novoTelefone!;
                                      });
                                    },
                                    cursorColor: const Color(0xFF082b59),
                                    cursorWidth: 1.5,
                                    style: const TextStyle(
                                        fontSize: 14, color: Colors.black),
                                    decoration: const InputDecoration(
                                        counterText: '',
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
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      TelefoneInputFormatter()
                                    ],
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: (telefone) => telefone!.isEmpty
                                        ? 'Preencha o campo !'
                                        : null,
                                    keyboardType: TextInputType.number,
                                  ),
                                ),

                                //Endereço
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 15, right: 15, top: 15),
                                  child: TextFormField(
                                    onChanged: (String? novoEndereco) {
                                      setState(() {
                                        _txtEndereco = novoEndereco!;
                                      });
                                    },
                                    cursorColor: Color(0xFF082b59),
                                    cursorWidth: 1.5,
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black),
                                    decoration: InputDecoration(
                                        hintText: "Endereço",
                                        prefixIcon: Icon(Icons.location_on),
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
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: (endereco) => endereco!.isEmpty
                                        ? 'Preencha o campo !'
                                        : null,
                                    keyboardType: TextInputType.multiline,
                                  ),
                                ),

                                //Bairro
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 15, right: 15, top: 15),
                                  child: TextFormField(
                                    onChanged: (String? novoBairro) {
                                      setState(() {
                                        _txtBairro = novoBairro!;
                                      });
                                    },
                                    cursorColor: Color(0xFF082b59),
                                    cursorWidth: 1.5,
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black),
                                    decoration: InputDecoration(
                                        hintText: "Bairro",
                                        prefixIcon: Icon(Icons.house),
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
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: (bairro) => bairro!.isEmpty
                                        ? 'Preencha o campo !'
                                        : null,
                                    keyboardType: TextInputType.text,
                                  ),
                                ),

                                //Número
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 15, right: 15, top: 15),
                                  child: TextFormField(
                                    onChanged: (String? novoNumero) {
                                      setState(() {
                                        _txtNumero = novoNumero!;
                                      });
                                    },
                                    cursorColor: Color(0xFF082b59),
                                    cursorWidth: 1.5,
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black),
                                    maxLength: 4,
                                    decoration: InputDecoration(
                                        counterText: '',
                                        hintText: "Número",
                                        prefixIcon: Icon(Icons.where_to_vote),
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
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: (numero) => numero!.isEmpty
                                        ? 'Preencha o campo !'
                                        : null,
                                    keyboardType: TextInputType.number,
                                  ),
                                ),

                                //CEP
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 15, top: 15),
                                  child: TextFormField(
                                    onChanged: (String? novoCep) {
                                      setState(() {
                                        _txtCep = novoCep!;
                                      });
                                    },
                                    cursorColor: const Color(0xFF082b59),
                                    cursorWidth: 1.5,
                                    style: const TextStyle(
                                        fontSize: 14, color: Colors.black),
                                    decoration: const InputDecoration(
                                        counterText: '',
                                        hintText: "CEP",
                                        prefixIcon: Icon(Icons.share_location),
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
                                      CepInputFormatter(),
                                    ],
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: (cep) => cep!.isEmpty
                                        ? 'Preencha o campo !'
                                        : null,
                                    keyboardType: TextInputType.number,
                                  ),
                                ),

                                //Cidade
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 15, right: 15, top: 15),
                                  child: TextFormField(
                                    onChanged: (String? novaCidade) {
                                      setState(() {
                                        _txtCidade = novaCidade!;
                                      });
                                    },
                                    cursorColor: Color(0xFF082b59),
                                    cursorWidth: 1.5,
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black),
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
                                        )),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: (cidade) => cidade!.isEmpty
                                        ? 'Preencha o campo !'
                                        : null,
                                    keyboardType: TextInputType.text,
                                  ),
                                ),

                                //Data
                                Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15, right: 15, top: 20),
                                    child: StreamBuilder<
                                            QuerySnapshot<
                                                Map<String, dynamic>>>(
                                        stream: firestore
                                            .collection('horarioManutencao')
                                            .orderBy('dia')
                                            .snapshots(),
                                        builder: (context, snapshot) {
                                          if (!snapshot.hasData) {
                                            return const CircularProgressIndicator();
                                          }

                                          snapshot.data!.docs;

                                          return TextField(
                                            controller: _dataController,
                                            cursorColor:
                                                const Color(0xFF082b59),
                                            cursorWidth: 1.5,
                                            style: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.black),
                                            keyboardType: TextInputType.number,
                                            decoration: const InputDecoration(
                                                hintText: "Data",
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Color(0xFF082b59),
                                                    width: 2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(10),
                                                  ),
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Color(0xFFF58934),
                                                    width: 2,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(10),
                                                  ),
                                                ),
                                                prefixIcon:
                                                    Icon(Icons.date_range)),
                                            readOnly: true,
                                            onTap: () {
                                              _selectDate(context);
                                            },
                                          );
                                        })),

                                //Horário
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 15, top: 15),
                                  child: StreamBuilder<
                                          QuerySnapshot<Map<String, dynamic>>>(
                                      stream: firestore
                                          .collection('horarioManutencao')
                                          .snapshots(),
                                      builder: (context, snapshot) {
                                        if (hora.isEmpty) {
                                          return Text('');
                                        }
                                        _txtHorario = hora.first;
                                        return SizedBox(
                                          height: 60,
                                          child: DropdownButtonFormField(
                                            value: hora.first,
                                            decoration: const InputDecoration(
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xFFF58934),
                                                    width: 2),
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(10),
                                                ),
                                              ),
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0xFFF58934),
                                                    width: 2),
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(10),
                                                ),
                                              ),
                                              prefixIcon: Icon(Icons.access_time_outlined)
                                            ),
                                            dropdownColor:
                                                const Color(0xfffdf0e6),
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                            items: hora.map(
                                                (String dropDownStringItem) {
                                              return DropdownMenuItem(
                                                  value: dropDownStringItem,
                                                  child:
                                                      Text(dropDownStringItem));
                                            }).toList(),
                                            onChanged: (String? novoHorario) {
                                              setState(() {
                                                _txtHorario = novoHorario!;
                                              });
                                            },
                                            style: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.black),
                                          ),
                                        );
                                      }),
                                ),

                                //Botão
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 30, left: 15, right: 15, bottom: 32),
                                  child: SizedBox(
                                    width: 200,
                                    height: 36,
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                        shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        overlayColor: MaterialStateProperty
                                            .resolveWith<Color?>(
                                          (Set<MaterialState> states) {
                                            if (states.contains(
                                                MaterialState.hovered)) {
                                              return const Color(0xFF082b59);
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                      child: const Text(
                                        "AGENDAR",
                                        style: button,
                                      ),
                                      onPressed: () => _onSaved(context),
                                    ),
                                  ),
                                ),
                              ])))))
        ]));
  }
}

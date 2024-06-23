// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:ietel_solar/telaInicial.page.dart';

class EditaUserPage extends StatefulWidget {
  final user;
  const EditaUserPage({Key? key, required this.user}) : super(key: key);

  @override
  _EditaUserPageState createState() => _EditaUserPageState();
}

class _EditaUserPageState extends State<EditaUserPage> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _currentPasswordController = TextEditingController();

  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  User? user;

  @override
  void initState() {
    super.initState();
    user = _auth.currentUser;
    if (user != null) {
      _emailController.text = user!.email!;
      _firestore.collection('usuarios').doc(user!.uid).get().then((doc) {
        _nomeController.text = doc['nome'];
      });
    }
  }

  Future<bool> _reauthenticateUser(String currentPassword) async {
    final cred = EmailAuthProvider.credential(
      email: user!.email!,
      password: currentPassword,
    );

    try {
      await user!.reauthenticateWithCredential(cred);
      return true;
    } catch (e) {
      
      print(e);
      await _showDialog('Erro', 'A senha antiga está incorreta.');
      return false;
    }
  }

  Future<void> _showDialog(String title, String content) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, 
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(content),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _editarUser() async {
    var aviso = '';

    if (_formKey.currentState?.validate() ?? false) {
      if (user != null) {
        String currentPassword = _currentPasswordController.text;
      
        bool reauthenticated = await _reauthenticateUser(currentPassword);

        if (!reauthenticated) {
        
          return;
        }

        if (_emailController.text != user!.email!) {
          await _showDialog('Erro', 'O email não pode ser alterado.');
          return;
        }
        if (!_emailController.text.contains('@')) {
          await _showDialog('Erro', 'O email é inválido.');
          return;
        }

    

        if (_passwordController.text.isNotEmpty) {
          try {
            await user!.updatePassword(_passwordController.text);
          } catch (e) {
            if (e is FirebaseAuthException) {
              if (e.code == 'weak-password') {
                await _showDialog(
                    'Erro!', 'Senha fraca, digite no mínimo 6 caracteres ou uma senha mais forte');
              } else {
                await _showDialog(
                    'Erro!', 'Erro ao atualizar senha: ${e.message}');
              }
            } else {
              await _showDialog('Erro!', 'Erro ao atualizar senha.');
            }
            return;
          }
        }

  
        try {
          await _firestore.collection('usuarios').doc(user!.uid).update({
            'nome': _nomeController.text,
          });
        } catch (e) {
          // Trate os erros de atualização do nome aqui
          print(e);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Erro ao atualizar nome'),
          ));
          return;
        }

       
        try {
          await user!.updateDisplayName(_nomeController.text);
          await user!.reload();
          user = _auth.currentUser;
        } catch (e) {
         
          print(e);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Erro ao atualizar perfil'),
          ));
          return;
        }

       
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Informações atualizadas com sucesso!'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 3),
        ));

        Navigator.pushReplacementNamed(context, '/login');
      }
    } else {
      aviso =
          'Por favor, verifique se todos os campos estão preenchidos corretamente';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(aviso),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "IETEL SOLAR",
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
                child: Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Column(
                    children: <Widget>[
                      const Text.rich(
                        TextSpan(
                          children: <TextSpan>[
                            TextSpan(text: 'Editar', style: titulo),
                            TextSpan(text: ' Usuário', style: palavraChave),
                            TextSpan(text: ':', style: titulo),
                          ],
                        ),
                      ),
                  
                      //Nome
                      Padding(
                        padding: EdgeInsets.only(
                          left: 15,
                          right: 15,
                          top: 20,
                        ),
                        child: TextFormField(
                          cursorColor: Color(0xFF082b59),
                          cursorWidth: 1.5,
                          style: TextStyle(fontSize: 14, color: Colors.black),
                          controller: _nomeController,
                          decoration: const InputDecoration(
                              hintText: "Digite seu Nome",
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
                          validator: (nome) =>
                              nome!.isEmpty ? 'Preencha o campo!' : null,
                          keyboardType: TextInputType.name,
                        ),
                      ),
                  
                      //Email
                      Padding(
                        padding: EdgeInsets.only(
                          left: 15,
                          right: 15,
                          top: 30,
                          bottom: 15,
                        ),
                        child: TextFormField(
                          cursorColor: Color(0xFF082b59),
                          cursorWidth: 1.5,
                          style: TextStyle(fontSize: 14, color: Colors.black),
                          controller: _emailController,
                          decoration: const InputDecoration(
                              hintText: "Digite o email",
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
                              )),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (email) =>
                              email!.isEmpty ? 'Preencha o campo!' : null,
                          keyboardType: TextInputType.emailAddress,
                          readOnly: true,
                        ),
                      ),
                    //Senha antiga
                      Padding(
                        padding: EdgeInsets.only(
                          left: 15,
                          right: 15,
                          top: 15,
                          bottom: 15,
                        ),
                        child: TextFormField(
                          cursorColor: Color(0xFF082b59),
                          cursorWidth: 1.5,
                          style: TextStyle(fontSize: 14, color: Colors.black),
                          controller: _currentPasswordController,
                          decoration: InputDecoration(
                              hintText: "Digite a senha antiga",
                              prefixIcon: Icon(Icons.lock),
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
                          validator: (senha) =>
                              senha!.isEmpty ? 'Preencha o campo!' : null,
                          keyboardType: TextInputType.text,
                          obscureText: true,
                        ),
                      ),
                      //Senha Nova
                  
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 15,
                          right: 15,
                          top: 15,
                        ),
                        child: TextFormField(
                          cursorColor: Color(0xFF082b59),
                          cursorWidth: 1.5,
                          style: TextStyle(fontSize: 14, color: Colors.black),
                          controller: _passwordController,
                          decoration: InputDecoration(
                              hintText: "Digite a nova senha",
                              prefixIcon: Icon(Icons.lock),
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
                          validator: (senha) =>
                              senha!.isEmpty ? 'Preencha o campo!' : null,
                          keyboardType: TextInputType.text,
                          obscureText: true,
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
                              "EDITAR",
                              style: button,
                            ),
                            onPressed: () => _editarUser(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}

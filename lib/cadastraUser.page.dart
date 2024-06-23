// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:ietel_solar/login.page.dart';
// import 'package:ietel_solar/telaInicial.page.dart';
import 'styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CadastraUserPage extends StatefulWidget {
  const CadastraUserPage({super.key});

  @override
  State<CadastraUserPage> createState() => _CadastraUserState();
}

class _CadastraUserState extends State<CadastraUserPage> {
  final _formkey = GlobalKey<FormState>();

  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  // final _firestore = FirebaseFirestore.instance;
  final _firebaseAuth = FirebaseAuth.instance;

  Future<void> _cadastrarUsuario() async {
    String? nome = _nomeController.text;
    String email = _emailController.text;
    String password = _passwordController.text;
    var message = '';
    var aviso = '';

    if (_formkey.currentState?.validate() ?? false) {
      try {
        UserCredential userCredential = await _firebaseAuth
            .createUserWithEmailAndPassword(email: email, password: password);

        User? user = userCredential.user;

        if (user != null) {
          await user.updateDisplayName(nome);
          await FirebaseFirestore.instance
              .collection('usuarios')
              .doc(user.uid)
              .set({
            'cargo': 'User',
            'nome': nome,
            'uid': user.uid,
          });

          aviso = 'Cadastro realizado com sucesso';
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(aviso),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 3),
            ),
          );

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          );
        }
      } on FirebaseAuthException catch (ex) {
        switch (ex.code) {
          case 'email-already-in-use':
            message = 'Este email já está cadastrado';
            break;

          case 'invalid-email':
            message = 'email inválido';
            break;

          case 'weak-password':
            message = 'senha fraca, digite no minímo 6 caracteres';
            break;

          default:
            message = 'Ocorreu um erro. Tente novamente.';
        }
        _showErrorDialog(message);
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

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Atenção!"),
          content: Text(message),
        );
      },
    );
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
                key: _formkey,
                child: Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Column(
                    children: <Widget>[
                      const Text.rich(
                        TextSpan(
                          children: <TextSpan>[
                            TextSpan(text: 'Cadastrar um novo', style: titulo),
                            TextSpan(text: ' Usuário', style: palavraChave),
                            TextSpan(text: ':', style: titulo),
                          ],
                        ),
                      ),
                          
                      //Nome
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 15,
                          right: 15,
                          top: 20,
                        ),
                        child: TextFormField(
                          cursorColor: const Color(0xFF082b59),
                          cursorWidth: 1.5,
                          style: const TextStyle(fontSize: 14, color: Colors.black),
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
                              nome!.isEmpty ? 'Preencha o campo !' : null,
                          keyboardType: TextInputType.text,
                        ),
                      ),
                          
                      //Email
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 15,
                          right: 15,
                          top: 30,
                          bottom: 15,
                        ),
                        child: TextFormField(
                          cursorColor: const Color(0xFF082b59),
                          cursorWidth: 1.5,
                          style: const TextStyle(fontSize: 14, color: Colors.black),
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
                              email!.isEmpty ? 'Preencha o campo !' : null,
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                          
                      //Senha
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 15,
                          right: 15,
                          top: 15,
                          bottom: 15,
                        ),
                        child: TextFormField(
                          cursorColor: const Color(0xFF082b59),
                          cursorWidth: 1.5,
                          style: const TextStyle(fontSize: 14, color: Colors.black),
                          controller: _passwordController,
                          decoration: InputDecoration(
                              hintText: "Digite sua senha",
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
                          validator: (password) =>
                              password!.isEmpty ? 'Preencha o campo !' : null,
                          keyboardType: TextInputType.text,
                          obscureText: true,
                        ),
                      ),
                          
                      //DIGITE SUA SENHA NOVAMENTE
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
                          decoration: InputDecoration(
                              hintText: "Digite sua senha novamente",
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
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (senha) {
                            if (senha!.isEmpty) {
                              return 'Preencha o campo!';
                            }
                            if (senha != _passwordController.text) {
                              return 'As senhas não coincidem!';
                            }
                            return null;
                          },
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
                                    return Color(0xFF082b59);
                                  return null;
                                },
                              ),
                            ),
                            child: const Text(
                              "CADASTRAR",
                              style: button,
                            ),
                            onPressed: () => _cadastrarUsuario(),
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

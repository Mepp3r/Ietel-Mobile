// import 'package:cloud_firestore/cloud_firestore.dart';
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'telaInicial.page.dart';
import 'styles.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _formKey = GlobalKey<FormState>();

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _login() async {
    String email = _emailController.text;
    String password = _passwordController.text;
    var message = '';
    var aviso = '';

    if (email.isEmpty || password.isEmpty) {
      aviso = 'Por favor, preencha todos os campos!!!';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(aviso), //aviso de erro na parte inferior
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
    } else {
      try {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          //signIn por create user TAREFA-- CRIAR REGISTRO E AVISAR A MENSAGEM DE ERRO!
          email: email,
          password: password,
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => TelaInicial(user: userCredential.user)),
        );
      } on FirebaseAuthException catch (ex) {
        switch (ex.code) {
          case 'invalid-email':
            //message = 'Usuário inválido!';
            message =
                'Usuário não encontrado';
            break;
          case 'invalid-credential':
            //message = 'Senha está incorreta, tente novamente!';
            message =
                'Usuário não encontrado';
            break;

          case 'user-not-found':
            message =
                'Usuário não encontrado. Por favor, registre-se primeiro.';
            break;

          default:
            message = 'Ocorreu um erro. Tente novamente.';
            break;
        }
        AlertDialog alerta =
            AlertDialog(title: const Text("Atenção !"), content: Text(message));

        showDialog(
            context: context,
            builder: (BuildContext context) {
              return alerta;
            });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFF58934),
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () => Navigator.pushNamed(context, "/cadastraUser"),
      ),
      backgroundColor: const Color(0xFF082b59),
      body: Center(
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("images/logo_ietel.png"),
                      ],
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
                      controller: _emailController,
                      cursorColor: Color(0xFF082b59),
                      cursorWidth: 1.5,
                      style: TextStyle(fontSize: 14, color: Colors.black),
                      decoration: InputDecoration(
                        hintText: "Digite seu email",
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
                      validator: (email) =>
                          email!.isEmpty ? 'Preencha o campo !' : null,
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),

                  //Senha
                  Padding(
                    padding: EdgeInsets.only(
                      left: 15,
                      right: 15,
                      top: 15,
                      bottom: 15,
                    ),
                    child: TextFormField(
                      controller: _passwordController,
                      cursorColor: Color(0xFF082b59),
                      cursorWidth: 1.5,
                      style: TextStyle(fontSize: 14, color: Colors.black),
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

                  //Botão
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, top: 15, bottom: 32),
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
                        onPressed: () => _login(),
                        child: const Text(
                          "LOGAR",
                          style: button,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

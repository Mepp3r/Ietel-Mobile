// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ietel_solar/agendamentoManutencao.dart';
import 'package:ietel_solar/agendamentoOrcamento.dart';
import 'package:ietel_solar/cadastraManutencao.page.dart';
import 'package:ietel_solar/cadastraOrcamento.page.dart';
import 'package:ietel_solar/calculadora.page.dart';
import 'package:ietel_solar/contato.page.dart';
import 'package:ietel_solar/editaUser.page.dart';
import 'package:ietel_solar/empresa.page.dart';
import 'package:ietel_solar/funcionamento.page.dart';
import 'package:ietel_solar/listaManutencao.page.dart';
import 'package:ietel_solar/listaOrcamento.page.dart';
import 'package:ietel_solar/listaVagas.page.dart';
import 'package:ietel_solar/listaVagasAdm.page.dart';
import 'package:ietel_solar/os/listaOrdemDeServico.dart';
import 'package:ietel_solar/styles.dart';

class TelaInicial extends StatefulWidget {
  final User? user;

  const TelaInicial({required this.user, super.key});

  @override
  _TelaInicialState createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  void _logout(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/login');
  }

  String? cargo;
  String? nome;
  bool isLoading = true;
  double? latitude;
  double? longitude;
  var cidade = '';
  var apiKey = 'a9f81072d5b1976feb2871ec7f6a024b&';
  var nascer_sol;
  var por_sol;
  var temperatura;
  var umidade;

  @override
  void initState() {
    super.initState();
    _fetchUserRole();
  }

  Future<void> _fetchUserRole() async {
    final uid = widget.user?.uid;

    if (uid != null) {
      final userDoc = await FirebaseFirestore.instance
          .collection('usuarios')
          .doc(uid)
          .get();
      if (userDoc.exists) {
        setState(() {
          cargo = userDoc.data()?['cargo'];
          nome = userDoc.data()?['nome'];
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<Position> _pegarClima() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error("Serviço desabilitado !");
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error("Acesso a localização negado !");
      }
    }

    var position = await Geolocator.getCurrentPosition();

    var response = await http.get(Uri.parse(
        'https://nominatim.openstreetmap.org/reverse?lat=${position.latitude}&lon=${position.longitude}&format=json'));

    cidade = jsonDecode(response.body)['address']['city'];

    var url = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=${cidade}&appid=${apiKey}&units=metric'));

    nascer_sol =
        getClockInUtcPlus3Hours(jsonDecode(url.body)['sys']['sunrise'] as int);
    por_sol =
        getClockInUtcPlus3Hours(jsonDecode(url.body)['sys']['sunset'] as int);
    temperatura = jsonDecode(url.body)['main']['temp'];
    umidade = jsonDecode(url.body)['main']['humidity'];

    setState(() {});

    return position;
  }

  String getClockInUtcPlus3Hours(int timeSinceEpochInSec) {
    final time = DateTime.fromMillisecondsSinceEpoch(timeSinceEpochInSec * 1000,
            isUtc: true)
        .add(const Duration(hours: 3));
    return '${(time.hour - 6)}:${time.minute}';
  }

  final user = FirebaseAuth.instance
      .currentUser!; //nome. telefone. email, id, armazenar sistema de autentificação
  final firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF082b59),
      appBar: AppBar(
        title: const Text(
          "IETEL Solar",
          style: ietelSolar,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: CustomDrawer(user: widget.user, cargo: cargo, nome: nome),
      body: ListView(
        children: [
          Center(
          child: Padding(
            padding: const EdgeInsets.only(
              top:30,
              right: 15,
              left: 15
            ),
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFF082b59),
                borderRadius: BorderRadius.all(
                  Radius.circular(6),
                ),
              ),
        
              //Previsão do Tempo
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 60,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(6),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                                icon: Icon(Icons.location_on,
                                    color: Color(0xFFF58934)),
                                iconSize: 20,
                                onPressed: () => _pegarClima(),
                              ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              cidade,
                              style: clima,
                            )
                          ],
                        ),
                        const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.wb_sunny,
                              color: Color(0xFFF58934),
                              size: 20,
                            )
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (nascer_sol == null || por_sol == null) ...[
                              Text(
                                '',
                                style: clima,
                              )
                            ] else ...[
                              Text(
                                '${nascer_sol}h - ${por_sol}h',
                                style: clima,
                              )
                            ]
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.thermostat,
                              color: Color(0xFFF58934),
                              size: 20,
                            )
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (temperatura == null) ...[
                              Text(
                                '',
                                style: clima,
                              )
                            ] else ...[
                              Text(
                                '${temperatura.round()}°C',
                                style: clima,
                              )
                            ]
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.water_drop,
                              color: Color(0xFFF58934),
                              size: 20,
                            )
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (umidade == null) ...[
                              Padding(
                                padding: EdgeInsets.only(right: 15),
                                child: Text(
                                  '',
                                  style: clima,
                                ),
                              ),
                            ] else ...[
                              Padding(
                                padding: EdgeInsets.only(right: 15),
                                child: Text(
                                  '${umidade}%',
                                  style: clima,
                                ),
                              ),
                            ]
                          ],
                        )
                      ],
                    ),
                  ),
        
                  //Vídeo
                   Padding(
                    padding: const EdgeInsets.only(
                      top: 30,
                      right: 5,
                      left: 5,
                      bottom: 20
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      height: 215,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(6),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('images/placa_solar.gif', width: 350,
                                            height: 200,fit: BoxFit.cover,)
                        ],
                      ),
                    ),
                  ),
        
                  //Cards
                  Container(
                    color: const Color(0xFF082b59),
                    height: 290,
                    width: 300,
                    alignment: Alignment.center,
                    child: const Padding(
                      padding: EdgeInsets.only(
                        top: 10,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image(
                                  image: ResizeImage(
                                      AssetImage('images/imagem_card_1.png'),
                                      width: 120,
                                      height: 90)),
                              Padding(
                                padding: EdgeInsets.only(left: 20, right: 20),
                                child: Text(
                                  "+",
                                  style: card,
                                ),
                              ),
                              Text(
                                "ECONÔMICA",
                                style: card,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Image(
                                  image: ResizeImage(
                                      AssetImage('images/imagem_card_2.png'),
                                      width: 120,
                                      height: 90)),
                              Padding(
                                padding: EdgeInsets.only(left: 20, right: 20),
                                child: Text(
                                  "+",
                                  style: card,
                                ),
                              ),
                              Text(
                                "SEGURA",
                                style: card,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Image(
                                  image: ResizeImage(
                                      AssetImage('images/imagem_card_3.png'),
                                      width: 120,
                                      height: 90)),
                              Padding(
                                padding: EdgeInsets.only(left: 20, right: 20),
                                child: Text(
                                  "+",
                                  style: card,
                                ),
                              ),
                              Text(
                                "SUSTENTÁVEL",
                                style: card,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          )
        ],
      ),
    );
  }
}

class CustomDrawer extends StatelessWidget {
  final User? user;
  final String? cargo;
  final String? nome;

  CustomDrawer({required this.user, required this.cargo, required this.nome});

  void _logout(BuildContext context) {
    FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    

    //Menu----------------------------------------------------------------------------------------------------------
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(
              nome ?? "User Logado",
              style: menuNome,
            ),
            accountEmail: Text(user?.email ?? "", style: menuEmail),
            decoration: const BoxDecoration(color: Color(0xFF082b59)),
            currentAccountPicture: const CircleAvatar(
                backgroundImage: AssetImage("images/logo_ietel.png")),
          ),

          //Acesso de Usuário
          if (cargo == 'User') ...[
            //Funcionamento
            ListTile(
              leading: const Icon(Icons.sunny, color: Color(0xFFF58934)),
              title: const Text("Funcionamento", style: menu),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const FuncionamentoPage()));
              },
            ),

            //Calculadora Solar
            ListTile(
              leading: const Icon(Icons.calculate, color: Color(0xFFF58934)),
              title: const Text("Calculadora Solar", style: menu),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const CalculadoraPage()));
              },
            ),

            //Orçamento
            ListTile(
              leading: const Icon(Icons.book, color: Color(0xFFF58934)),
              title: const Text("Orçamento", style: menu),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const CadastroOrc()));
              },
            ),

            //Manutenção
            ListTile(
              leading:
                  const Icon(Icons.build_rounded, color: Color(0xFFF58934)),
              title: const Text("Manutenção", style: menu),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            CadastraManutencao()));
              },
            ),

            //Trabalhe Conosco
            ListTile(
              leading: const Icon(Icons.work, color: Color(0xFFF58934)),
              title: const Text("Trabalhe Conosco", style: menu),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => ListaVagasPage()));
              },
            ),

            //Contatos
            ListTile(
              leading: const Icon(Icons.phone, color: Color(0xFFF58934)),
              title: const Text("Contatos", style: menu),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const ContatoPage()));
              },
            ),

            //Sobre Nós
            ListTile(
              leading: const Icon(Icons.store_mall_directory,
                  color: Color(0xFFF58934)),
              title: const Text("Sobre Nós", style: menu),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const EmpresaPage()));
              },
            ),

            //Configurações
            ListTile(
              leading: const Icon(Icons.settings, color: Color(0xFFF58934)),
              title: const Text("Configurações", style: menu),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            EditaUserPage(user:user)));
              },
            ),

            //Botão
            Padding(
              padding: const EdgeInsets.only(top: 30, right: 120, left: 20),
              child: ElevatedButton.icon(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  overlayColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.hovered))
                        return const Color(0xFF082b59);
                      return null;
                    },
                  ),
                ),
                onPressed: () => _logout(context),
                icon: const Icon(
                  Icons.exit_to_app,
                  color: Colors.white,
                ),
                label: const Text(
                  "SAIR",
                  style: button,
                ),
              ),
            )
          ]

          //Acesso de Administrador
          else ...[
            //Calculadora Solar
            ListTile(
              leading: const Icon(Icons.calculate, color: Color(0xFFF58934)),
              title: const Text("Calculadora Solar", style: menu),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const CalculadoraPage()));
              },
            ),

            //Agenda Horário Orçamento
            ListTile(
              leading: const Icon(Icons.perm_contact_calendar,
                  color: Color(0xFFF58934)),
              title: const Text("Agenda Horário Orçamento", style: menu),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            AgendamentoOrca()));
              },
            ),

            //Lista de Orçamentos
            ListTile(
              leading: const Icon(Icons.book, color: Color(0xFFF58934)),
              title: const Text("Lista de Orçamentos", style: menu),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            ListaOrcamento()));
              },
            ),

            //Agenda Horário Manutenção
            ListTile(
              leading: const Icon(Icons.perm_contact_calendar,
                  color: Color(0xFFF58934)),
              title: const Text("Agenda Horário Manutenção", style: menu),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            AgendamentoManu()));
              },
            ),

            //Lista de Manutenções
            ListTile(
              leading:
                  const Icon(Icons.build_rounded, color: Color(0xFFF58934)),
              title: const Text("Lista de Manutenções", style: menu),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => ListaManuntencao()));
              },
            ),

            //Lista de Ordens de Serviço
            ListTile(
              leading: const Icon(Icons.menu_book, color: Color(0xFFF58934)),
              title: const Text("Lista de Ordens de Serviço", style: menu),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            ListaOrdemDeServico()));
              },
            ),

            //Lista de Vagas
            ListTile(
              leading: const Icon(Icons.work, color: Color(0xFFF58934)),
              title: const Text("Lista de Vagas", style: menu),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            ListaVagasAdmPage()));
              },
            ),

            //Configurações
            ListTile(
              leading: const Icon(Icons.settings, color: Color(0xFFF58934)),
              title: const Text("Configurações", style: menu),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            EditaUserPage(user:user)));
              },
            ),

            //Botão
            Padding(
              padding: const EdgeInsets.only(top: 30, right: 120, left: 20),
              child: ElevatedButton.icon(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  overlayColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.hovered))
                        return const Color(0xFF082b59);
                      return null;
                    },
                  ),
                ),
                onPressed: () => _logout(context),
                icon: const Icon(
                  Icons.exit_to_app,
                  color: Colors.white,
                ),
                label: const Text(
                  "SAIR",
                  style: button,
                ),
              ),
            )
          ]
        ],
      ),
    );
  }
}

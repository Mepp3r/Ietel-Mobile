// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:ietel_solar/os/ordemDeServico.page.dart';

import 'login.page.dart';
import 'cadastraUser.page.dart';

import 'contato.page.dart';
import 'funcionamento.page.dart';
import 'empresa.page.dart';

import 'agendamentoManutencao.dart';
import 'cadastraManutencao.page.dart';

import 'calculadora.page.dart';

import 'cadastraVagas.page.dart';
import 'listaVagasAdm.page.dart';
import 'listaVagas.page.dart';

import 'cadastraOrcamento.page.dart';
import 'agendamentoOrcamento.dart';
import 'listaManutencao.page.dart';
import 'listaOrcamento.page.dart';
import 'package:ietel_solar/os/listaOrdemDeServico.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

class App extends StatelessWidget {
  App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('pt', ''),
      ],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: false,
        primarySwatch: MaterialColor(
          0xFFF58934,
          {
            50: Colors.orange[50]!,
            100: Colors.orange[100]!,
            200: Colors.orange[200]!,
            300: Colors.orange[300]!,
            500: Colors.orange[500]!,
            600: Colors.orange[600]!,
            700: Colors.orange[700]!,
            800: Colors.orange[800]!,
            900: Colors.orange[900]!,
          },
        ),
      ),
      routes: {
        "/login": (context) => LoginPage(),
        "/contato": (context) => const ContatoPage(),
        "/agendamentoManutencao": (context) => const AgendamentoManu(),
        "/cadastraManutencao": (context) => CadastraManutencao(),
        "/calculadora": (context) => const CalculadoraPage(),
        "/cadastraVagas": (context) => const CadastraVagasPage(),
        "/listaVagasAdm": (context) => ListaVagasAdmPage(),
        "/listaVagas": (context) => ListaVagasPage(),
        "/cadastraUser": (context) => const CadastraUserPage(),
        "/funcionamento": (context) => const FuncionamentoPage(),
        "/empresa": (context) => const EmpresaPage(),
        "/listaManutencao": (context) => ListaManuntencao(),
        "/listaOrcamento": (context) => ListaOrcamento(),
        "/cadastraOrcamento": (context) => const CadastroOrc(),
        "/listaOS": (context) => ListaOrdemDeServico(),
        "/ordemDeServico": (context) => OrdemDeServicoPage(),
        "/agendamentoOrcamento": (context) => AgendamentoOrca(),
      },
      initialRoute: '/login',
    );
  }
}

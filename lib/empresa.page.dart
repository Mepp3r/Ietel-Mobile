import 'package:flutter/material.dart';
import 'styles.dart';

class EmpresaPage extends StatelessWidget {
  const EmpresaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Empresa ",
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                   const Padding(
                    padding:  EdgeInsets.only(top: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                         Text.rich(
                           TextSpan(
                            children: <TextSpan>[
                              TextSpan(text: 'Informações', style: titulo),
                              TextSpan(text: ' Sobre Nós', style: palavraChave),
                              TextSpan(text: ':', style: titulo),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                   const Padding(
                    padding: EdgeInsets.only(left: 30, top: 30, right: 30),
                    child: Row(
                    
                      mainAxisAlignment: MainAxisAlignment.center,
                    
                      children: [
                        Expanded(
                          child:  Text( '''A empresa IETEL Solar localiza-se em Potirendaba, e dispõem de duas lojas na cidade e uma filial em São José do Rio Preto, atuando nessa região. Tem como visão ser reconhecida no mercado como um exemplo como um exemplo na prestação de serviços e no atendimento aos seus clientes, revendo sepre os seus processos, realizando realizando o planejamento estratégico dos seus negócios, e analisando a concorrência e as novas tendências existentes.''', textAlign: TextAlign.center,),)
                           ],
                        ),),
        
                        Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("images/empresa.jpg",width: 350),
                      ],
                    ),
                  ),
        
                      ],
                    ),
                  
                  
        
        
            
              ),
            ),
          ),
        ],
      )
    );
  }
}

import 'package:flutter/material.dart';
import 'styles.dart';

class CadastraManutencaoPage extends StatelessWidget {
  const CadastraManutencaoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "IETEL Solar",
          style: ietelSolar,
        ),
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 30),
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
                const Padding(
                  padding: EdgeInsets.only(
                    left: 15,
                    right: 15,
                    top: 15
                  ),
                  child: TextField(
                    cursorColor: Color(0xFF082b59),
                    cursorWidth: 1.5,
                    style: TextStyle(fontSize: 14, color: Colors.black),
                    decoration: InputDecoration(
                      hintText: "Nome",
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
                    ),
                    keyboardType: TextInputType.text,
                  ),
                ),

                //CPF
                const Padding(
                  padding: EdgeInsets.only(
                    left: 15,
                    right: 15,
                  ),
                  child: TextField(
                    cursorColor: Color(0xFF082b59),
                    cursorWidth: 1.5,
                    style: TextStyle(fontSize: 14, color: Colors.black),
                    maxLength: 11,
                    decoration: InputDecoration(
                      counterText: '',
                      hintText: "CPF",
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
                    ),
                    keyboardType: TextInputType.text,
                  ),
                ),

                //Telefone
                const Padding(
                  padding: EdgeInsets.only(
                    left: 15,
                    right: 15,
                  ),
                  child: TextField(
                    cursorColor: Color(0xFF082b59),
                    cursorWidth: 1.5,
                    style: TextStyle(fontSize: 14, color: Colors.black),
                    maxLength: 11,
                    decoration: InputDecoration(
                      counterText: '',
                      hintText: "Telefone",
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
                    ),
                    keyboardType: TextInputType.text,
                  ),
                ),

                //Endereço
                const Padding(
                  padding: EdgeInsets.only(
                    left: 15,
                    right: 15,
                  ),
                  child: TextField(
                    cursorColor: Color(0xFF082b59),
                    cursorWidth: 1.5,
                    style: TextStyle(fontSize: 14, color: Colors.black),
                    decoration: InputDecoration(
                      hintText: "Endereço",
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
                    ),
                    keyboardType: TextInputType.multiline,
                  ),
                ),

                //Bairro
                const Padding(
                  padding: EdgeInsets.only(
                    left: 15,
                    right: 15,
                  ),
                  child: TextField(
                    cursorColor: Color(0xFF082b59),
                    cursorWidth: 1.5,
                    style: TextStyle(fontSize: 14, color: Colors.black),
                    decoration: InputDecoration(
                      hintText: "Bairro",
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
                    ),
                    keyboardType: TextInputType.text,
                  ),
                ),

                //Número
                const Padding(padding: EdgeInsets.only(
                    left: 15,
                    right: 15,
                ),
                  child: TextField(
                      cursorColor: Color(0xFF082b59),
                      cursorWidth: 1.5,
                      style: TextStyle(fontSize: 14, color: Colors.black),
                      maxLength: 4,
                      decoration: InputDecoration(
                        counterText: '',
                        hintText: "Número",
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
                      ),
                      keyboardType: TextInputType.text,
                    ),
                  ),

                //CEP
                const Padding(
                  padding: EdgeInsets.only(
                    left: 15,
                    right: 15,
                  ),
                  child: TextField(
                    cursorColor: Color(0xFF082b59),
                    cursorWidth: 1.5,
                    maxLength: 8,
                    style: TextStyle(fontSize: 14, color: Colors.black),
                    decoration: InputDecoration(
                      counterText: '',
                      hintText: "CEP",
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
                    ),
                    keyboardType: TextInputType.text,
                  ),
                ),

                //Cidade
                const Padding(
                  padding: EdgeInsets.only(
                    left: 15,
                    right: 15,
                  ),
                  child: TextField(
                    cursorColor: Color(0xFF082b59),
                    cursorWidth: 1.5,
                    style: TextStyle(fontSize: 14, color: Colors.black),
                    decoration: InputDecoration(
                      hintText: "Cidade",
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
                    ),
                    keyboardType: TextInputType.text,
                  ),
                ),

                //Data
                const Padding(
                  padding: EdgeInsets.only(
                    left: 15,
                    right: 15,
                  ),
                  child: TextField(
                    cursorColor:  Color(0xFF082b59),
                    cursorWidth: 1.5,
                    style: TextStyle(fontSize: 14, color: Colors.black),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "Data",
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
                    ),
                  ),
                ),

                //Horário
                const Padding(
                  padding: EdgeInsets.only(
                    left: 15,
                    right: 15,
                  ),
                  child: TextField(
                    cursorColor: Color(0xFF082b59),
                    cursorWidth: 1.5,
                    style: TextStyle(fontSize: 14, color: Colors.black),
                    maxLength: 4,
                    decoration: InputDecoration(
                      counterText: '',
                      hintText: "Horário",
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
                    ),
                    keyboardType: TextInputType.text,
                  ),
                ),


                //Botão
                Padding(
                  padding:
                      const EdgeInsets.only(left: 15, right: 15, bottom: 32),
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
                        overlayColor: MaterialStateProperty.resolveWith<Color?>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.hovered))
                              return Color(0xFF082b59);
                            return null;
                          },
                        ),
                      ),
                      child: const Text(
                        "AGENDAR",
                        style: button,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class Soy extends StatefulWidget {
  @override
  _SoyState createState() => _SoyState();
}

class _SoyState extends State<Soy> {
  TextEditingController graosController = TextEditingController();
  TextEditingController pesoController = TextEditingController();
  TextEditingController germinacaoController = TextEditingController();
  TextEditingController espacamentoController = TextEditingController();
  TextEditingController terrenoController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _result = "Informe os dados";

  void _resetFields() {
    graosController.text = "";
    pesoController.text = "";
    germinacaoController.text = "";
    espacamentoController.text = "";
    terrenoController.text = "";
    setState(() {
      _result = "Informe os dados!";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculate() {
    setState(
      () {
        double plantas_m = double.parse(graosController.text);
        double peso = double.parse(pesoController.text);
        double germinacao = double.parse(germinacaoController.text);
        double espacamento = double.parse(espacamentoController.text);
        double terreno = double.parse(terrenoController.text);
        double quilos = 0;

        quilos =
            (((100 * peso * plantas_m) * 1.1) / (germinacao * espacamento));

        double quilos_hec = quilos;
        double quilos_alq = quilos * 2.42;
        double no_terreno_alq = quilos_alq * terreno;
        double no_terreno_hec = quilos_hec * terreno;

        double graos_germinacao = (plantas_m * 100) / germinacao;
        if (terreno > 1) {
          _result =
              " Para que nasçam ${plantas_m.toString()} sementes será preciso largar aproximadamente ${graos_germinacao.toStringAsPrecision(4)} sementes por metro linear\n\n- Em ${terreno.toString()} hectares será preciso ${quilos_alq.toStringAsPrecision(4)} quilos de sementes\n\n- Em${terreno.toString()} alqueires será preciso ${quilos_alq.toStringAsPrecision(4)} quilos de sementes\n- ";
        } else {
          _result =
              " Para que nasçam ${plantas_m.toString()} sementes será preciso largar aproximadamente ${graos_germinacao.toStringAsPrecision(4)} sementes por metro linear\n\n- Em ${terreno.toString()} hextares será preciso ${no_terreno_hec.toStringAsPrecision(4)} quilos de sementes\n\n- Em ${terreno.toString()} alqueire será preciso ${quilos_alq.toStringAsPrecision(4)} quilos de sementes\n- ";
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Soja"),
          centerTitle: true,
          backgroundColor: Colors.green[900],
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: _resetFields,
            )
          ],
        ),
        backgroundColor: Colors.green[100],
        body: Stack(
          children: <Widget>[
            SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Icon(Icons.info_outline,
                            size: 120.0, color: Colors.green),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "Número de plantas por M",
                            labelStyle:
                                TextStyle(color: Colors.lightGreen[900]),
                          ),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.lightGreen[900],
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                          ),
                          controller: graosController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Insira o número de grãs por M!";
                            }
                          },
                        ),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "Porcentagem da germinação",
                            labelStyle:
                                TextStyle(color: Colors.lightGreen[900]),
                          ),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.lightGreen[900],
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                          ),
                          controller: germinacaoController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Insira a porcentagem de germinação!";
                            }
                          },
                        ),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "Peso de 1000 (mil) sementes",
                            labelStyle:
                                TextStyle(color: Colors.lightGreen[900]),
                          ),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.lightGreen[900],
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                          ),
                          controller: pesoController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Insira o peso de 1000 (mil sementes)!";
                            }
                          },
                        ),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "Espaçamento entre linha",
                            labelStyle:
                                TextStyle(color: Colors.lightGreen[900]),
                          ),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.lightGreen[900],
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                          ),
                          controller: espacamentoController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Insira o espaçamento entre linha!";
                            }
                          },
                        ),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "Terreno",
                            labelStyle:
                                TextStyle(color: Colors.lightGreen[900]),
                          ),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.lightGreen[900],
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                          ),
                          controller: terrenoController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Informe para quantos hec/álq sera calculado";
                            }
                          },
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                          child: Container(
                            height: 70.0,
                            child: RaisedButton(
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  _calculate();
                                }
                              },
                              child: Text(
                                "Calcular",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 23.0,
                                ),
                              ),
                              color: Colors.lightGreen[900],
                            ),
                          ),
                        ),
                        Text(
                          _result,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: Colors.lightGreen[900],
                            fontSize: 23.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? dersAdi;
  int? dersKredi = 1;
  double? dersHarfDegeri = 4;
  late List<Ders> tumDersler;
  var formKey = GlobalKey<FormState>();
  double ortalama = 0;
  static int sayac = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tumDersler = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(title: Text("Ortalama Hesapla")),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (formKey.currentState!.validate()) {
              formKey.currentState!.save();
            }
          },
          child: Icon(Icons.add),
        ),
        body: OrientationBuilder(
          builder: (context, orientation) {
            if (orientation == Orientation.portrait) {
              return uygulamaGovdesi();
            } else {
              return uygulamaGovdesiLandscape();
            }
          },
        ));
  }

  Widget uygulamaGovdesi() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
              child: Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  color: Colors.white,
                  child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                                labelText: "Ders Adı",
                                hintText: "Ders Adı Giriniz",
                                hintStyle: TextStyle(fontSize: 18),
                                labelStyle: TextStyle(fontSize: 16),
                                enabledBorder:
                                    OutlineInputBorder(borderSide: BorderSide(color: Colors.purple, width: 2)),
                                focusedBorder:
                                    OutlineInputBorder(borderSide: BorderSide(color: Colors.purple, width: 2)),
                                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10)))),
                            validator: (girilenDeger) {
                              if (girilenDeger!.length > 0) {
                                return null;
                              } else
                                return "Ders Adı Boş Olamaz";
                            },
                            onSaved: (kaydedilecekDeger) {
                              dersAdi = kaydedilecekDeger;
                              setState(() {
                                tumDersler.add(Ders(dersAdi, dersHarfDegeri, dersKredi));
                                ortalama = 0;
                                ortalamaHesapla();
                              });
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<int>(
                                    items: dersKrediItems(),
                                    value: dersKredi,
                                    onChanged: (secilenKredi) {
                                      setState(() {
                                        dersKredi = secilenKredi;
                                      });
                                    },
                                  ),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.purple, width: 2),
                                    borderRadius: BorderRadius.all(Radius.circular(10))),
                              ),
                              Container(
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<double>(
                                      items: dersHarfDegerleriItems(),
                                      value: dersHarfDegeri,
                                      onChanged: (secilenHarf) {
                                        setState(() {
                                          dersHarfDegeri = secilenHarf;
                                        });
                                      },
                                    ),
                                  ),
                                  margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.purple, width: 2),
                                      borderRadius: BorderRadius.all(Radius.circular(10))),
                                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5)),
                            ],
                          ),
                        ],
                      )))),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            height: 70,
            decoration: BoxDecoration(
                border: BorderDirectional(
                    top: BorderSide(color: Colors.blue, width: 2), bottom: BorderSide(color: Colors.blue, width: 2))),
            child: Center(
                child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(children: [
                TextSpan(
                    text: tumDersler.length == 0 ? "Lütfen Ders Ekleyin" : "Ortalama: ",
                    style: TextStyle(fontSize: 25, color: Colors.black)),
                TextSpan(
                    text: tumDersler.length == 0 ? " " : "${ortalama.toStringAsFixed(2)}",
                    style: TextStyle(fontSize: 25, color: Colors.purple, fontWeight: FontWeight.bold))
              ]),
            )),
          ),
          Expanded(
              child: Container(
                  child: ListView.builder(
            itemBuilder: _listeELemanlariniOlustur,
            itemCount: tumDersler.length,
          ))),
        ],
      ),
    );
  }

  Widget uygulamaGovdesiLandscape() {
    return Container(
        child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
              child: Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  color: Colors.white,
                  child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                                labelText: "Ders Adı",
                                hintText: "Ders Adı Giriniz",
                                hintStyle: TextStyle(fontSize: 18),
                                labelStyle: TextStyle(fontSize: 16),
                                enabledBorder:
                                    OutlineInputBorder(borderSide: BorderSide(color: Colors.purple, width: 2)),
                                focusedBorder:
                                    OutlineInputBorder(borderSide: BorderSide(color: Colors.purple, width: 2)),
                                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10)))),
                            validator: (girilenDeger) {
                              if (girilenDeger!.length > 0) {
                                return null;
                              } else
                                return "Ders Adı Boş Olamaz";
                            },
                            onSaved: (kaydedilecekDeger) {
                              dersAdi = kaydedilecekDeger;
                              setState(() {
                                tumDersler.add(Ders(dersAdi, dersHarfDegeri, dersKredi));
                                ortalama = 0;
                                ortalamaHesapla();
                              });
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<int>(
                                    items: dersKrediItems(),
                                    value: dersKredi,
                                    onChanged: (secilenKredi) {
                                      setState(() {
                                        dersKredi = secilenKredi;
                                      });
                                    },
                                  ),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.purple, width: 2),
                                    borderRadius: BorderRadius.all(Radius.circular(10))),
                              ),
                              Container(
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<double>(
                                      items: dersHarfDegerleriItems(),
                                      value: dersHarfDegeri,
                                      onChanged: (secilenHarf) {
                                        setState(() {
                                          dersHarfDegeri = secilenHarf;
                                        });
                                      },
                                    ),
                                  ),
                                  margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.purple, width: 2),
                                      borderRadius: BorderRadius.all(Radius.circular(10))),
                                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5)),
                            ],
                          ),
                        ],
                      )))),
          flex: 1,
        ),
        Expanded(
          child: Text("Eklenen dersler"),
          flex: 1,
        )
      ],
    ));
  }

  List<DropdownMenuItem<int>> dersKrediItems() {
    List<DropdownMenuItem<int>> krediler = [];

    for (int i = 1; i <= 10; i++) {
      var aa = DropdownMenuItem<int>(
        value: i,
        child: Text(
          "$i Kredi",
          style: TextStyle(fontSize: 20),
        ),
      );
      krediler.add(aa);
    }

    return krediler;
  }

  List<DropdownMenuItem<double>> dersHarfDegerleriItems() {
    List<DropdownMenuItem<double>> harfler = [];
    harfler.add(DropdownMenuItem(
      child: Text("AA", style: TextStyle(fontSize: 20)),
      value: 4,
    ));
    harfler.add(DropdownMenuItem(
      child: Text("BA", style: TextStyle(fontSize: 20)),
      value: 3.5,
    ));
    harfler.add(DropdownMenuItem(
      child: Text("BB", style: TextStyle(fontSize: 20)),
      value: 3,
    ));
    harfler.add(DropdownMenuItem(
      child: Text("CB", style: TextStyle(fontSize: 20)),
      value: 2.5,
    ));
    harfler.add(DropdownMenuItem(
      child: Text("CC", style: TextStyle(fontSize: 20)),
      value: 2,
    ));
    harfler.add(DropdownMenuItem(
      child: Text("DC", style: TextStyle(fontSize: 20)),
      value: 1.5,
    ));
    harfler.add(DropdownMenuItem(
      child: Text("DD", style: TextStyle(fontSize: 20)),
      value: 1,
    ));
    harfler.add(DropdownMenuItem(
      child: Text("FF", style: TextStyle(fontSize: 20)),
      value: 0,
    ));

    return harfler;
  }

  Widget _listeELemanlariniOlustur(BuildContext context, int index) {
    sayac++;

    return Dismissible(
      key: Key(sayac.toString()),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        setState(() {
          tumDersler.removeAt(index);
          ortalamaHesapla();
        });
      },
      child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.blue.shade100, width: 2), borderRadius: BorderRadius.circular(10)),
          margin: EdgeInsets.all(10),
          child: ListTile(
            leading: Icon(
              Icons.done,
              size: 36,
            ),
            title: Text(tumDersler[index].ad.toString()),
            trailing: Icon(Icons.keyboard_arrow_right, color: Colors.black38),
            subtitle: Text(tumDersler[index].kredi.toString() +
                "kredi ders notu deger :" +
                tumDersler[index].harfDegeri.toString()),
          )),
    );
  }

  void ortalamaHesapla() {
    double toplamNot = 0;
    double toplamKredi = 0;
    for (var oankiDers in tumDersler) {
      var kredi = oankiDers.kredi;
      var harfDegeri = oankiDers.harfDegeri;
      toplamNot = toplamNot + (harfDegeri! * kredi!);
      toplamKredi += kredi;
    }
    ortalama = toplamNot / toplamKredi;
  }
}

class Ders {
  String? ad;
  double? harfDegeri;
  int? kredi;

  Ders(this.ad, this.harfDegeri, this.kredi);
}

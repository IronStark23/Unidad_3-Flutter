import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_firebase_crud/query.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController name = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController quantity = TextEditingController();

  create() async {
    try {
      await FirebaseFirestore.instance
          .collection("datos")
          .doc(price.text)
          .set({"name": name.text, "price": price.text, "quantity": quantity.text});
      // ignore: avoid_print
      print("Dato Registrado");
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  update() async {
    try {
      await FirebaseFirestore.instance
          .collection("datos")
          .doc(price.text)
          .update({"name": name.text});
      // ignore: avoid_print
      print("Dato Actualizado");
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  delete() async {
    try {
      await FirebaseFirestore.instance
          .collection("datos")
          .doc(price.text)
          .delete();
      // ignore: avoid_print
      print("Dato Eliminado");
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Crud Flutter Firebase"),
        ),
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextField(
                controller: name,
                decoration: InputDecoration(
                    labelText: "Product Name",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
              TextField(
                controller: price,
                decoration: InputDecoration(
                    labelText: "Price",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
              TextField(
                controller: quantity,
                decoration: InputDecoration(
                    labelText: "Quantity",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        create();
                        name.clear();
                        price.clear();
                        quantity.clear();
                      },
                      style:
                          TextButton.styleFrom(backgroundColor: Colors.green),
                      child: const Text("Create")),
                  ElevatedButton(
                      onPressed: () {
                        update();
                        name.clear();
                        price.clear();
                        quantity.clear();
                      },
                      style:
                          TextButton.styleFrom(backgroundColor: Colors.yellow),
                      child: const Text("Update")),
                  ElevatedButton(
                      onPressed: () {
                        delete();
                        name.clear();
                        price.clear();
                        quantity.clear();
                      },
                      style: TextButton.styleFrom(backgroundColor: Colors.red),
                      child: const Text("Delete")),
                ],
              ),
              const Queries(),
            ],
          ),
        ));
  }
}
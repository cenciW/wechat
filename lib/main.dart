import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

Future<void> main() async {
  // Certifique-se de que os widgets foram inicializados
  WidgetsFlutterBinding.ensureInitialized();

  // Inicialize o Firebase
  await Firebase.initializeApp(
    name: 'wechatdb',
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // FirebaseFirestore.instance.collection("mensagens").snapshots().listen((dado) {
  //   dado.docs.forEach((d) {
  //     print(d.data());
  //   });
  // });

  FirebaseFirestore.instance
      .collection("mensagens")
      .doc("6Wa1ikg33DJObNjSYns4")
      .snapshots()
      .listen((dado) {
    print(dado.data());
  });

  // //traz uma foto do banco de dados
  // QuerySnapshot snapshot =
  //     await FirebaseFirestore.instance.collection("mensagens").get();

  // DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
  //     .collection("mensagens")
  //     .doc("qlUQAoxIVFKGPPuMU4RX")
  //     .get();

  // snapshot.docs.forEach((d) {
  //   d.reference.update({"lido": false});
  //   print(d.data());
  //   print(d.id);
  // });

  // print(docSnapshot.data());

  // Depois de inicializar o Firebase, continue com o app
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Container(),
    );
  }
}

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
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firestore Example'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            // Obtenha a coleção 'teste' e adicione dados ao banco de dados
            final CollectionReference users =
                FirebaseFirestore.instance.collection('teste');

            await users.add({
              'full_name': 'Jane Doe',
              'company': 'Stokes and Sons',
              'age': 25,
            });

            print('Dados adicionados com sucesso');
          },
          child: Text('Adicionar dados ao Firestore'),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_hive_database/add_contact.dart';
import 'package:flutter_hive_database/contact_list.dart';
import 'package:flutter_hive_database/models/contacts.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ContactsAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Hive Database"),
      ),
      body: FutureBuilder(
          future: Hive.openBox("contacts"),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              }
              return Column(
                children: const [
                  ContactList(),
                  AddContact(),
                ],
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  @override
  void dispose() {
    // Box Compaction
    // According to the official documentation:
    // Hive is an append-only data store. When you change or delete a value, the change is written to the end of the box file. This leads sooner or later to a growing box file. Hive may automatically “compact” your box at any time. 
    // Since we are both updating and deleting values, sooner or later, the compaction will kick in. While you can leave the decision of when to compact completely up to Hive, invoking compaction manually is also possible, although rarely needed. We could, however, call compact() right before closing all the Boxes
    Hive.box('contacts').compact();
    Hive.close();
    super.dispose();
  }
}

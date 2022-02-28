import 'package:flutter/material.dart';
import 'package:flutter_hive_database/models/contacts.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ContactList extends StatelessWidget {
  const ContactList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ValueListenableBuilder<Box<dynamic>>(
          valueListenable: Hive.box("contacts").listenable(),
          builder: (context, value, child) {
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: value.length,
              itemBuilder: (context, index) {
                final contacts = value.getAt(index) as Contacts;
                return Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  color: Colors.grey.shade300,
                  child: Row(
                    children: [
                      const CircleAvatar(),
                      const SizedBox(width: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(contacts.name.toString()),
                          Text(contacts.number.toString()),
                        ],
                      )
                    ],
                  ),
                );
              },
            );
          }),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_hive_database/models/contacts.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AddContact extends StatefulWidget {
  const AddContact({
    Key? key,
  }) : super(key: key);

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();

  Future<void> _addContact(Contacts contact) async {
    final contactsBox = Hive.box("contacts");
    contactsBox.add(contact);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(5)),
            child: TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                hintText: "Name",
                hintStyle: TextStyle(color: Colors.grey),
                errorBorder: InputBorder.none,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(5)),
            child: TextFormField(
              controller: _numberController,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                hintText: "Phone Number",
                hintStyle: TextStyle(color: Colors.grey),
                errorBorder: InputBorder.none,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
              ),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                if (_nameController.text.isNotEmpty ||
                    _numberController.text.isNotEmpty) {
                  final contact = Contacts(
                      name: _nameController.text,
                      number: _numberController.text);
                  _addContact(contact).then((value) {
                    _nameController.clear();
                    _numberController.clear();
                  });
                } else {
                  const SnackBar snackBar = SnackBar(
                    content: Text('Name & Phone number cannot be empty!'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
              child: const Text("Add Contact"))
        ],
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _numberController.dispose();
    super.dispose();
  }
}

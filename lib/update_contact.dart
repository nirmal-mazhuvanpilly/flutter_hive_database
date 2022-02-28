import 'package:flutter/material.dart';
import 'package:flutter_hive_database/models/contacts.dart';
import 'package:hive_flutter/hive_flutter.dart';

class UpdateContact extends StatefulWidget {
  final String? nameController;
  final String? numberController;
  final int? index;
  const UpdateContact(
      {Key? key, this.nameController, this.numberController, this.index})
      : super(key: key);

  @override
  State<UpdateContact> createState() => _UpdateContactState();
}

class _UpdateContactState extends State<UpdateContact> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();

  @override
  void initState() {
    _nameController.text = widget.nameController!;
    _numberController.text = widget.numberController!;
    super.initState();
  }

  Future<void> _updateContact(Contacts contact) async {
    final contactsBox = Hive.box("contacts");
    contactsBox.putAt(widget.index!, contact);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Contact"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
                    hintText: "Number",
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
                      _updateContact(contact).then((value) {
                        _nameController.clear();
                        _numberController.clear();
                        Navigator.of(context).pop();
                      });
                    } else {
                      const SnackBar snackBar = SnackBar(
                        content: Text('Name & Phone number cannot be empty!'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                  child: const Text("Update Contact"))
            ],
          ),
        ),
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

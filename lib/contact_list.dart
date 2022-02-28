import 'package:flutter/material.dart';

class ContactList extends StatelessWidget {
  const ContactList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: List.generate(
          10,
          (index) => Container(
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
                  children: const [
                    Text("Name"),
                    Text("Phone Number"),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

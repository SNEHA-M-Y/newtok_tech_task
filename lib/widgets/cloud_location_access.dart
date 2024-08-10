import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CloudLocationAccess extends StatefulWidget {
  const CloudLocationAccess({super.key});

  @override
  _CloudLocationAccessState createState() => _CloudLocationAccessState();
}

class _CloudLocationAccessState extends State<CloudLocationAccess> {
  final Stream<QuerySnapshot> cloudlocationstream =
      FirebaseFirestore.instance.collection('locations').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream: cloudlocationstream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text("Loading");
            }

            return ListView(
              children: snapshot.data!.docs
                  .map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;
                    return ListTile(
                      title: Text(
                        data['city'],
                        style: const TextStyle(color: Colors.black),
                      ),
                      trailing: Text(
                        data['country'],
                        style: const TextStyle(color: Colors.black),
                      ),
                      subtitle: Text(
                        data['state'],
                        style: const TextStyle(color: Colors.black),
                      ),
                    );
                  })
                  .toList()
                  .cast(),
            );
          },
        ),
      ),
    );
  }
}

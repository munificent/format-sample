import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kudaopenapi/kudaopenapi.dart';

class ListVAccount extends StatefulWidget {
  const ListVAccount({super.key});

  @override
  State<ListVAccount> createState() => _ListVAccountState();
}

class _ListVAccountState extends State<ListVAccount> {
  Map<String, dynamic> data = {'PageSize': "30", 'PageNumber': "1"};
  String requestRef = Random().nextInt(100000).toString();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: BackButton(onPressed: () => Navigator.of(context).pop()),
          title: const Text("List Virtual Account"),
        ),
        body: FutureBuilder<ListVirtualAccountResponse>(
          future: KudaBank().list_virtual_account(data, requestRef),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.data.accounts.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const Icon(Icons.list),
                    trailing: Text(
                      snapshot.data!.data!.accounts[index].accountNumber,
                      style: TextStyle(color: Colors.green, fontSize: 15),
                    ),
                    title: Text(
                      snapshot.data!.data!.accounts[index].accountName
                          .toString(),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}

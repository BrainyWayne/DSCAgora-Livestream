import 'package:flutter/material.dart';


class AccountSecurity extends StatefulWidget {
  @override
  _AccountSecurityState createState() => _AccountSecurityState();
}

class _AccountSecurityState extends State<AccountSecurity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Account Security"),
      ),
      body: ListView(
        children: <Widget>[

          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Encryption",
              style: TextStyle(color: Colors.green),
            ),
          ),
          SizedBox(
            height: 15,
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Exemplar uses end to end encryption provided by Agora SDK to provide maximum security.",
              style: TextStyle(
                  fontWeight: FontWeight.w500, fontSize: 18),
            ),
          ),

        ],
      ),

    );
  }
}

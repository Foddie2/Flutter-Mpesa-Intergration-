import 'package:flutter/material.dart';
import 'package:mpesa_flutter_plugin/mpesa_flutter_plugin.dart';
import 'package:flutter/services.dart';
import 'dart:async';

void main() {
  MpesaFlutterPlugin.setConsumerKey("kVbAIHO3fyJSNvYaooZeVjCfNCAjBAQ7");
  MpesaFlutterPlugin.setConsumerSecret("kKnYdiotLuCxZUnO");

  runApp(DarajaFlutter());
}

class DarajaFlutter extends StatefulWidget {
  @override
  _DarajaFlutterState createState() => _DarajaFlutterState();
}

class _DarajaFlutterState extends State<DarajaFlutter> {
  final TextEditingController phonenumberController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  //create the lipaNaMpesa method here.Please note, the method can have any name, I chose lipaNaMpesa

  Future<void> lipaNaMpesa() async {
    var phoneNumber = phonenumberController.text;
    var CodeKe = '254';
    phoneNumber = phoneNumber.substring(1);
    phoneNumber = CodeKe+phoneNumber;
    print(phonenumberController.text);
    dynamic amount = double.parse(amountController.text);

    dynamic transactionInitialisation;
    try {
      transactionInitialisation =
          await MpesaFlutterPlugin.initializeMpesaSTKPush(
              businessShortCode: "174379",
              transactionType: TransactionType.CustomerPayBillOnline,
              amount: amount,
              partyA: phoneNumber,
              partyB: "174379",
//Lipa na Mpesa Online ShortCode
              callBackURL: Uri(scheme: "http",
                  host: "mpesa-requestbin.herokuapp.com",
                  path: "/15hdjxp1"),
//This url has been generated from http://mpesa-requestbin.herokuapp.com/?ref=hackernoon.com for test purposes
              accountReference: "Foddie",
              phoneNumber: phoneNumber,
              baseUri: Uri(scheme: "https",
                  host: "sandbox.safaricom.co.ke"),
              transactionDesc: "purchase",
              passKey:
                  "bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919");
//This passkey has been generated from Test Credentials from Safaricom Portal

      return transactionInitialisation;
    } catch (e) {
      print("CAUGHT EXCEPTION: " + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.green),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Mpesa Payment by Foddie'),
          centerTitle: true,
        ),
        body: Center(
          child: Container(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    controller: phonenumberController,
                    decoration: InputDecoration(labelText: "Enter your number"),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ], // Only numbers can be entered
                  ),
                  TextFormField(
                    controller: amountController,
                    decoration: InputDecoration(labelText: "Amount"),
                    keyboardType: TextInputType.number, // Only numbers can be entered
                  ),
                  SizedBox(height: 30,),
                  RaisedButton(
                    color: Colors.green,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    onPressed: () {
                      lipaNaMpesa();
                    },
                    child: Text(
                      "Lipa na Mpesa",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
          )
        ),
      ),
    );
  }
}

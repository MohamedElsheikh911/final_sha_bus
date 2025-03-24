import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(cardd());
}

class cardd extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: card(),
    );
  }
}

class card extends StatelessWidget {
  final Color primaryColor = Color(0xFF1E3A8A);
  final Color buttonColor = Color(0xFF1E3A8A);
  final Color textColor = Colors.white;
  final Color black = Colors.black;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {},
        ),
        title: Text(
          'Payment Method',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double padding = constraints.maxWidth * 0.05;
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: padding),
            child: Column(
              children: [
                SizedBox(height: 20),
                _buildPriceCard(),
                SizedBox(height: 20),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _buildTextField('Credit Card Number',
                            'Enter your card number', TextInputType.number),
                        SizedBox(height: 20),
                        _buildExpirationFields(),
                        SizedBox(height: 20),
                        _buildTextField(
                            'Security Code', 'CVC/CVV', TextInputType.number),
                      ],
                    ),
                  ),
                ),
                _buildButton('Pay Now', buttonColor, textColor, () {}),
                SizedBox(height: 10),
                _buildButton('Back', Colors.white, black, () {},
                    border: BorderSide(color: Colors.black)),
                SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildPriceCard() {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12),
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 5, spreadRadius: 2),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Price',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Text(
            '5390 EGP',
            style: TextStyle(
                fontSize: 22, fontWeight: FontWeight.bold, color: primaryColor),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, String hint, TextInputType type) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            hintText: hint,
          ),
          keyboardType: type,
        ),
      ],
    );
  }

  Widget _buildExpirationFields() {
    return Row(
      children: [
        Expanded(child: _buildTextField('Year', 'YY', TextInputType.number)),
        SizedBox(width: 15),
        Expanded(child: _buildTextField('Month', 'MM', TextInputType.number)),
      ],
    );
  }

  Widget _buildButton(
      String text, Color bgColor, Color textColor, VoidCallback onPressed,
      {BorderSide? border}) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: border ?? BorderSide.none,
          ),
        ),
        onPressed: onPressed,
        child: Text(text,
            style: TextStyle(
                color: textColor, fontSize: 18, fontWeight: FontWeight.bold)),
      ),
    );
  }
}

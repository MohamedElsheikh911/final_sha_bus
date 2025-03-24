import 'package:flutter/material.dart';

void main() {
  runApp(PaymentApp());
}

class PaymentApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ThankForPayScreen(),
    );
  }
}

class ThankForPayScreen extends StatelessWidget {
  final Color primaryColor = const Color(0xFF1E3A8A);
  final Color textColor = const Color(0xFFFFFFFF);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Thanks for Payment',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // صندوق السعر
              Container(
                width: screenWidth * 0.9,
                height: screenHeight * 0.1,
                margin: EdgeInsets.only(top: screenHeight * 0.05),
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Price',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '5390 EGP',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: screenHeight * 0.05),

              // قسم تاريخ الرحلة
              Text(
                'Your Trip Date',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Container(
                width: screenWidth * 0.6,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border:
                      Border.all(color: primaryColor, width: 2), // إضافة إطار
                ),
                child: Center(
                  child: Text(
                    'Sun, 17 NOV',
                    style: TextStyle(fontSize: 25, color: primaryColor),
                  ),
                ),
              ),

              SizedBox(height: screenHeight * 0.05),

              // قسم رقم المقعد
              Text(
                'Your Seat No.',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Container(
                width: screenWidth * 0.4,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border:
                      Border.all(color: primaryColor, width: 2), // إضافة إطار
                ),
                child: Center(
                  child: Text(
                    'A3',
                    style: TextStyle(fontSize: 25, color: primaryColor),
                  ),
                ),
              ),

              SizedBox(height: screenHeight * 0.07),

              Text(
                'HAPPY YEAR',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),

              SizedBox(height: screenHeight * 0.07),

              // زر العودة إلى الصفحة الرئيسية
              SizedBox(
                width: screenWidth * 0.7,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    // هنا يمكن وضع الأكشن المناسب
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Text(
                    'GO TO HOME',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),

              SizedBox(height: screenHeight * 0.03),

              // زر تسجيل الخروج
              SizedBox(
                width: screenWidth * 0.7,
                height: 50,
                child: OutlinedButton(
                  onPressed: () {
                    // هنا يمكن وضع الأكشن المناسب
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: primaryColor, width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Text(
                    'LOG OUT',
                    style: TextStyle(color: primaryColor, fontSize: 18),
                  ),
                ),
              ),

              SizedBox(height: screenHeight * 0.05),
            ],
          ),
        ),
      ),
    );
  }
}

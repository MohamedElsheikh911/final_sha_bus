import 'package:final_project/Sha_Bus/Departure%20Trips%202.dart';
import 'package:final_project/Sha_Bus/card_pay.dart';
import 'package:flutter/material.dart';

import 'Fawry_Pay.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PaymentMethodScreen(),
    );
  }
}

class AppColors {
  static const Color primaryBlue = Color(0xFF0A4DA2);
  static const Color white = Color(0xFFFFFFFF);
  static const Color grey = Color(0xFF707070);
  static const Color buttonBlue = Color(0xFF003E7E);
  static const Color lightGrey = Color(0xFFD3D3D3);
}

class PaymentMethodScreen extends StatefulWidget {
  @override
  _PaymentMethodScreenState createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  String? selectedMethod;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: screenHeight * 0.3,
              decoration: const BoxDecoration(
                color: AppColors.primaryBlue,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(180),
                ),
              ),
              padding: EdgeInsets.only(
                left: screenWidth * 0.05,
                top: screenHeight * 0.05,
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: AppColors.white),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => DepartureTripsScreen(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    "Payment method",
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  paymentOption(
                    title: "Credit card",
                    image: Image.asset(
                      "assets/images/visa.png",
                      width: screenWidth * 0.4,
                    ),
                  ),
                  divider(),
                  paymentOption(
                    title: "Fawry",
                    image: Image.asset(
                      "assets/images/fawry.png",
                      width: screenWidth * 0.3,
                    ),
                  ),
                  divider(),
                  paymentOption(
                    title: "Aman",
                    image: Image.asset(
                      "assets/images/Aman.png",
                      width: screenWidth * 0.3,
                    ),
                  ),
                  divider(),
                  paymentOption(
                    title: "Smart_Wallet",
                    image: Image.asset(
                      "assets/images/wellet.png",
                      width: screenWidth * 0.2,
                    ),
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (selectedMethod != null) {
                          navigateToSelectedScreen();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Please select a payment method."),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.buttonBlue,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: const Text(
                        "Verify Code",
                        style: TextStyle(
                          fontSize: 18,
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void navigateToSelectedScreen() {
    Widget nextScreen;

    switch (selectedMethod) {
      case "Credit card":
        nextScreen = cardd();
        break;
      case "Fawry":
        nextScreen = PaymentScreen();
        break;
      case "Aman":
        nextScreen = AmanScreen();
        break;
      case "Smart_Wallet":
        nextScreen = SmartWalletScreen();
        break;
      default:
        return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => nextScreen),
    );
  }

  Widget paymentOption({required String title, required Widget image}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: () {
          setState(() {
            selectedMethod = title;
          });
        },
        child: Row(
          children: [
            Radio(
              value: title,
              groupValue: selectedMethod,
              onChanged: (value) {
                setState(() {
                  selectedMethod = value as String?;
                });
              },
              activeColor: AppColors.primaryBlue,
            ),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(fontSize: 22, color: AppColors.grey),
              ),
            ),
            image,
          ],
        ),
      ),
    );
  }

  Widget divider() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Divider(color: AppColors.lightGrey, thickness: 1),
    );
  }
}

// الصفحات البديلة بناءً على الاختيار
class CreditCardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Credit Card Payment")),
      body: Center(child: Text("Credit Card Payment Screen")),
    );
  }
}

class FawryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Fawry Payment")),
      body: Center(child: Text("Fawry Payment Screen")),
    );
  }
}

class AmanScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Aman Payment")),
      body: Center(child: Text("Aman Payment Screen")),
    );
  }
}

class SmartWalletScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Smart Wallet Payment")),
      body: Center(child: Text("Smart Wallet Payment Screen")),
    );
  }
}

import 'package:final_project/Sha_Bus/select_pay.dart';
import 'package:flutter/material.dart';

import 'choose_Your_Seat.dart';

void main() {
  runApp(DepartureTripsApp());
}

class DepartureTripsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Departure Trips',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DepartureTripsPage(),
    );
  }
}

class DepartureTripsPage extends StatefulWidget {
  @override
  _DepartureTripsPageState createState() => _DepartureTripsPageState();
}

class _DepartureTripsPageState extends State<DepartureTripsPage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Departure Trips',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(width * 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTripDetails(width, height),
                SizedBox(height: height * 0.02),
                _buildTotalPrice(width, height),
                SizedBox(height: height * 0.02),
                _buildSelectSeats(width, context),
                SizedBox(height: height * 0.04),
                _buildPaymentButton(width, context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

  Widget _buildTripDetails(double width, double height) {
    return Container(
      padding: EdgeInsets.all(width * 0.07),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Travel From", style: TextStyle(color: Colors.grey)),
                    Text("Nasr City (Nadi El-sekka)\nCairo",
                        style: TextStyle(
                            fontSize: width * 0.05, color: Colors.orange)),
                    SizedBox(height: height * 0.02),
                    Text("7:00 AM",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: width * 0.06)),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward, size: width * 0.1, color: Colors.blue),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Travel To", style: TextStyle(color: Colors.grey)),
                    Text("Alshureq",
                        style: TextStyle(
                            fontSize: width * 0.05, color: Colors.orange)),
                    SizedBox(height: height * 0.02),
                    Text("9:00 AM",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: width * 0.06)),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: height * 0.02),
          Text("2026-11-29", style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildTotalPrice(double width, double height) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.1,
        vertical: height * 0.02,
      ),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Total Price", style: TextStyle(fontSize: width * 0.05)),
          Text("5580 EGP",
              style: TextStyle(
                  color: Colors.orange,
                  fontSize: width * 0.05,
                  fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildSelectSeats(double width, BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ChooseYourSeat()),
          );
        },
        child: Text(
          "Select Seats",
          style: TextStyle(color: Colors.blue, fontSize: width * 0.05),
        ),
      ),
    );
  }

  Widget _buildPaymentButton(double width, BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          minimumSize: Size(width * 0.8, 50),
          padding: EdgeInsets.symmetric(vertical: 10),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PaymentMethodScreen()),
          );
        },
        child: Text(
          "Payment",
          style: TextStyle(color: Colors.white, fontSize: width * 0.05),
        ),
      ),
    );
    }


import 'package:final_project/Sha_Bus/Departure%20Trips%202.dart';
import 'package:final_project/Sha_Bus/Departure%20Trips.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ChooseYourSeat());
}

class ChooseYourSeat extends StatelessWidget {
  const ChooseYourSeat({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const BusSeatLayout(),
    );
  }
}

class BusSeatLayout extends StatefulWidget {
  const BusSeatLayout({super.key});

  @override
  _BusSeatLayoutState createState() => _BusSeatLayoutState();
}

class _BusSeatLayoutState extends State<BusSeatLayout> {
  final List<List<String?>> seatLayout = [
    ['a1', 'a2', null, 'a3', 'a4'],
    ['b1', 'b2', null, 'b3', 'b4'],
    ['c1', 'c2', null, 'c3', 'c4'],
    ['d1', 'd2', null, 'd3', 'd4'],
    ['e1', 'e2', null, 'e3', 'e4'],
    ['f1', 'f2', null, 'f3', 'f4'],
    ['g1', 'g2', null, 'g3', 'g4'],
    ['h1', 'h2', null, 'h3', 'h4'],
    ['i1', 'i2', null, 'i3', 'i4'],
    ['j1', 'j2', null, 'j3', 'j4'],
    ['k1', 'k2', null, 'k3', 'k4'],
    ['l1', 'l2', null, 'l3', 'l4'],
    ['m1', 'm2', 'm3', 'm4'],
  ];

  final Map<String, Color> selectedSeats = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Choose Your Seat',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xffFFFBFE),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black, size: 25),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => DepartureTripsScreen1()),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _legendItem(Colors.blue, 'Male Selected'),
                  const SizedBox(height: 12),
                  _legendItem(Colors.pink, 'Female Selected'),
                  const SizedBox(height: 12),
                  _legendItem(Colors.grey, 'Available'),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children:
                  seatLayout
                      .map(
                        (row) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:
                                row.map((seat) {
                                  if (seat == null) {
                                    return _emptySpace();
                                  } else {
                                    return GestureDetector(
                                      onTap: () => _selectSeat(seat),
                                      child: SeatWidget(
                                        seatLabel: seat,
                                        seatColor:
                                            selectedSeats[seat] ?? Colors.grey,
                                      ),
                                    );
                                  }
                                }).toList(),
                          ),
                        ),
                      )
                      .toList(),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => DepartureTripsScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 32, 85, 153),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 15,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                side: const BorderSide(color: Color(0xFF205599), width: 2),
              ),
              child: const Text('ChooseYourSeat'),
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }

  void _selectSeat(String seat) {
    if (selectedSeats.containsKey(seat)) {
      setState(() {
        selectedSeats.remove(seat);
      });
      return;
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Select Gender"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    selectedSeats[seat] = Colors.blue;
                  });
                  Navigator.pop(context);
                },
                child: const Text("Male"),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    selectedSeats[seat] = Colors.pink;
                  });
                  Navigator.pop(context);
                },
                child: const Text("Female"),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _legendItem(Color color, String text) {
    return Row(
      children: [
        Container(width: 20, height: 20, color: color),
        const SizedBox(width: 8),
        Text(text),
      ],
    );
  }

  Widget _emptySpace() {
    return const SizedBox(width: 50, height: 70);
  }
}

class SeatWidget extends StatelessWidget {
  final String seatLabel;
  final Color seatColor;

  const SeatWidget({required this.seatLabel, required this.seatColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 70,
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        color: seatColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black, width: 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            seatLabel,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          const Icon(Icons.event_seat, color: Colors.black, size: 24),
        ],
      ),
    );
  }
}

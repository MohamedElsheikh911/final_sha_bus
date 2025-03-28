import 'package:final_project/Sha_Bus/Departure%20Trips.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// تهيئة Firebase عند بدء التطبيق
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(BusBookingApp());
}

class BusBookingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: MainScreen());
  }
}

// Main Screen with Custom Bottom Bar
class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 1;

  final List<Widget> _pages = [
    StationsScreen(),
    BusBookingScreen(),
    MoreScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          // الصفحة الحالية
          SafeArea(
            child: _pages[_selectedIndex],
          ),
          // Custom Bottom Bar
          Positioned(
            left: screenWidth * 0.05,
            right: screenWidth * 0.05,
            bottom: screenHeight * 0.02,
            child: Container(
              height: 60, // ارتفاع الشريط السفلي
              decoration: BoxDecoration(
                color: Color(0xff1F5599), // نفس اللون الأزرق
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Stations
                  IconButton(
                    icon: Icon(
                      Icons.location_on,
                      size: 30,
                      color: _selectedIndex == 0 ? Colors.white : Colors.white70,
                    ),
                    onPressed: () => _onItemTapped(0),
                  ),
                  // Home
                  IconButton(
                    icon: Icon(
                      Icons.home,
                      size: 30,
                      color: _selectedIndex == 1 ? Colors.white : Colors.white70,
                    ),
                    onPressed: () => _onItemTapped(1),
                  ),
                  // More
                  IconButton(
                    icon: Icon(
                      Icons.more_horiz,
                      size: 30,
                      color: _selectedIndex == 2 ? Colors.white : Colors.white70,
                    ),
                    onPressed: () => _onItemTapped(2),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Bus Booking Screen (Home Page)
class BusBookingScreen extends StatefulWidget {
  @override
  _BusBookingScreenState createState() => _BusBookingScreenState();
}

class _BusBookingScreenState extends State<BusBookingScreen> {
  bool isOneWay = true;
  DateTime? departDate;
  DateTime? returnDate;
  String? selectedFrom;
  String? selectedGovernorate;
  String? selectedPlace;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Map<String, List<String>> governorates = {
    'Cairo': ['Maydan alasmaeilih', 'Sabe elmarat', 'Khalifuh almannun', 'Alharih mall', 'Bitru jit', 'Sinima rulssi', 'Almahkamuh', 'Airiqabuh aladaryh'],
    'Zagazig': ['Buni Shibl Handash', 'Buni Shibl Aealam', 'Almahafizuh', 'Alsaahil Talabah', 'Alziraeu', 'Almahatah Talabuh'],
    'Al-Ashir': ['Mujawiruh 63', 'Mujawiruh 50', 'Mujawiruh 54', 'Nadi Alruwaad', 'Mujawiruh 13', 'Social Clup'],
    'Minya El-Qamh': ['Kashari Alzaein', 'Shalshalmon', 'Shubra al.Nakhla', 'Station', 'Mayi Jabir'],
    'Belbeis': ['Abu Sharaf Workers', 'Air Force College', 'Station', 'Aleadlayh', 'Albahr'],
    'Banha': ['Mayat Hilfah', 'Asharah', 'Station', 'Qaha', 'Murur Aluwkh'],
    'Al-Qanatir': ['Shibin Atganatir', 'Aho Zaebal', 'Alearah'],
    'Ambabuh': ['Sharie Alwahdih', 'Alwaraaq', 'Mustashfi Alhamiaat'],
    'Giza': ['Fatin Hamamah', 'Nadi Alsikah Haddid', 'Manshiet Nasser', 'Manshiat Nasir', 'Sayidah Eayishah', 'Mashikhuh Aazhar', 'Almalik Alsaalih', 'Mustashfi Alramad'],
    'Al-Muhandisin': ['Farghili', 'Ahmed Eurabi', 'Sharie Aljamieih Alduwal', 'Ahmed Eabdaleazia', 'Nafaq Shiratun'],
    'Abu Zaabal': ['Madkhal Abo zaeabal', 'Alkhanika', 'Alsalam'],
    'Al-Sawah': ['Almustaemiruh', 'Mmaydan alsuwaah', 'Mateam alsalam', 'Alqahriah Iliaduth', 'Masakin alsaoudih', 'Bisku misr', 'Qasr altaahirih', 'Altarakhis'],
    'Ismailia': ['New University', 'Old University', 'Fox Square', 'Seventh Niqabuh', 'Almulandasityn', 'Ringing Highway', 'Numtazah'],
    'Al-Shorouk': ['Alskan Almustaqbal', 'Alskan Alsabein', 'Almitru qism Alshuruq', 'Hajar Alasas', 'Aljihaz'],
    'Al-Rehab': ['Al-Rehab and the first American school', 'National gasoline', 'First Assembly'],
    'Sheraton': ['Nachad Alshiyturun', 'Alakdimih Allahrih', 'High Life'],
    'Helwan': ['Albanik alahliu', 'Althaanawayh banat', 'Almaesaruh mucaskar aljaysh', 'Almaesaruh alsilm', 'Sh rayli eali sharif', 'Kubri tarah', 'Kubri albarun alalawirin'],
    'Al-Thry': ['Ramsis', 'Mustashfi alqibti', 'Ghanaruh', 'Jamie almustafii', 'Masjid alwahdih', 'Aleabaasih', 'Elmarat aleubur', 'Kubri alfinjari'],
    'Shubra': ['Sinama balas', 'Handasuh shubra', 'Alamir mali', 'Dawaran shibra', 'Alkhalafawaa', 'Sant tritza', 'Almuasisuh', 'Bahtim', 'Mustarud', 'Muasisuh aldhaka'],
    'Jisr Al-Suways': ['Ahmed Elsmat', 'Maydan Almatrih', 'Mustashfi Albakri', 'Hulmih Atayrun', 'Alf Maskan', 'Altanjid', 'Ahn Alhakam'],
    'Al-Haram': ['Alearish', 'Aleumranin', 'Almatbaeuh', 'Khatam Almursalin'],
    'Al-Maadi': ['Almahkamuh Aldusturih', 'Salam Alnaasljun', 'Maydan Swyrs', 'Karfur'],
    'Mit Ghamr': ['Alziraea', 'Sahrajt', 'Kafar Shakr', 'Mayat Aleiz'],
    'Zaytun': ['Muzlaqan Eayn Shams', 'Sintiral Eayn Shams', 'Maydan Alnieam', 'Maehad Almutrih', 'Saeb Salish'],
    'Muqatam': ['Kaltiks Alawi', 'Kaltikas Althaani', 'Maydan Alnaafurih', 'Almafariquh', 'Almubayl'],
    'Al-Suways': ['Almuthalath', 'Mahatah Algitar', 'Sinama Misr', 'Aleawayid', 'Aliarbaeayn', 'Almustaqbal', 'List'],
  };

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      drawer: Drawer(
        child: FutureBuilder<String>(
          future: _getUserFullName(),
          builder: (context, snapshot) {
            String username = snapshot.data ?? 'User Name';
            return ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                UserAccountsDrawerHeader(
                  accountName: Text(username, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  accountEmail: Text(_auth.currentUser?.email ?? 'user@example.com', style: TextStyle(fontSize: 16)),
                  currentAccountPicture: CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage('https://picsum.photos/150'),
                    onBackgroundImageError: (exception, stackTrace) => print('Error loading image: $exception'),
                    child: Icon(Icons.person, size: 40, color: Colors.white),
                  ),
                  decoration: BoxDecoration(color: Color(0xff1F5599)),
                ),
                ListTile(leading: Icon(Icons.person), title: Text('Profile'), onTap: () => Navigator.pop(context)),
                ListTile(leading: Icon(Icons.settings), title: Text('Settings'), onTap: () => Navigator.pop(context)),
                ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('Logout'),
                  onTap: () {
                    _auth.signOut();
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Color(0xff1F5599),
              padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02, horizontal: screenWidth * 0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppBar(
                    backgroundColor: Color(0xff1F5599),
                    elevation: 0,
                    title: Center(
                      child: Text(
                        'Book Your Sha_Bus Trip Now !',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: screenWidth * 0.05),
                      ),
                    ),
                    leading: Builder(
                      builder: (context) => IconButton(
                        icon: Icon(Icons.menu, color: Colors.white),
                        onPressed: () => Scaffold.of(context).openDrawer(),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  Center(
                    child: ToggleButtons(
                      isSelected: [isOneWay, !isOneWay],
                      selectedColor: Colors.white,
                      fillColor: Color.fromARGB(255, 255, 193, 7),
                      color: Colors.black,
                      borderColor: Colors.grey,
                      selectedBorderColor: Colors.grey,
                      borderRadius: BorderRadius.circular(15),
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1, vertical: screenHeight * 0.01),
                          child: Text('ONE WAY', style: TextStyle(fontSize: screenWidth * 0.04, fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08, vertical: screenHeight * 0.02),
                          child: Text('ROUND TRIP', style: TextStyle(fontSize: screenWidth * 0.04, fontWeight: FontWeight.bold)),
                        ),
                      ],
                      onPressed: (index) => setState(() => isOneWay = index == 0),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.04),
                  Text('FROM', style: TextStyle(fontSize: screenWidth * 0.04, fontWeight: FontWeight.bold, color: Colors.white)),
                  ListTile(
                    title: Text(selectedFrom ?? 'Select Place', style: TextStyle(fontSize: screenWidth * 0.045, color: Colors.white)),
                    subtitle: Text(selectedPlace ?? 'Choose departure Station', style: TextStyle(fontSize: screenWidth * 0.035, color: Color(0xff9C9B9E))),
                    trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
                    onTap: () => _showGovernoratePicker(context),
                  ),
                  Divider(color: Colors.white, thickness: 2.0),
                  Text('TO', style: TextStyle(fontSize: screenWidth * 0.04, fontWeight: FontWeight.bold, color: Colors.white)),
                  ListTile(
                    title: Text('ALSHURUQ', style: TextStyle(fontSize: screenWidth * 0.045, color: Colors.white)),
                    trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
                    onTap: () {},
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(screenWidth * 0.04),
              child: Column(
                children: [
                  Divider(thickness: 2.0, color: Colors.black),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('DEPART ON', style: TextStyle(fontSize: screenWidth * 0.04, fontWeight: FontWeight.bold)),
                            ListTile(
                              title: Text(
                                departDate != null ? '${departDate!.toLocal()}'.split(' ')[0] : 'Select Date',
                                style: TextStyle(fontSize: screenWidth * 0.04),
                              ),
                              trailing: Icon(Icons.calendar_today),
                              onTap: () async {
                                DateTime? date = await selectDate(context, departDate);
                                if (date != null) setState(() => departDate = date);
                              },
                            ),
                          ],
                        ),
                      ),
                      if (!isOneWay) ...[
                        SizedBox(width: screenWidth * 0.04),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('RETURN ON', style: TextStyle(fontSize: screenWidth * 0.04, fontWeight: FontWeight.bold)),
                              ListTile(
                                title: Text(
                                  returnDate != null ? '${returnDate!.toLocal()}'.split(' ')[0] : 'Select Date',
                                  style: TextStyle(fontSize: screenWidth * 0.04),
                                ),
                                trailing: Icon(Icons.calendar_today),
                                onTap: () async {
                                  DateTime? date = await selectDate(context, returnDate);
                                  if (date != null) setState(() => returnDate = date);
                                  },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      backgroundColor: Color(0xff205599),
                      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.3, vertical: screenHeight * 0.02),
                      side: BorderSide(color: Colors.blue),
                    ),
                    child: Text('SEARCH', style: TextStyle(fontSize: screenWidth * 0.04, color: Colors.white)),
                    onPressed: () {
                      if (selectedFrom != null && departDate != null && (isOneWay || returnDate != null)) {
                        _saveBookingToFirestore();
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => DepartureTripsScreen1()));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please fill all required fields')));
                      }
                    },
                  ),
                  SizedBox(height: screenHeight * 0.04), // مسافة إضافية تحت للـ Scroll
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<DateTime?> selectDate(BuildContext context, DateTime? initialDate) async {
    DateTime now = DateTime.now();
    return showDatePicker(
      context: context,
      initialDate: initialDate ?? now,
      firstDate: now,
      lastDate: DateTime(now.year + 1),
    );
  }

  Future<String> _getUserFullName() async {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot doc = await _firestore.collection('users').doc(user.email).get();
      return doc['fullName'] ?? 'User Name';
    }
    return 'User Name';
  }

  void _saveBookingToFirestore() async {
    User? user = _auth.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('يرجى تسجيل الدخول أولاً')));
      return;
    }

    String userEmail = user.email!;
    String fullName = await _getUserFullName();

    await _firestore.collection('registeredUsers').doc(userEmail).set({
      'fullName': fullName,
      'email': userEmail,
      'registeredAt': DateTime.now(),
    }, SetOptions(merge: true));

    final now = DateTime.now();
    Map<String, dynamic> bookingData = {
      'userEmail': userEmail,
      'fullName': fullName,
      'tripType': isOneWay ? 'One Way' : 'Round Trip',
      'registrationDate': now,
      'departureStation': selectedFrom!,
      'arrivalStation': 'ALSHURUQ',
      'bookingDate': now,
      'tripDate': departDate!,
      'returnDate': isOneWay ? null : returnDate,
    };

    try {
      await _firestore.collection('bookings').add(bookingData);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('تم حفظ الحجز بنجاح')));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('فشل في حفظ الحجز: $e')));
    }
  }

  void _showGovernoratePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Select Governorate', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: governorates.length,
                  itemBuilder: (context, index) {
                    String governorate = governorates.keys.elementAt(index);
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      elevation: 2,
                      child: ListTile(
                        title: Text(governorate, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        trailing: Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          setState(() => selectedGovernorate = governorate);
                          Navigator.pop(context);
                          _showPlacesPicker(context, governorate);
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showPlacesPicker(BuildContext context, String governorate) {
    List<String> places = governorates[governorate]!;
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Places in $governorate', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: places.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      elevation: 2,
                      child: ListTile(
                        title: Text(places[index]),
                        onTap: () {
                          setState(() {
                            selectedFrom = '$governorate - ${places[index]}';
                            selectedPlace = places[index];
                          });
                          Navigator.pop(context);
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// Placeholder for Stations Screen
class StationsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Stations'), backgroundColor: Color(0xff1F5599)),
      body: Center(child: Text('Stations Page')),
    );
  }
}

// More Screen
class MoreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          ClipPath(
            clipper: CustomClipperPath(),
            child: Container(height: screenHeight * 0.25, color: Color(0xff1F5599)),
          ),
          Column(
            children: [
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                title: Text('More', style: TextStyle(color: Colors.black, fontSize: screenWidth * 0.05, fontWeight: FontWeight.bold)),
                centerTitle: true,
              ),
              Center(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.15, vertical: screenHeight * 0.015),
                  decoration: BoxDecoration(color: Color(0xff1F5599), borderRadius: BorderRadius.circular(30)),
                  child: Text(
                    'SHA_BUS',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenWidth * 0.08,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      fontFamily: 'CustomFont',
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.04),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                  children: [
                    ListTile(leading: Icon(Icons.directions_bus, color: Colors.black), title: Text('Buses'), onTap: () {}),
                    ListTile(leading: Icon(Icons.question_answer, color: Colors.black), title: Text('FAQs'), onTap: () {}),
                    Divider(color: Colors.grey),
                    ListTile(leading: Icon(Icons.people, color: Colors.black), title: Text('About Us'), onTap: () {}),
                    ListTile(leading: Icon(Icons.build, color: Colors.black), title: Text('Services'), onTap: () {}),
                    ListTile(leading: Icon(Icons.description, color: Colors.black), title: Text('Terms and Conditions'), onTap: () {}),
                    Divider(color: Colors.grey),
                    ListTile(leading: Icon(Icons.phone, color: Colors.black), title: Text('Contact Us'), onTap: () {}),
                    ListTile(leading: Icon(Icons.language, color: Colors.black), title: Text('Language'), onTap: () {}),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Custom Clipper for the curved background
class CustomClipperPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 50);
    path.quadraticBezierTo(size.width / 4, size.height, size.width / 2, size.height);
    path.quadraticBezierTo(size.width * 3 / 4, size.height, size.width, size.height - 50);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
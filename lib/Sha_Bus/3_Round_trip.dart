import 'package:final_project/Sha_Bus/reset_Pay.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(BusBookingApp());
}

class BusBookingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BusBookingScreen(),
    );
  }
}

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

  Map<String, List<String>> governorates = {
    'Cairo': [
      'Maydan alasmaeilih',
      'Sabe elmarat',
      'Khalifuh almannun',
      'Alharih mall',
      'Bitru jit',
      'Sinima rulssi',
      'Almahkamuh',
      'Airiqabuh aladaryh',
    ],
    'Zagazig': [
      'Buni Shibl Handash',
      'Buni Shibl Aealam',
      'Almahafizuh',
      'Alsaahil Talabah',
      'Alziraeu',
      'Almahatah Talabuh',
    ],
    'Al-Ashir': [
      'Mujawiruh 63',
      'Mujawiruh 50',
      'Mujawiruh 54',
      'Nadi Alruwaad',
      'Mujawiruh 13',
      'Social Clup'
    ],
    'Minya El-Qamh': [
      'Kashari Alzaein',
      'Shalshalmon',
      'Shubra al.Nakhla',
      'Station',
      'Mayi Jabir'
    ],
    'Belbeis': [
      'Abu Sharaf Workers',
      'Air Force College',
      'Station',
      'Aleadlayh',
      'Albahr'
    ],
    'Banha': ['Mayat Hilfah', 'Asharah', 'Station', 'Qaha', 'Murur Aluwkh'],
    'Al-Qanatir': ['Shibin Atganatir', 'Aho Zaebal', 'Alearah'],
    'Ambabuh': ['Sharie Alwahdih', 'Alwaraaq', 'Mustashfi Alhamiaat'],
    'Giza': [
      'Fatin Hamamah',
      'Nadi Alsikah Haddid',
      'Manshiet Nasser',
      'Manshiat Nasir',
      'Sayidah Eayishah',
      'Mashikhuh Aazhar',
      'Almalik Alsaalih',
      'Mustashfi Alramad'
    ],
    'Al-Muhandisin': [
      'Farghili',
      'Ahmed Eurabi',
      'Sharie Aljamieih Alduwal',
      'Ahmed Eabdaleazia',
      'Nafaq Shiratun'
    ],
    'Abu Zaabal': ['Madkhal Abo zaebal', 'Alkhanika', 'Alsalam'],
    'Al-Sawah': [
      'Almustaemiruh',
      'Mmaydan alsuwaah',
      'Mateam alsalam',
      'Alqahriah Iliaduth',
      'Masakin alsaoudih',
      'Bisku misr',
      'Qasr altaahirih',
      'Altarakhis'
    ],
    'Ismailia': [
      'New University',
      'Old University',
      'Fox Square',
      'Seventh Niqabuh',
      'Almulandasityn',
      'Ringing Highway',
      'Numtazah'
    ],
    'Al-Shorouk': [
      'Alskan Almustaqbal',
      'Alskan Alsabein',
      'Almitru qism Alshuruq',
      'Hajar Alasas',
      'Aljihaz'
    ],
    'Al-Rehab': [
      'Al-Rehab and the first American school',
      'National gasoline',
      'First Assembly'
    ],
    'Sheraton': ['Nachad Alshiyturun', 'Alakdimih Allahrih', 'High Life'],
    'Helwan': [
      'Albanik alahliu',
      'Althaanawayh banat',
      'Almaesaruh mucaskar aljaysh',
      'Almaesaruh alsilm',
      'Sh rayli eali sharif',
      'Kubri tarah',
      'Kubri albarun alalawirin'
    ],
    'Al-Thry': [
      'Ramsis',
      'Mustashfi alqibti',
      'Ghanaruh',
      'Jamie almustafii',
      'Masjid alwahdih',
      'Aleabaasih',
      'Elmarat aleubur',
      'Kubri alfinjari'
    ],
    'Shubra': [
      'Sinama balas',
      'Handasuh shubra',
      'Alamir mali',
      'Dawaran shibra',
      'Alkhalafawaa',
      'Sant tritza',
      'Almuasisuh',
      'Bahtim',
      'Mustarud',
      'Muasisuh aldhaka'
    ],
    'Jisr Al-Suways': [
      'Ahmed Elsmat',
      'Maydan Almatrih',
      'Mustashfi Albakri',
      'Hulmih Atayrun',
      'Alf Maskan',
      'Altanjid',
      'Ahn Alhakam'
    ],
    'Al-Haram': ['Alearish', 'Aleumranin', 'Almatbaeuh', 'Khatam Almursalin'],
    'Al-Maadi': [
      'Almahkamuh Aldusturih',
      'Salam Alnaasljun',
      'Maydan Swyrs',
      'Karfur'
    ],
    'Mit Ghamr': ['Alziraea', 'Sahrajt', 'Kafar Shakr', 'Mayat Aleiz'],
    'Zaytun': [
      'Muzlaqan Eayn Shams',
      'Sintiral Eayn Shams',
      'Maydan Alnieam',
      'Maehad Almutrih',
      'Saeb Salish'
    ],
    'Muqatam': [
      'Kaltiks Alawi',
      'Kaltikas Althaani',
      'Maydan Alnaafurih',
      'Almafariquh',
      'Almubayl'
    ],
    'Al-Suways': [
      'Almuthalath',
      'Mahatah Algitar',
      'Sinama Misr',
      'Aleawayid',
      'Aliarbaeayn',
      'Almustaqbal',
      'List'
    ],
  };

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Color(0xff1F5599),
              padding: EdgeInsets.symmetric(
                vertical: screenHeight * 0.02,
                horizontal: screenWidth * 0.04,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppBar(
                    backgroundColor: Color(0xff1F5599),
                    elevation: 0,
                    title: Center(
                      child: Text(
                        'Book Your Sha_Bus Trip Now !',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth * 0.05,
                        ),
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
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.1,
                            vertical: screenHeight * 0.02,
                          ),
                          child: Text(
                            'ONE WAY',
                            style: TextStyle(
                              fontSize: screenWidth * 0.04,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.08,
                            vertical: screenHeight * 0.02,
                          ),
                          child: Text(
                            'ROUND TRIP',
                            style: TextStyle(
                              fontSize: screenWidth * 0.04,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                      onPressed: (index) {
                        setState(() {
                          isOneWay = index == 0;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Text(
                    'FROM',
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  ListTile(
                    title: Text(
                      selectedFrom ?? 'Select Place',
                      style: TextStyle(
                        fontSize: screenWidth * 0.045,
                        color: Colors.white,
                      ),
                    ),
                    subtitle: Text(
                      selectedPlace ?? 'Choose departure Station',
                      style: TextStyle(
                        fontSize: screenWidth * 0.035,
                        color: Color(0xff9C9B9E),
                      ),
                    ),
                    trailing:
                        Icon(Icons.arrow_forward_ios, color: Colors.white),
                    onTap: () {
                      _showGovernoratePicker(context);
                    },
                  ),
                  Divider(
                    color: Colors.white,
                    thickness: 2.0,
                  ),
                  Text(
                    'TO',
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'ALSHURUQ',
                      style: TextStyle(
                        fontSize: screenWidth * 0.045,
                        color: Colors.white,
                      ),
                    ),
                    trailing:
                        Icon(Icons.arrow_forward_ios, color: Colors.white),
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
                  Divider(
                    thickness: 2.0,
                    color: Colors.black,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'DEPART ON',
                              style: TextStyle(
                                fontSize: screenWidth * 0.04,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            ListTile(
                              title: Text(
                                departDate != null
                                    ? '${departDate!.toLocal()}'.split(' ')[0]
                                    : 'Select Date',
                                style: TextStyle(fontSize: screenWidth * 0.04),
                              ),
                              trailing: Icon(Icons.calendar_today),
                              onTap: () async {
                                DateTime? date =
                                    await selectDate(context, departDate);
                                if (date != null) {
                                  setState(() {
                                    departDate = date;
                                  });
                                }
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
                              Text(
                                'RETURN ON',
                                style: TextStyle(
                                  fontSize: screenWidth * 0.04,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              ListTile(
                                title: Text(
                                  returnDate != null
                                      ? '${returnDate!.toLocal()}'.split(' ')[0]
                                      : 'Select Date',
                                  style:
                                      TextStyle(fontSize: screenWidth * 0.04),
                                ),
                                trailing: Icon(Icons.calendar_today),
                                onTap: () async {
                                  DateTime? date =
                                      await selectDate(context, returnDate);
                                  if (date != null) {
                                    setState(() {
                                      returnDate = date;
                                    });
                                  }
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
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      backgroundColor: Color(0xff205599),
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.3,
                        vertical: screenHeight * 0.02,
                      ),
                      side: BorderSide(color: Colors.blue),
                    ),
                    child: Text(
                      'SEARCH',
                      style: TextStyle(
                        fontSize: screenWidth * 0.04,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => DepartureTripsApp()),
                      );
                    },
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Center(
                    child: Image.asset(
                      'assets/images/WhatsApp Image 2024-10-30 at 15.49.20_5fe6a7c4.jpg',
                      height: screenHeight * 0.2,
                      fit: BoxFit.cover,
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

  Future<DateTime?> selectDate(
      BuildContext context, DateTime? initialDate) async {
    DateTime now = DateTime.now();
    return showDatePicker(
      context: context,
      initialDate: initialDate ?? now,
      firstDate: now,
      lastDate: DateTime(now.year + 1),
    );
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
              Text(
                'Select Governorate',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: governorates.length,
                  itemBuilder: (context, index) {
                    String governorate = governorates.keys.elementAt(index);
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 2,
                      child: ListTile(
                        title: Text(
                          governorate,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          setState(() {
                            selectedGovernorate = governorate;
                          });
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
              Text(
                'Places in $governorate',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: places.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
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

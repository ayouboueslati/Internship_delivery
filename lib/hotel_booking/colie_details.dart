import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../fitness_app/fitness_app_theme.dart';

class HotelDetails extends StatelessWidget {
  final String completeName;
  final int phone;
  final String address;
  final String colieState;
  final String time;
  final String barcode;
  final int amount;
  final String recipientInfo;
  final String supplierInfo;
  final activeColor = Colors.blue[800]!;
  final inactiveColor = Colors.grey[600]!;

  HotelDetails({
    required this.completeName,
    required this.phone,
    required this.address,
    required this.colieState,
    required this.time,
    required this.barcode,
    required this.amount,
    required this.recipientInfo,
    required this.supplierInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            AppBar(
              backgroundColor: Colors.transparent,
              automaticallyImplyLeading:
                  true, // Set to true if you want a back button
              elevation: 0.0,
              flexibleSpace: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16 - 8.0, 16, 12 - 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Colis details',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: FitnessAppTheme.fontName,
                              fontWeight: FontWeight.w700,
                              fontSize: 22 + 6 - 6,
                              letterSpacing: 1.2,
                              color: FitnessAppTheme.darkerText,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      GridView.count(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        crossAxisCount: 2,
                        childAspectRatio: 1,
                        children: <Widget>[
                          buildCard(Icons.qr_code, 'code à barre', barcode),
                          buildClickableCard(
                              Icons.phone,
                              'Telephone',
                              phone.toString(),
                              'Appeler',
                              () => _makePhoneCall(phone)),
                          buildClickableCard(
                              Icons.location_on,
                              'Addresse',
                              address,
                              'Open in maps',
                              () => _openInMaps(address)),
                          buildCard(Icons.person, 'Nom complet', completeName),
                          buildCard(
                              Icons.access_time, 'état de Colie', colieState,
                              cardColor: getColieStateColor(colieState)),
                          buildCard(Icons.schedule, 'Temps', time),
                          buildCard(Icons.money, 'Montant', '$amount TND'),
                          buildCard(Icons.person_pin, 'Destinataire \nInfo',
                              recipientInfo),
                          buildCard(Icons.supervisor_account,
                              'Fournisseur \nInfo', supplierInfo),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  get gr => Expanded(
      child: Container(
          padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
          child: GridView.count(
              crossAxisSpacing: 6,
              mainAxisSpacing: 6,
              crossAxisCount: 2,
              childAspectRatio: .9999,
              children: <Widget>[
                GestureDetector(
                  child: Card(
                    elevation: 20,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          buildDetailRow(
                              Icons.qr_code, 'code à barre', barcode),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  child: Card(
                    elevation: 20,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          buildClickableDetailRow(
                              Icons.phone,
                              'Telephone',
                              phone.toString(),
                              'Appeler',
                              () => _makePhoneCall(phone)),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  child: Card(
                    elevation: 20,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          buildClickableDetailRow(
                              Icons.location_on,
                              'Addresse',
                              address,
                              'Open in maps',
                              () => _openInMaps(address)),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  child: Card(
                    elevation: 20,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          buildDetailRow(
                              Icons.person, 'Nom complet', completeName),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  child: Card(
                    elevation: 20,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    color: colieState == 'in stock'
                        ? Colors.indigoAccent[100]
                        : colieState == 'in return'
                            ? Colors.red
                            : colieState == 'delivered'
                                ? Colors.green
                                : Colors.grey, // the default color

                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          buildDetailRow(
                              Icons.access_time, 'état de Colie', colieState),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  child: Card(
                    elevation: 20,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          buildDetailRow(Icons.schedule, 'Temps', time),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  child: Card(
                    elevation: 20,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          buildDetailRow(Icons.money, 'Montant', '$amount TND'),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  child: Card(
                    elevation: 20,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          buildDetailRow(Icons.person_pin,
                              'Destinataire \nInfo', recipientInfo),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  child: Card(
                    elevation: 20,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          buildDetailRow(Icons.supervisor_account,
                              'Fournisseur \nInfo', supplierInfo),
                        ],
                      ),
                    ),
                  ),
                ),
              ])));

  Widget buildCustomCard(double width, double height, double borderRadius) {
    return Card(
      elevation: 20,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Container(
        width: width,
        height: height,
        padding: EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              buildDetailRow(Icons.person, 'Nom ', completeName),

              // Add more content here as needed
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCard(IconData iconData, String title, String detail,
      {Color? cardColor}) {
    return Card(
      elevation: 20,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      color: cardColor ?? Colors.white, // Default color if not specified
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              iconData,
              size: 40,
              color: Colors.blue,
            ),
            SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4),
            Text(
              detail,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildClickableCard(IconData iconData, String title, String detail,
      String actionText, VoidCallback onPressed) {
    return Card(
      elevation: 20,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              iconData,
              size: 40,
              color: Colors.blue,
            ),
            SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4),
            Text(
              detail,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(height: 8),
            InkWell(
              onTap: onPressed,
              child: Text(
                actionText,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color getColieStateColor(String colieState) {
    switch (colieState) {
      case 'in stock':
        return Colors.indigoAccent[100]!;
      case 'in return':
        return Colors.red;
      case 'delivered':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  _makePhoneCall(int phone) async {
    final url = 'tel:$phone';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _openInMaps(String address) async {
    final url = 'https://www.google.com/maps/search/?api=1&query=$address';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

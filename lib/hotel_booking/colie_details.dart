// ignore_for_file: deprecated_member_use

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
              automaticallyImplyLeading: true,
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
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    int crossAxisCount =
                        MediaQuery.of(context).size.width > 600 ? 4 : 2;

                    return GridView.count(
                      physics: BouncingScrollPhysics(),
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 20,
                      crossAxisCount: crossAxisCount,
                      children: <Widget>[
                        buildResizedCard(
                          Icons.qr_code,
                          'code à barre',
                          barcode,
                        ),
                        buildClickableResizedCard(
                          Icons.phone,
                          'Telephone',
                          phone.toString(),
                          'Appeler',
                          () => _makePhoneCall(phone),
                        ),
                        buildClickableResizedCard(
                          Icons.location_on,
                          'Addresse',
                          address,
                          'Open in maps',
                          () => _openInMaps(address),
                        ),
                        buildResizedCard(
                          Icons.person,
                          'Nom complet',
                          completeName,
                        ),
                        buildResizedCard(
                          Icons.access_time,
                          'état de Colie',
                          colieState,
                          cardColor: getColieStateColor(colieState),
                        ),
                        buildResizedCard(
                          Icons.schedule,
                          'Temps',
                          time,
                        ),
                        buildResizedCard(
                          Icons.money,
                          'Montant',
                          '$amount TND',
                        ),
                        buildResizedCard(
                          Icons.person_pin,
                          'Destinataire \nInfo',
                          recipientInfo,
                        ),
                        buildResizedCard(
                          Icons.supervisor_account,
                          'Fournisseur \nInfo',
                          supplierInfo,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildResizedCard(
    IconData iconData,
    String title,
    String detail, {
    Color? cardColor,
  }) {
    return AspectRatio(
      aspectRatio: 1,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        color: cardColor ?? Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 4),
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    detail,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildClickableResizedCard(
    IconData iconData,
    String title,
    String detail,
    String actionText,
    VoidCallback onPressed,
  ) {
    return AspectRatio(
      aspectRatio: 1,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 4),
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    detail,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
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
    final url = 'tel:${Uri.encodeFull(phone.toString())}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _openInMaps(String address) async {
    final url =
        'https://www.google.com/maps/search/?api=1&query=${Uri.encodeFull(address)}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

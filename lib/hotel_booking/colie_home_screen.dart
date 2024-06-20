import 'package:best_flutter_ui_templates/hotel_booking/colie_list_view.dart';
import 'package:best_flutter_ui_templates/hotel_booking/model/colie_list_data.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../fitness_app/fitness_app_theme.dart';
import 'colie_app_theme.dart';

class HotelHomeScreen extends StatefulWidget {
  @override
  _HotelHomeScreenState createState() => _HotelHomeScreenState();
  const HotelHomeScreen({Key? key, required this.animationController})
      : super(key: key);
  final AnimationController? animationController;
}

class _HotelHomeScreenState extends State<HotelHomeScreen>
    with TickerProviderStateMixin {
  Animation<double>? topBarAnimation;
  double topBarOpacity = 0.0;
  AnimationController? animationController;
  List<HotelListData> hotelList = HotelListData.hotelList;
  final ScrollController _scrollController = ScrollController();
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(const Duration(days: 5));
  String? searchText; // Added search query variable

  @override
  void initState() {
    animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    super.initState();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  void _searchHotels(String query) {
    setState(() {
      searchText = query;
      hotelList = HotelListData.hotelList
          .where((hotel) =>
              hotel.namePerson.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _showAddHotelDialog() {
    //final TextEditingController codeController = TextEditingController();
    final TextEditingController namePersonController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();
    //final TextEditingController reviewsController = TextEditingController();
    final TextEditingController amountController = TextEditingController();
    final TextEditingController colieStateController = TextEditingController();
    final TextEditingController timeController = TextEditingController();
    final TextEditingController barcodeController = TextEditingController();
    final TextEditingController recipientInfoController =
        TextEditingController();
    final TextEditingController supplierInfoController =
        TextEditingController();
    final TextEditingController addressController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Ajouter colie'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: namePersonController,
                  decoration: InputDecoration(labelText: 'Nom du client'),
                ),
                TextField(
                  controller: phoneController,
                  keyboardType: TextInputType.number,
                  maxLength: 8,
                  decoration:
                      InputDecoration(labelText: 'Téléphone (8 chiffres)'),
                ),
                TextField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Le montant (TND)'),
                ),
                TextField(
                  controller: colieStateController,
                  decoration:
                      InputDecoration(labelText: ' L' ' état de Colie '),
                ),
                TextField(
                  controller: timeController,
                  decoration: InputDecoration(labelText: 'Temps'),
                  onTap: () async {
                    TimeOfDay? pickedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );

                    if (pickedTime != null) {
                      timeController.text =
                          '${pickedTime.hour}:${pickedTime.minute}';
                    }
                  },
                ),
                TextField(
                  controller: barcodeController,
                  decoration: InputDecoration(labelText: 'Code à barre'),
                ),
                TextField(
                  controller: recipientInfoController,
                  decoration: InputDecoration(labelText: 'Destinataire Info'),
                ),
                TextField(
                  controller: supplierInfoController,
                  decoration: InputDecoration(labelText: 'Fournisseur Info'),
                ),
                TextField(
                  controller: addressController,
                  decoration: InputDecoration(labelText: 'Addresse'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Annuler'),
            ),
            TextButton(
              onPressed: () {
                // Validate fields before adding
                if (_validateFields(
                    //codeController.text,
                    namePersonController.text,
                    phoneController.text,
                    //reviewsController.text,
                    amountController.text,
                    colieStateController.text,
                    timeController.text,
                    barcodeController.text,
                    recipientInfoController.text,
                    supplierInfoController.text,
                    addressController.text)) {
                  // Add the new hotel to the list
                  final newHotel = HotelListData(
                    //code: codeController.text,
                    namePerson: namePersonController.text,
                    phone: int.parse(phoneController.text),
                    //reviews: int.parse(reviewsController.text),
                    amount: int.parse(amountController.text),
                    colieState: colieStateController.text,
                    time: timeController.text,
                    barcode: barcodeController.text,
                    recipientInfo: recipientInfoController.text,
                    supplierInfo: supplierInfoController.text,
                    address: addressController.text,
                  );
                  setState(() {
                    // Add the new hotel to the hotelList
                    hotelList.add(newHotel);
                  });
                  // Close the dialog
                  Navigator.of(context).pop();
                  //Navigator.of(context).pop();
                }
              },
              child: Text('Ajouter'),
            ),
          ],
        );
      },
    );
  }

  // Function to validate fields
  bool _validateFields(
      //String code,
      String namePerson,
      String phone,
      //String reviews,
      String amount,
      String colieState,
      String time,
      String barcode,
      String recipientInfo,
      String supplierInfo,
      String address) {
    if ( //code.isEmpty ||
        namePerson.isEmpty ||
            phone.isEmpty ||
            //reviews.isEmpty ||
            amount.isEmpty ||
            colieState.isEmpty ||
            time.isEmpty ||
            barcode.isEmpty ||
            recipientInfo.isEmpty ||
            supplierInfo.isEmpty ||
            address.isEmpty) {
      Alert(
        context: context,
        type: AlertType.info,
        title: "oops...",
        desc: "Tous les champs sont requis.",
        buttons: [
          DialogButton(
            child: Text(
              "Ok",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            width: 120,
          ),
        ],
      ).show();
      return false;
    }
    if (phone.length != 8) {
      Alert(
        context: context,
        type: AlertType.info,
        title: "oops...",
        desc: "Le téléphone doit comporter 8 chiffres.",
        buttons: [
          DialogButton(
            child: Text(
              "Ok",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            width: 120,
          ),
        ],
      ).show();
      return false;
    }

    if (!(colieState == 'in stock' ||
        colieState == 'in return' ||
        colieState == 'delivered')) {
      Alert(
        context: context,
        type: AlertType.info,
        title: "oops...",
        desc: "Colie State doit être en stock, en retour, ou livré.",
        buttons: [
          DialogButton(
            child: Text(
              "Ok",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            width: 120,
          ),
        ],
      ).show();
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: HotelAppTheme.buildLightTheme(),
      child: Container(
        child: Scaffold(
          //backgroundColor: Colors.transparent,
          body: Stack(
            children: <Widget>[
              InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: Column(
                  children: <Widget>[
                    AppBar(
                      backgroundColor:
                          FitnessAppTheme.white.withOpacity(topBarOpacity),
                      automaticallyImplyLeading:
                          true, // Set to true if you want a back button
                      elevation: 0.0,
                      flexibleSpace: Column(
                        children: <Widget>[
                          SizedBox(
                            height: MediaQuery.of(context).padding.top,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 16,
                              right: 16,
                              top: 16 - 8.0 * topBarOpacity,
                              bottom: 12 - 8.0 * topBarOpacity,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Colis',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontFamily: FitnessAppTheme.fontName,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 22 + 6 - 6 * topBarOpacity,
                                          letterSpacing: 1.2,
                                          color: FitnessAppTheme.darkerText,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: NestedScrollView(
                        controller: _scrollController,
                        headerSliverBuilder:
                            (BuildContext context, bool innerBoxIsScrolled) {
                          return <Widget>[
                            SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                                  return Column(
                                    children: <Widget>[
                                      getSearchBarUI(),
                                      //getTimeDateUI(),
                                    ],
                                  );
                                },
                                childCount: 1,
                              ),
                            ),
                            /*SliverPersistentHeader(
                              pinned: true,
                              floating: true,
                              delegate: ContestTabHeader(
                                getFilterBarUI(),
                              ),
                            ),*/
                          ];
                        },
                        body: Container(
                          color:
                              HotelAppTheme.buildLightTheme().backgroundColor,
                          child: ListView.builder(
                            itemCount: hotelList.length,
                            padding: const EdgeInsets.only(top: 8),
                            scrollDirection: Axis.vertical,
                            itemBuilder: (BuildContext context, int index) {
                              final int count =
                                  hotelList.length > 10 ? 10 : hotelList.length;
                              final Animation<double> animation =
                                  Tween<double>(begin: 0.0, end: 1.0).animate(
                                CurvedAnimation(
                                  parent: animationController!,
                                  curve: Interval((1 / count) * index, 1.0,
                                      curve: Curves.fastOutSlowIn),
                                ),
                              );
                              animationController?.forward();
                              return HotelListView(
                                callback: () {},
                                hotelData: hotelList[index],
                                animation: animation,
                                animationController: animationController!,
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => _showAddHotelDialog(),
            child: Icon(
              Icons.add,
              size: 30,
              color: HotelAppTheme.buildLightTheme().backgroundColor,
              opticalSize: 23,
            ),
          ),
        ),
      ),
    );
  }

  Widget getSearchBarUI() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: HotelAppTheme.buildLightTheme().backgroundColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(38.0),
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      offset: const Offset(0, 2),
                      blurRadius: 8.0,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                    top: 4,
                    bottom: 4,
                  ),
                  child: TextField(
                    onChanged:
                        _searchHotels, // Call _searchHotels to update the search results
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                    cursorColor: HotelAppTheme.buildLightTheme().primaryColor,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search...',
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: HotelAppTheme.buildLightTheme().primaryColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(38.0),
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.grey.withOpacity(0.4),
                  offset: const Offset(0, 2),
                  blurRadius: 8.0,
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: const BorderRadius.all(
                  Radius.circular(32.0),
                ),
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  _searchHotels(
                      ''); // Clear the search query when the search button is pressed
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(
                    FontAwesomeIcons.magnifyingGlass,
                    size: 20,
                    color: HotelAppTheme.buildLightTheme().backgroundColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getListUI() {
    return Container(
      decoration: BoxDecoration(
        color: HotelAppTheme.buildLightTheme().backgroundColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              offset: const Offset(0, -2),
              blurRadius: 8.0),
        ],
      ),
      child: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height - 156 - 50,
            child: FutureBuilder<bool>(
              future: getData(),
              builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                if (!snapshot.hasData) {
                  return const SizedBox();
                } else {
                  return ListView.builder(
                    itemCount: hotelList.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      final int count =
                          hotelList.length > 10 ? 10 : hotelList.length;
                      final Animation<double> animation =
                          Tween<double>(begin: 0.0, end: 1.0).animate(
                              CurvedAnimation(
                                  parent: animationController!,
                                  curve: Interval((1 / count) * index, 1.0,
                                      curve: Curves.fastOutSlowIn)));
                      animationController?.forward();

                      return HotelListView(
                        callback: () {},
                        hotelData: hotelList[index],
                        animation: animation,
                        animationController: animationController!,
                      );
                    },
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }

  Widget getHotelViewList() {
    final List<Widget> hotelListViews = <Widget>[];
    for (int i = 0; i < hotelList.length; i++) {
      final int count = hotelList.length;
      final Animation<double> animation =
          Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: animationController!,
          curve: Interval((1 / count) * i, 1.0, curve: Curves.fastOutSlowIn),
        ),
      );
      hotelListViews.add(
        HotelListView(
          callback: () {},
          hotelData: hotelList[i],
          animation: animation,
          animationController: animationController!,
        ),
      );
    }
    animationController?.forward();
    return Column(
      children: hotelListViews,
    );
  }
}

class ContestTabHeader extends SliverPersistentHeaderDelegate {
  ContestTabHeader(
    this.searchUI,
  );
  final Widget searchUI;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return searchUI;
  }

  @override
  double get maxExtent => 52.0;

  @override
  double get minExtent => 52.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

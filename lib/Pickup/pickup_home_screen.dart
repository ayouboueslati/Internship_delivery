import 'package:flutter/material.dart';
import '../fitness_app/fitness_app_theme.dart';
import '../hotel_booking/colie_home_screen.dart';
import 'Filter_Calender.dart';
import 'Pickup_list_view.dart';

class PickupsListData {
  String code;
  int totalAmount;
  DateTime createDate;

  PickupsListData({
    required this.code,
    required this.totalAmount,
    required this.createDate,
  });

  static List<PickupsListData> _pickupList = <PickupsListData>[
    PickupsListData(
      code: '12323287',
      totalAmount: 180,
      createDate: DateTime(2023, 7, 1),
    ),
    PickupsListData(
      code: '76556309',
      totalAmount: 200,
      createDate: DateTime(2023, 7, 2),
    ),
    PickupsListData(
      code: '86554478',
      totalAmount: 60,
      createDate: DateTime(2023, 7, 3),
    ),
    PickupsListData(
      code: '86765645',
      totalAmount: 170,
      createDate: DateTime(2023, 7, 4),
    ),
    PickupsListData(
      code: '875765376',
      totalAmount: 200,
      createDate: DateTime(2023, 7, 5),
    ),
  ];

  static List<PickupsListData> get pickupList {
    return _pickupList;
  }
}

class PickupHomeScreen extends StatefulWidget {
  @override
  _HotelHomeScreenState createState() => _HotelHomeScreenState();
  const PickupHomeScreen({Key? key, required this.animationController})
      : super(key: key);
  final AnimationController? animationController;
}

class _HotelHomeScreenState extends State<PickupHomeScreen>
    with TickerProviderStateMixin {
  Animation<double>? topBarAnimation;
  double topBarOpacity = 0.0;
  DateTime selectedFilterDate = DateTime.now();
  AnimationController? animationController;
  List<PickupsListData> pickupList = PickupsListData.pickupList;
  final ScrollController _scrollController = ScrollController();
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(const Duration(days: 5));
  String? searchText; // Added search query variable

  @override
  void initState() {
    animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
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

  void _showDateFilterDialog() {
    showDemoDialog(
      context: context,
      onDateSelected: (DateTime selectedDate) {
        setState(() {
          selectedFilterDate =
              selectedDate; // Set the selected date for filtering
          pickupList = PickupsListData.pickupList
              .where((hotel) => hotel.createDate == selectedFilterDate)
              .toList(); // Filter the runsheets based on the selected date
        });
      },
    );
  }

  void _searchHotels(String query) {
    setState(() {
      searchText = query;
      pickupList = PickupsListData.pickupList
          .where(
              (hotel) => hotel.code.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),
      child: Container(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: <Widget>[
              //getAppBarUI(),
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
                    //getAppBarUI(),
                    AppBar(
                      backgroundColor:
                          FitnessAppTheme.white.withOpacity(topBarOpacity),
                      automaticallyImplyLeading:
                          false, // Set to true if you want a back button
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
                                        'Pickups',
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
                    /* AppBar(
                      title: Center(
                        child: Text(
                          'Pickups',
                          style: TextStyle(
                            //fontWeight: FontWeight.w300,
                            fontSize: 32,
                            fontStyle: FontStyle.italic,
                            //color: Colors.black.withOpacity(1.0),
                            letterSpacing: 4,
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 2
                              //..color = Colors.blue[700]!,
                              ..color = Colors.black54,
                          ),
                        ),
                      ),
                      elevation:
                          12, // Adjust the elevation to control the shadow
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(46), // Adjust the radius here
                        ),
                      ),
                    ),*/
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
                                    ],
                                  );
                                },
                                childCount: 1,
                              ),
                            ),
                            SliverPersistentHeader(
                              pinned: true,
                              floating: true,
                              delegate: ContestTabHeader(
                                getFilterBarUI(),
                              ),
                            ),
                          ];
                        },
                        body: Container(
                          color: Colors.grey.withOpacity(0.1),
                          child: ListView.builder(
                            itemCount: pickupList.length,
                            padding: const EdgeInsets.only(top: 18),
                            scrollDirection: Axis.vertical,
                            itemBuilder: (BuildContext context, int index) {
                              final int count = pickupList.length > 10
                                  ? 10
                                  : pickupList.length;
                              final Animation<double> animation =
                                  Tween<double>(begin: 0.0, end: 1.0).animate(
                                CurvedAnimation(
                                  parent: animationController!,
                                  curve: Interval((1 / count) * index, 1.0,
                                      curve: Curves.fastOutSlowIn),
                                ),
                              );
                              animationController?.forward();

                              return GestureDetector(
                                onTap: () {},
                                child: PickupsListView(
                                  callback: () {
                                    Navigator.push<dynamic>(
                                      context,
                                      MaterialPageRoute<dynamic>(
                                        builder: (BuildContext context) =>
                                            HotelHomeScreen(
                                          animationController:
                                              animationController,
                                        ),
                                      ),
                                    );
                                  },
                                  hotelData: pickupList[index],
                                  animation: animation,
                                  animationController: animationController!,
                                ),
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
        ),
      ),
    );
  }

  Widget getAppBarUI() {
    return Column(
      children: <Widget>[
        AnimatedBuilder(
          animation: widget.animationController!,
          builder: (BuildContext context, Widget? child) {
            return FadeTransition(
              opacity: topBarAnimation!,
              child: Transform(
                transform: Matrix4.translationValues(
                    0.0, 30 * (1.0 - topBarAnimation!.value), 0.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: FitnessAppTheme.white.withOpacity(topBarOpacity),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(32.0),
                    ),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: FitnessAppTheme.grey
                              .withOpacity(0.4 * topBarOpacity),
                          offset: const Offset(1.1, 1.1),
                          blurRadius: 10.0),
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).padding.top,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 16,
                            right: 16,
                            top: 16 - 8.0 * topBarOpacity,
                            bottom: 12 - 8.0 * topBarOpacity),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Pie Charts',
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
              ),
            );
          },
        )
      ],
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
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(38.0),
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
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
                    onChanged: _searchHotels,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                    cursorColor: Colors.blue,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search by code...',
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.blue,
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
                    Icons.search,
                    size: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getFilterBarUI() {
    return Stack(
      children: <Widget>[
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 24,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  offset: const Offset(0, -2),
                  blurRadius: 8.0,
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 4),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  'List',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  focusColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  splashColor: Colors.grey.withOpacity(0.2),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(4.0),
                  ),
                  onTap: () {
                    _showDateFilterDialog();
                    //showDemoDialog(context: context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 8, right: 8, top: 4, bottom: 4),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          'Filter ',
                          style: TextStyle(
                              fontWeight: FontWeight.w100,
                              fontSize: 16,
                              color: Colors.lightBlueAccent),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ContestTabHeader extends SliverPersistentHeaderDelegate {
  ContestTabHeader(this.searchUI);

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

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;

  const MyAppBar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 5.0,
          ),
        ],
      ),
      child: AppBar(
        title: title,
      ),
    );
  }

  @override
  Size get preferredSize => AppBar().preferredSize;
}

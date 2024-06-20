import 'package:best_flutter_ui_templates/Pickup/pickup_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PickupsListView extends StatelessWidget {
  final VoidCallback callback;
  final PickupsListData hotelData;
  final Animation<double> animation;
  final AnimationController animationController;

  const PickupsListView({
    Key? key,
    required this.callback,
    required this.hotelData,
    required this.animation,
    required this.animationController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: animation,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 44,
          right: 44,
          top: 2,
          bottom: 16,
        ),
        child: InkWell(
          splashColor: Colors.transparent,
          onTap: callback,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(16.0)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.grey.withOpacity(0.6),
                  offset: const Offset(4, 4),
                  blurRadius: 16,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(26.0)),
              child: Stack(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 20,
                                    top: 8,
                                    bottom: 8,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.confirmation_number_outlined,
                                            color: Colors.blue,
                                            size: 30,
                                          ),
                                          SizedBox(width: 12),
                                          Text(
                                            hotelData.code,
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 22,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Icon(
                                            Icons
                                                .money, // Replace with the desired icon
                                            color: Colors.blue,
                                            size: 30,
                                          ),
                                          SizedBox(width: 12),
                                          Text(
                                            '${hotelData.totalAmount} TND',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 22,
                                            ),
                                          ),
                                          SizedBox(width: 4),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons
                                                .calendar_month_outlined, // Replace with the desired icon
                                            color: Colors.blue,
                                            size: 30,
                                          ),
                                          SizedBox(width: 12),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 4, bottom: 8),
                                            child: Text(
                                              DateFormat('dd MMM, yyyy')
                                                  .format(hotelData.createDate),
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 22,
                                              ),
                                            ),
                                          ),
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
                    ],
                  ),
                  /* Positioned(
                    top: 30,
                    right: 10,
                    child: InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.add), // Replace with the desired icon
                      ),
                    ),
                  ),*/
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

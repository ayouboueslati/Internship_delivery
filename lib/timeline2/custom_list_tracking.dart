library list_timeline;

import 'package:flutter/material.dart';

class CustomListTracking<T> extends StatelessWidget {
  final List<T>? listItem;
  final String Function(T)? valueTextOfTitle;
  final String Function(T)? valueTextOfDesc;
  final String Function(T)? valueOfLeftSource;
  final bool showLeftWidget;
  final Color Function(T)? colorCircleTimeline;
  final bool isPrimary;
  final double textSize;
  final double textSizeOfDateLeftTimeline;
  final Widget Function(T)? customTitleWidget;
  final Widget Function(T)? customDescWidget;
  final Widget Function(T)? customLeftWidget;

  const CustomListTracking({
    Key? key,
    required this.listItem,
    this.isPrimary = false,
    this.valueTextOfTitle,
    this.valueTextOfDesc,
    this.valueOfLeftSource,
    this.colorCircleTimeline,
    this.showLeftWidget = false,
    this.customTitleWidget,
    this.customDescWidget,
    this.customLeftWidget,
    this.textSize = 12,
    this.textSizeOfDateLeftTimeline = 12,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: !isPrimary,
        primary: isPrimary,
        itemCount: listItem!.length,
        itemBuilder: (context, index) => _itemTimeline(index));
  }

  Widget _itemTimeline(
    int currentIndex,
  ) {
    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
              visible: showLeftWidget,
              child: Padding(
                padding: const EdgeInsets.only(top: 3, left: 5, right: 5),
                child: customLeftWidget == null
                    ? Text(
                        (valueOfLeftSource == null)
                            ? ""
                            : valueOfLeftSource!(listItem![currentIndex]),
                        style: TextStyle(fontSize: textSizeOfDateLeftTimeline),
                      )
                    : customLeftWidget!(listItem![currentIndex]),
              )),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 22,
                height: 22,
                margin:
                    const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: colorCircleTimeline == null
                          ? Colors.blue
                          : colorCircleTimeline!(listItem![currentIndex]),
                      width: 2.5,
                      style: BorderStyle.solid),
                  shape: BoxShape.circle,
                ),
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  margin: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: colorCircleTimeline == null
                        ? Colors.blue
                        : colorCircleTimeline!(listItem![currentIndex]),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              (currentIndex + 1 != listItem!.length)
                  ? Expanded(
                      child: Container(
                        height: double.infinity,
                        width: 2.5,
                        color: colorCircleTimeline == null
                            ? Colors.blue
                            : colorCircleTimeline!(listItem![currentIndex]),
                      ),
                    )
                  : Container()
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 2),
                  customTitleWidget == null
                      ? Text(
                          valueTextOfTitle == null
                              ? ""
                              : valueTextOfTitle!(listItem![currentIndex]),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        )
                      : customTitleWidget!(listItem![currentIndex]),
                  customDescWidget == null
                      ? Padding(
                          padding: const EdgeInsets.only(top: 4, bottom: 12),
                          child: Text(valueTextOfDesc == null
                              ? ""
                              : valueTextOfDesc!(listItem![currentIndex])),
                        )
                      : customDescWidget!(listItem![currentIndex]),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:trip_boy/models/event_model.dart';

import '../../../common/shared_code.dart';
import '../../../component/event_card_item.dart';

class EventPages extends StatelessWidget {
  List<EventModel> list;
  EventPages({Key? key, required this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height.sp,
      margin: EdgeInsets.only(left: 15.sp, right: 15.sp),
      child: ListView.separated(
          itemBuilder: (context, index) => EventCardItem(
                asset: list[index].imageUrl,
                title: list[index].title,
                dateHeld: SharedCode.dateFormat.format(list[index].heldAt),
                price: list[index].price,
                ticketType: list[index].ticketType,
              ),
          separatorBuilder: (context, index) => Container(
                height: 1.sp,
              ),
          itemCount: list.length),
    );
  }
}

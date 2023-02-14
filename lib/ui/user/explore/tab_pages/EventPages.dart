import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:trip_boy/models/content_model.dart';

import '../../../../common/shared_code.dart';
import '../../../../common/user_data.dart';
import '../../../../component/event_card_item.dart';
import '../../../../models/destination_model.dart';
import '../../../../models/event_model.dart';
import '../../../../models/hotel_model.dart';
import '../../../../models/restaurant_model.dart';
import '../../../../services/database_services.dart';
import '../../detail_page.dart';

class EventPages extends StatefulWidget {
  EventPages({Key? key}) : super(key: key);

  @override
  State<EventPages> createState() => _EventPagesState();
}

class _EventPagesState extends State<EventPages> {
  bool _isLoading = true;
  List<RestaurantModel> restaurantData = [];
  List<EventModel> eventData = [];
  List<DestinationModel> destinationData = [];
  List<HotelModel> hotelData = [];
  List<ContentModel> allData = [];

  Future<void> getAllData() async {
    setLoading(true);
    restaurantData =
        await DatabaseService().getRestaurantData(false, UserData().uid);
    eventData = await DatabaseService().getEventData(false, UserData().uid);
    destinationData =
        await DatabaseService().getDestinationData(false, UserData().uid);
    hotelData = await DatabaseService().getHotelData(false, UserData().uid);
    setLoading(false);
  }

  void setLoading(bool loading) {
    if (mounted) {
      setState(() {
        _isLoading = loading;
      });
    } else {
      _isLoading = loading;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllData();
  }

  @override
  Widget build(BuildContext context) {
    List<EventModel> listAfterFilter = eventData
        .where(
          (element) => element.type == "event" && element.name != "",
        )
        .toList();
    return _isLoading
        ? EventSkeleton(list: eventData)
        : Container(
            height: MediaQuery.of(context).size.height.sp,
            margin: EdgeInsets.only(left: 15.sp, right: 15.sp),
            child: ListView.separated(
                itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailPage(
                                facilityList: [],
                                price: listAfterFilter[index].price,
                                roomList: [],
                                googleMapsUrl: "",
                                type: listAfterFilter[index].type,
                                imageUrl: listAfterFilter[index].imageUrl,
                                name: listAfterFilter[index].name,
                                rating: listAfterFilter[index].rating,
                                location: "",
                                fullLocation: "",
                                timeClose: "",
                                timeOpen: "",
                                description: listAfterFilter[index].description,
                                imageList: [],
                              ),
                            ));
                      },
                      child: EventCardItem(
                        asset: listAfterFilter[index].imageUrl,
                        title: listAfterFilter[index].name,
                        dateHeld: listAfterFilter[index].timeHeld,
                        price: listAfterFilter[index].price,
                        ticketType: listAfterFilter[index].ticketType,
                      ),
                    ),
                separatorBuilder: (context, index) => Container(
                      height: 1.sp,
                    ),
                itemCount: listAfterFilter.length),
          );
  }
}

class EventSkeleton extends StatelessWidget {
  List<EventModel> list;
  EventSkeleton({Key? key, required this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return eventSkeleton(context);
  }

  Widget eventSkeleton(context) {
    return Container(
      height: MediaQuery.of(context).size.height.sp,
      margin: EdgeInsets.only(left: 15.sp, right: 15.sp),
      child: ListView.separated(
          itemBuilder: (context, index) => Container(
                width: MediaQuery.of(context).size.width.sp,
                height: 230.sp,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.black.withOpacity(0.04)),
              ),
          separatorBuilder: (context, index) => Container(
                height: 1.sp,
              ),
          itemCount: list.length),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import 'package:trip_boy/common/app_text_styles.dart';
import 'package:trip_boy/common/color_values.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:trip_boy/common/shared_code.dart';
import 'package:trip_boy/component/event_card_item.dart';
import 'package:trip_boy/component/horizontal_card.dart';
import 'package:trip_boy/component/loading.dart';
import 'package:trip_boy/component/vertical_card.dart';
import 'package:trip_boy/models/event_model.dart';
import 'package:trip_boy/ui/explore/tab_pages/EventPages.dart';
import 'package:trip_boy/ui/explore/tab_pages/TabComponent.dart';

import '../../component/search_bar.dart';
import '../../component/skeleton.dart';

class ExplorePage extends StatefulWidget {
  int exploreSelectionIndex;
  ExplorePage({super.key, this.exploreSelectionIndex = 0});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  bool _isLoading = true;
  List<EventModel> event = [
    EventModel(
        imageUrl: 'assets/eventImage.png',
        title: 'Street Food Festival : Poncobudoyo',
        description: "",
        price: 15000,
        ticketType: 'online',
        generatedAt: DateTime.now(),
        heldAt: DateTime(2022, 2, 13))
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(
        length: 4, vsync: this, initialIndex: widget.exploreSelectionIndex);
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    return GestureDetector(
      onTap: () {
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          shadowColor: Colors.transparent,
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
              height: 5.h,
              margin: EdgeInsets.only(left: 15.sp, right: 15.sp, top: 10.sp),
              width: MediaQuery.of(context).size.width.w,
              child: SearchBar()),
          bottom: TabBar(
              unselectedLabelColor: Colors.black,
              labelStyle:
                  AppTextStyles.appTitlew500s10(ColorValues().primaryColor),
              labelColor: ColorValues().primaryColor,
              indicatorColor: ColorValues().primaryColor,
              controller: _tabController,
              tabs: [
                Tab(
                  text: AppLocalizations.of(context)!.cullinary,
                ),
                Tab(
                  text: AppLocalizations.of(context)!.hotel,
                ),
                Tab(
                  text: AppLocalizations.of(context)!.tour,
                ),
                Tab(
                  text: AppLocalizations.of(context)!.event,
                ),
              ]),
        ),
        body: _isLoading
            ? ListView.separated(
                itemCount: 5,
                itemBuilder: (context, index) => const NewsCardSkelton(),
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 16),
              )
            : TabBarView(controller: _tabController, children: [
                TabComponent(
                  isLoading: _isLoading,
                  tabController: _tabController!,
                  imageUrl:
                      'https://lh5.googleusercontent.com/p/AF1QipNGovUkHJz80U4GBl5pKppZIr5Hy4z0ZhQhJDV6=w253-h337-k-no',
                  title: "",
                  rating: 0,
                ),
                TabComponent(
                  isLoading: _isLoading,
                  tabController: _tabController!,
                  imageUrl:
                      'https://lh5.googleusercontent.com/p/AF1QipNGovUkHJz80U4GBl5pKppZIr5Hy4z0ZhQhJDV6=w253-h337-k-no',
                  title: "",
                  rating: 0,
                ),
                TabComponent(
                  isLoading: _isLoading,
                  tabController: _tabController!,
                  imageUrl:
                      'https://lh5.googleusercontent.com/p/AF1QipNGovUkHJz80U4GBl5pKppZIr5Hy4z0ZhQhJDV6=w253-h337-k-no',
                  title: "",
                  rating: 0,
                ),
                EventPages(
                  list: event,
                )
              ]),
      ),
    );
  }
}

class NewsCardSkelton extends StatelessWidget {
  const NewsCardSkelton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Skeleton(height: 120, width: 120),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Skeleton(width: 80),
              const SizedBox(height: 16 / 2),
              const Skeleton(),
              const SizedBox(height: 16 / 2),
              const Skeleton(),
              const SizedBox(height: 16 / 2),
              Row(
                children: const [
                  Expanded(
                    child: Skeleton(),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Skeleton(),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}

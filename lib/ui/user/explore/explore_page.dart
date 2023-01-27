import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:trip_boy/common/app_text_styles.dart';
import 'package:trip_boy/common/color_values.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:trip_boy/ui/user/explore/tab_pages/EventPages.dart';
import 'package:trip_boy/ui/user/explore/tab_pages/TabComponent.dart';

import '../../../component/search_bar.dart';
import '../../../component/skeleton.dart';

class ExplorePage extends StatefulWidget {
  int exploreSelectionIndex;
  ExplorePage({super.key, this.exploreSelectionIndex = 0});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(
        length: 4, vsync: this, initialIndex: widget.exploreSelectionIndex);
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
                  text: AppLocalizations.of(context)!.restaurant,
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
        body: TabBarView(controller: _tabController, children: [
          TabComponent(
            tabController: _tabController!,
          ),
          TabComponent(
            tabController: _tabController!,
          ),
          TabComponent(
            tabController: _tabController!,
          ),
          EventPages()
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

import 'package:code_fac/common/const/colors.dart';
import 'package:code_fac/common/layout/deafult_layout.dart';
import 'package:code_fac/restaurant/view/view/restaurant_screen.dart';
import 'package:flutter/material.dart';

class RootTab extends StatefulWidget {
  const RootTab({super.key});

  @override
  State<RootTab> createState() => _RootTabState();
}

class _RootTabState extends State<RootTab> with SingleTickerProviderStateMixin {
  late TabController controller;
  int index = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TabController(length: 4, vsync: this);

    controller.addListener(
      () => tabListenr(),
    );
  }

  void tabListenr() {
    setState(() {
      index = controller.index;
    });
  }

  @override
  void dispose() {
    controller.removeListener(tabListenr);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: "코팩 딜리버리",
      child: Scaffold(
        body: TabBarView(
          controller: controller,
          children: [
            RestaurantScreen(),
            Container(
              child: Text("음식"),
            ),
            Container(
              child: Text("주문"),
            ),
            Container(
              child: Text("프로필"),
            )
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: PRIMARY_COLOR,
          unselectedItemColor: BODY_TEXT_COLOR,
          selectedFontSize: 10.0,
          unselectedFontSize: 10.0,
          type: BottomNavigationBarType.fixed,
          onTap: (int index) {
            controller.animateTo(index);
          },
          currentIndex: index,
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home_outlined,
                ),
                label: "홈"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.fastfood_outlined,
                ),
                label: "음식"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.receipt_long_outlined,
                ),
                label: "주문"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.person_outline,
                ),
                label: "프로필"),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:truvel/tabPages/earning_tab.dart';
import 'package:truvel/tabPages/home_tab.dart';
import 'package:truvel/tabPages/profile_tab.dart';
import 'package:truvel/tabPages/ratings_tab.dart';

class MainScreen extends StatefulWidget
{

  @override
  State<MainScreen> createState() => _MainScreenState();
}




class _MainScreenState extends State<MainScreen> with SingleTickerProviderStateMixin
{
  TabController? tabController;
  int selectedindex  = 0;

  onItemClicked(int index)
  {
    setState((){
      selectedindex = index;
      tabController!.index = selectedindex;

    });

  }
  @override
  void initState(){
    super.initState();

    tabController = TabController(length: 4, vsync: this);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: tabController,
         children: const [
          HomeTabPage(),
          EarningsTabPage(),
          RatingsTabPage(),
          ProfileTabPage(),

        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
            label: "Home"
          ),

          BottomNavigationBarItem(
              icon: Icon(Icons.credit_card),
              label: "Earnings"
          ),

          BottomNavigationBarItem(
              icon: Icon(Icons.star),
              label: "Ratings"
          ),

          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Account"
          ),

        ],
        unselectedItemColor: Colors.black45,
        selectedItemColor: Colors.black,
        backgroundColor: Colors.yellowAccent,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: TextStyle(fontSize: 14),
        showUnselectedLabels: true,
        currentIndex: selectedindex,
        onTap: onItemClicked,
      ),
    );
  }
}

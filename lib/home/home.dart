
import 'package:bank/model.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  String username = "Rashid Ul Islam";
  String welcome = "Welcome Back!";
  String value = "1465";
  final controller = ScrollController();
  late SharedPreferences _prefs;
  late Map<String, int> tappingCount = {};

  bool isgoodornot = false;


  List accounts= [
  MyList(title: "Ryan Adams", subtitle: "2022-08-21 02:14:12", money: "\$250", isgood: false),
  MyList(title: "Ronan Atkins", subtitle:"2022-07-12 05:07:12", money: "\$100", isgood: false),
  MyList(title: "Jon Jane", subtitle: "2022-05-20 07:12:12", money: "\$100", isgood: true),
  MyList(title: "Tom John",subtitle: "2022-05-14 03:33:22", money: "\$300", isgood: true),
  MyList(title: "Tom Lemon", subtitle: "2022-05-04 01:32:14", money: "\$700", isgood: false)
  ];

  

  int _pageindex = 0;

  void onPageChanged(int _index) {
    setState(() {
      _pageindex = _index;
    });
  }

@override
  void initState() {
    super.initState();
    _initializePrefs();
  }

Future<void> _initializePrefs() async {
  _prefs = await SharedPreferences.getInstance();
  tappingCount = _loadTappingCount();
  _sortIcons(); // Add this to sort icons after loading counts
}


   Map<String, int> _loadTappingCount() {
    final Map<String, int> loadedTappingCount = {};
    final List<String> keys = ["Money", "Cashout", "Donate", "QR scan", "Lend", "Statement", "Pay Bills", "Loan"];
    for (String key in keys) {
      loadedTappingCount[key] = _prefs.getInt(key) ?? 0;
    }
    return loadedTappingCount;
  }

  Future<void> _saveTappingCount() async {
    tappingCount.forEach((key, value) {
      _prefs.setInt(key, value);
    });
  }

  List<Map<String, dynamic>> features = [
    {"icon": Icons.send, "color1": Colors.orange, "color2": Colors.purpleAccent, "title": "Money"},
    {"icon": Icons.money, "color1": Colors.orange, "color2": Colors.greenAccent, "title": "Cashout"},
    {"icon": Icons.monetization_on_outlined, "color1": Colors.orange, "color2": Colors.blueAccent, "title": "Donate"},
    {"icon": Icons.sim_card_outlined, "color1": Colors.orange, "color2": Colors.indigo, "title": "QR scan"},
    {"icon": Icons.arrow_downward, "color1": Colors.blueGrey, "color2": Colors.red, "title": "Lend"},
    {"icon": Icons.note_alt_outlined, "color1": Colors.blueGrey, "color2": Colors.green, "title": "Statement"},
    {"icon": Icons.paypal, "color1": Colors.blueGrey, "color2": Colors.purpleAccent, "title": "Pay Bills"},
    {"icon": Icons.currency_exchange, "color1": Colors.blueGrey, "color2": Colors.deepPurple, "title": "Loan"},
  ];


  


  @override
  Widget build(BuildContext context) {

     // Sort the features based on tappingCount
     features.sort((a, b) => (tappingCount[b["title"]] ?? 0).compareTo(tappingCount[a["title"]] ?? 0));

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
             Padding(
            padding: const EdgeInsets.only(top: 20.0),
            // child: Text(
            //   // 'Timer: $_timerSeconds',
            //   // style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            // ),
          ),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Hello $username",
                          style: const TextStyle(
                              color: Colors.white30, fontSize: 22),
                        ),
                        Text(
                          welcome,
                          style: const TextStyle(
                              color: Colors.white60,
                              fontWeight: FontWeight.bold,
                              fontSize: 25),
                        ),
                      ]),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: IconButton(
                    onPressed: () {},
                    icon: Stack(
                      children: const [
                        Icon(
                          Icons.notifications_none_outlined,
                          size: 24,
                          color: Colors.white60,
                        ),
                        Positioned(
                          left: 14,
                            child: Icon(Icons.brightness_1,
                              color: Colors.red,
                                size: 9.0,),
                        ),
                      ],
                    )
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 130,
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  colors: [
                    Colors.black,
                    Colors.black,
                    Colors.black26,
                    Colors.lightBlue,
                    Colors.lightBlue,
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 20, top: 20),
                        child: Text(
                          "Current balance",
                          style: TextStyle(color: Colors.white, fontSize: 22),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "\$ $value",
                        style:
                            const TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                        child: Container(
                          height: 55,
                          width: 55,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.9),
                            gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomCenter,
                              colors: [Colors.white60, Colors.white10],
                            ),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 2, color: Colors.white60),
                          ),

                      child: IconButton(
                        padding: EdgeInsets.zero,
                      icon: const Icon(
                        Icons.add,
                        size: 37,
                        color: Colors.white60,
                      ),
                      onPressed: () {},
                    ),
                      ),
                    ),
                  ),
                    ),
                 // ),
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _tiles(Icons.send ,Colors.orange, Colors.purpleAccent, "Money"),
                _tiles(Icons.money ,Colors.orange, Colors.greenAccent, "Cashout"),
                _tiles(Icons.monetization_on_outlined, Colors.orange, Colors.blueAccent, "Donate"),
                _tiles(Icons.sim_card_outlined,Colors.orange, Colors.indigo, "QR scan"),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _tiles(Icons.arrow_downward, Colors.blueGrey, Colors.red, "Lend"),
                _tiles(Icons.note_alt_outlined,Colors.blueGrey, Colors.green, "Statement"),
                _tiles(Icons.paypal,Colors.blueGrey, Colors.purpleAccent, "Pay Bills"),
                _tiles(Icons.currency_exchange,Colors.blueGrey, Colors.deepPurple, "Loan"),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    "Recent transactions",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: TextButton(
                      style: ButtonStyle(
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                      ),
                      onPressed: () {},
                      child: const Text(
                        "See all",
                        style: TextStyle(
                          color: Colors.white60,
                          fontSize: 15,
                        ),
                      )),
                ),
              ],
            ),

            Expanded(
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: ScrollConfiguration(
                  behavior: const MaterialScrollBehavior()
                      .copyWith(overscroll: false),
                  child: ListView.builder(
                      controller: controller,
                      shrinkWrap: true,
                      itemCount: accounts.length,
                      itemBuilder: (context, index) {
                        bool isornot = accounts[index].isgood;

                        return ListTile(
                          title: Text(
                             accounts[index].title,
                            style: const TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          subtitle: Text(accounts[index].subtitle,
                              style: const TextStyle(
                                  color: Colors.white70, fontSize: 13)),
                          trailing:
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(accounts[index].money,
                                style: const TextStyle(
                                    color: Colors.white70,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                              const SizedBox(width: 10,),
                              isornot  == false
                                  ? const Icon(Icons.arrow_downward_outlined,color: Colors.red,)
                                  : const Icon(Icons.arrow_upward_outlined,color: Colors.green,),
                            ],
                          ),
                        );
                      }),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SingleChildScrollView(
      child: Container(
      height: 55,
      color: Colors.transparent,
      child: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          canvasColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: false,
          elevation: 0.0,
          selectedIconTheme: const IconThemeData(
            size: 22,
            color: Color(0xFF00E5FF),
          ),
          iconSize: 19,
          unselectedItemColor: Colors.black87,
          unselectedFontSize: 12,
          selectedFontSize: 15,
          currentIndex: _pageindex,
          onTap: onPageChanged,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.replay_5_outlined),
              label: "Schedule",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.credit_card),
              label: "Card",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined),
              label: "Profile",
            ),
          ],
        ),

      ),
    ),
    ),
    );
  }


void _sortIcons() {
  setState(() {
    features.sort((a, b) => (tappingCount[b["title"]] ?? 0).compareTo(tappingCount[a["title"]] ?? 0));
  });
}



    Container _tiles(IconData icon, Color color1, Color color2, String title) {
    return Container(
      height: 100,
      width: 85,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          colors: [color1, color2],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: InkWell(
        onTap: () async {
          setState(() {
            tappingCount[title] = (tappingCount[title] ?? 0) + 1;
          });
          await _saveTappingCount();
          _sortIcons();
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: Colors.white70),
            SizedBox(height: 8),
            Text(title, style: TextStyle(color: Colors.white, fontSize: 14)),
            SizedBox(height: 4),
            Text("Count: ${tappingCount[title] ?? 0}", style: TextStyle(color: Colors.white, fontSize: 10)),
          ],
        ),
      ),
    );
  }






}





// Container _tiles(IconData icon,Color color1, color2, String title) {
//   return Container(
//     height: 85,
//     width: 85,
//     decoration: BoxDecoration(
//       borderRadius: BorderRadius.circular(10),
//       gradient: LinearGradient(
//         colors: [
//           color1,
//           color2,
//         ],
//         begin: Alignment.topLeft,
//         end: Alignment.bottomRight,
//       ),
//     ),
//     child: ListTile(
//       title: Icon(icon, size: 45, color: Colors.white70,),
//       subtitle: Padding(
//         padding: const EdgeInsets.only(top:8),
//       child: Text(title,textAlign: TextAlign.center, style: const TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.bold),),
//       ),
//    ),
//   );
// }

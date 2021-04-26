import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:foodapp1/Screens/app/food_app.dart';
import 'package:http/http.dart' as Http;
import '../Login/components/background.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuPage extends StatefulWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Search Bar',
      theme: new ThemeData(primarySwatch: Colors.blue),
    );
  }

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  var jsonData;
  SearchBar searchBar;
  String searchKey = "";

  List<TemplelData> templeList = [];
  List<TemplelData> templeListShow = [];

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  AppBar buildAppBar(BuildContext context) {
    return new AppBar(
      backgroundColor: Colors.orange.shade600,
      title: new Text(
        'เมนูอาหาร',
        style: GoogleFonts.itim(
          fontSize: 26,
          color: Colors.white,
          fontWeight: FontWeight.w100,
        ),
      ),
      actions: [searchBar.getSearchAction(context)],
    );
  }

  void onSubmitted(String value) {
    setState(() {
      searchKey = value;
      _scaffoldKey.currentState.showSnackBar(
          new SnackBar(content: new Text('You search for $value!')));
    });
  }

  _MenuPageState() {
    searchBar = new SearchBar(
        inBar: false,
        buildDefaultAppBar: buildAppBar,
        setState: setState,
        onSubmitted: onSubmitted,
        onCleared: () {
          print("cleared");
        },
        onClosed: () {
          print("Closed");
        });
  }

  Future<String> _getMenuAPI() async {
    var response = await Http.get(
        'https://akkarapon-sompoht.github.io/templel/foodapp.json');

    jsonData = json.decode(utf8.decode(response.bodyBytes));
    templeList.clear();
    for (var item in jsonData) {
      TemplelData templelData = TemplelData(item['number'], item['name'],
          item['raw_material'], item['how_to'], item['img']);
      templeList.add(templelData);
    }
    if (searchKey == 200) {
      templeListShow = templeList;
    } else {
      print(searchKey);
      templeListShow = templeList
          .where((element) => element.name.startsWith(searchKey))
          .toList();
    }

    return 'jsonData';
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.orange.shade100,
      appBar: searchBar.build(context),
      key: _scaffoldKey,
      body: Background(
        child: FutureBuilder(
          future: _getMenuAPI(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 8 / 8,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: templeListShow.length,
                itemBuilder: (BuildContext ctx, index) {
                  return Container(
                    height: 200,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            20,
                          ),
                        )),
                    child: InkWell(
                      onTap: () {
                        // ! Use templeListShow to display temple data
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            // ignore: missing_required_param
                            builder: (context) => FoodAppPage(
                              number: templeList[index].number,
                              name: templeList[index].name,
                              raw_material: templeList[index].raw_material,
                              how_to: templeList[index].how_to,
                              img: templeList[index].img,
                            ),
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          Container(
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20),
                                ),
                                
                              ),
                            ),
                            child: Image.network(
                              "${templeList[index].img}",
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(
                          height: 10,
                          ),
                          ListView(
                            shrinkWrap: true,
                            children: [
                              Container(
                                  alignment: FractionalOffset.center,
                                  width: double.infinity,
                                  child: Text('${templeList[index].name}',
                                  style: GoogleFonts.sriracha(
                                  fontSize: 12,
                                  color: Colors.red, 
                                  fontWeight: FontWeight.bold,),
                                  )),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}

class TemplelData {
  int number;
  String name;
  String raw_material;
  String how_to;
  String img;

  TemplelData(this.number, this.name, this.raw_material, this.how_to, this.img);
  startsWith(String searchKey) {}
}

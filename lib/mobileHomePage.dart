import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class mobileHomePage extends StatefulWidget {
  const mobileHomePage({super.key, required this.title});
  final String title;

  @override
  State<mobileHomePage> createState() => _mobileHomePageState();
}

class _mobileHomePageState extends State<mobileHomePage> {
  List<dynamic> newsdata = [];
  List<dynamic> trendingBulletin = [];
  String specialityName = '';
  List<dynamic> latestArticle = [];
  List<dynamic> exploreArticle = [];
  List<dynamic> trandingArticle = [];
  Map<String, dynamic> article = {};
  List<dynamic> bulletin = [];
  int sId = 0;

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(
          value: "Critical Care", child: Text("Critical Care")),
      const DropdownMenuItem(
          value: "Critical Care B", child: Text("Critical Care B")),
      const DropdownMenuItem(
          value: "Critical Care C", child: Text("Critical Care C")),
      const DropdownMenuItem(
          value: "Critical Care D", child: Text("Critical Care D")),
    ];
    return menuItems;
  }

  String selectedValue = "Critical Care";

  Future fetchdata() async {
    print("fetch data started");
    const url =
        'http://devapi.hidoc.co:8080/HidocWebApp/api/getArticlesByUid?423914';
    final uri = Uri.parse(url);
    final response = await http.post(uri);
    final body = response.body;
    final json = jsonDecode(body);
    setState(() {
      newsdata = json['data']['news'];
      trendingBulletin = json['data']['trandingBulletin'];
      specialityName = json['data']['specialityName'];
      latestArticle = json['data']['latestArticle'];
      exploreArticle = json['data']['exploreArticle'];
      trandingArticle = json['data']['trandingArticle'];
      article = json['data']['article'];
      bulletin = json['data']['bulletin'];
      sId = json['data']['sId'];
    });
  }

  _launchURL() async {
    Uri _url = Uri.parse(article['redirectLink']);
    if (await launchUrl(_url)) {
      await launchUrl(_url);
    } else {
      throw 'Could not launch $_url';
    }
  }

  @override
  void initState() {
    fetchdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          widget.title,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        backgroundColor: Colors.grey.shade200,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //********************* Body Start Here *******************

            Padding(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),

                    //**************** Home and Title ********************

                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              alignment: Alignment.topLeft,
                              width: mediaQuery.size.width * 0.31,
                              child: const CircleAvatar(
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.home_outlined,
                                  color: Colors.black,
                                  size: 30,
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              width: mediaQuery.size.width * 0.59,
                              child: const Text(
                                'ARTICLES',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    //**************** Home and Title Ends Here ********************

                    SizedBox(
                      height: 10,
                    ),

                    // ****************critical care dropdown menu start**********************

                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: mediaQuery.size.width * 0.5,
                        child: DropdownButtonHideUnderline(
                          child: ButtonTheme(
                            alignedDropdown: true,
                            child: DropdownButton(
                                underline: Container(),
                                value: selectedValue,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedValue = newValue!;
                                  });
                                },
                                items: dropdownItems),
                          ),
                        ),
                      ),
                    ),

                    // *********************critical care dropdown menu end****************

                    const SizedBox(
                      height: 15,
                    ),

                    // *****************Article Section Start here***************

                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.shade600,
                              spreadRadius: 1,
                              blurRadius: 15)
                        ],
                      ),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(),
                            height: mediaQuery.size.height * 0.35,
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.asset(
                                    'assets/image/noimagefound.png',
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 163),
                                    child: Container(
                                      height: 70,
                                      width: 70,
                                      decoration: const BoxDecoration(
                                        color: Colors.lightBlueAccent,
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(20)),
                                      ),
                                      child: Center(
                                        child: Column(
                                          children: [
                                            const Padding(
                                              padding: EdgeInsets.only(
                                                  top: 15, right: 7),
                                              child: Text(
                                                'Points',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              article['rewardPoints']
                                                  .toString(),
                                              style: const TextStyle(
                                                fontSize: 15,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: mediaQuery.size.width * 0.9,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Column(
                                children: [
                                  Container(
                                    width: mediaQuery.size.width * 0.9,
                                    child: Text(
                                      article['articleTitle'],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  Container(
                                    width: mediaQuery.size.width * 0.9,
                                    child: Text(article['articleDescription']),
                                  ),
                                  const SizedBox(height: 35),
                                  Container(
                                    width: mediaQuery.size.width * 0.9,
                                    child: InkWell(
                                      onTap: _launchURL,
                                      child: const Text(
                                        'Read full article to earn points',
                                        style: TextStyle(
                                          color: Colors.blue,
                                          fontStyle: FontStyle.italic,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 35),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // ******************Article Section Ends Here***************

                    const SizedBox(
                      height: 40,
                    ),

                    //******************* HiDoc Bulletin Section Start from here******************

                    Container(
                      width: mediaQuery.size.width * 1,
                      height: mediaQuery.size.width * 0.85,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: const Text(
                              'Hidoc Bulletin',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Expanded(
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: bulletin.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                  ),
                                  child: Column(
                                    children: [
                                      const Divider(
                                        height: 5,
                                        thickness: 5,
                                        indent: 15,
                                        endIndent: 200,
                                        color: Colors.lightBlueAccent,
                                      ),
                                      ListTile(
                                        title: Text(
                                          bulletin[index]['articleTitle'],
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      ListTile(
                                        title: Text(bulletin[index]
                                            ['articleDescription']),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 17,
                                        ),
                                        child: Container(
                                          alignment: Alignment.topLeft,
                                          child: InkWell(
                                            onTap: () {},
                                            child: const Text(
                                              'Read more',
                                              style: TextStyle(
                                                color: Colors.blue,
                                                decoration:
                                                    TextDecoration.underline,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    //********* HiDoc Bulletin Section ends from here******************

                    //************ HiDoc Trending Bulletin Section ends from here******************

                    Container(
                      width: mediaQuery.size.width * 1,
                      height: mediaQuery.size.width * 3.27,
                      decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(30)),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 10,
                            ),
                            child: Container(
                              alignment: Alignment.topLeft,
                              child: const Text(
                                'Hidoc Trending Bulletin',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Expanded(
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: trendingBulletin.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  child: Column(
                                    children: [
                                      ListTile(
                                        title: Text(
                                          trendingBulletin[index]
                                              ['articleTitle'],
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      ListTile(
                                        title: Text(trendingBulletin[index]
                                            ['articleDescription']),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 15,
                                        ),
                                        child: Container(
                                          alignment: Alignment.topLeft,
                                          child: InkWell(
                                            onTap: () {},
                                            child: const Text(
                                              'Read more',
                                              style: TextStyle(
                                                color: Colors.blue,
                                                decoration:
                                                    TextDecoration.underline,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    //************ HiDoc Trending Bulletin Section ends from here************

                    SizedBox(
                      height: 15,
                    ),

                    //**************Read more Article Buttons***************

                    Container(
                      height: 45,
                      width: mediaQuery.size.width * 0.7,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          elevation: 0,
                        ),
                        onPressed: () {},
                        child: const Text(
                          "Read More Articles",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),

                    //**************Read more Article End Buttons***********

                    const SizedBox(
                      height: 15,
                    ),

                    //*********** Latest Articles Start here **********

                    Container(
                      height: mediaQuery.size.height * 0.2,
                      width: mediaQuery.size.width * 1,
                      constraints: const BoxConstraints(
                        maxHeight: double.infinity,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 0.5,
                        ),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          Container(
                            child: const Text(
                              'Latest Articles',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const Divider(
                            indent: 20,
                            endIndent: 20,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: latestArticle.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  child: Column(
                                    children: [
                                      ListTile(
                                        title: Text(
                                          latestArticle[index]['articleTitle'],
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      const Divider(
                                        indent: 20,
                                        endIndent: 20,
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    //*********** Latest Articles Start here **********

                    const SizedBox(
                      height: 20,
                    ),

                    //*********** Trending Articles Start here **********

                    Container(
                      height: mediaQuery.size.height * 0.75,
                      width: mediaQuery.size.width * 1,
                      constraints: const BoxConstraints(
                        maxHeight: double.infinity,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 0.5,
                        ),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          Container(
                            child: const Text('Tranding Articles',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                          const Divider(
                            indent: 20,
                            endIndent: 20,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 5,
                              right: 5,
                            ),
                            child: Container(
                                child: Image.network(
                                    trendingBulletin[0]['articleImg'])),
                          ),
                          const Divider(
                            indent: 20,
                            endIndent: 20,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: trandingArticle.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  child: Column(
                                    children: [
                                      ListTile(
                                        title: Text(
                                          trandingArticle[index]
                                              ['articleTitle'],
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                      const Divider(
                                        indent: 20,
                                        endIndent: 20,
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    //*********** Latest Articles ends here **********

                    const SizedBox(
                      height: 20,
                    ),

                    //*********** Explore more in Articles Start here **********

                    Container(
                      height: mediaQuery.size.height * 0.6,
                      width: mediaQuery.size.width * 1,
                      constraints: const BoxConstraints(
                        maxHeight: double.infinity,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 0.5,
                        ),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          Container(
                            child: const Text('Explore more in Articles',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                          const Divider(
                            indent: 20,
                            endIndent: 20,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: exploreArticle.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  child: Column(
                                    children: [
                                      ListTile(
                                        title: Text(
                                          exploreArticle[index]['articleTitle'],
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                      const Divider(
                                        indent: 20,
                                        endIndent: 20,
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    //*********** Explore more in Articles Ends here **********

                    const SizedBox(
                      height: 20,
                    ),

                    //**************** Explore Hidoc Dr. Button***************

                    Container(
                      height: 50,
                      width: mediaQuery.size.width * 0.7,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          elevation: 0,
                        ),
                        onPressed: () {},
                        child: const Text(
                          "Explore Hidoc Dr.",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),

                    //**************** Explore Hidoc Dr. Button End***************

                    const SizedBox(
                      height: 20,
                    ),

                    //*******************What\'s more on Hidoc Dr.****************

                    Container(
                      alignment: Alignment.center,
                      width: mediaQuery.size.width * 1,
                      constraints: const BoxConstraints(
                        maxHeight: double.infinity,
                      ),
                      child: const Text(
                        'What\'s more on Hidoc Dr.',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    //****************What\'s more on Hidoc Dr. Ends******************

                    const SizedBox(
                      height: 20,
                    ),

                    //*************** News Sarts from here **************

                    Container(
                      alignment: Alignment.topLeft,
                      height: mediaQuery.size.height * 0.67,
                      width: mediaQuery.size.width * 1,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        border: Border.all(
                          width: 0.5,
                        ),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 15,
                            ),
                            child: Container(
                              alignment: Alignment.topLeft,
                              child: const Text(
                                'News',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Expanded(
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: newsdata.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  child: Column(
                                    children: [
                                      ListTile(
                                        title: Text(
                                          newsdata[index]['title'],
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                      const Divider(
                                        indent: 20,
                                        endIndent: 20,
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 5,
                              right: 5,
                            ),
                            child: Container(
                                child:
                                    Image.network(newsdata[1]['urlToImage'])),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),

                    // *************** News ends Here *****************

                    const SizedBox(
                      height: 20,
                    ),

                    //************** Quizz section Start here *************

                    Container(
                      alignment: Alignment.topCenter,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        border: Border.all(
                          width: 0.5,
                        ),
                      ),
                      height: mediaQuery.size.height * 0.2,
                      width: mediaQuery.size.width * 1,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: const [
                              SizedBox(
                                width: 10,
                              ),
                              CircleAvatar(
                                child: Icon(Icons.wine_bar),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Quizzes: ',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                width: 6,
                              ),
                              Text(
                                'Participate & Win Exciting Prize',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Divider(
                            indent: 20,
                            endIndent: 20,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Row(
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              const CircleAvatar(
                                child: Icon(Icons.calculate_outlined),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Container(
                                width: mediaQuery.size.width * 0.25,
                                child: const Text(
                                  'Medical Calculator: ',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Container(
                                width: mediaQuery.size.width * 0.3,
                                child: const Text(
                                  'Get Access To 800+ Evidence Based Calculator ',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              const Divider(
                                indent: 20,
                                endIndent: 20,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    //************** Quizz section Start here *************

                    const SizedBox(
                      height: 20,
                    ),

                    //*************************** Visit **********************

                    Container(
                      height: mediaQuery.size.height * 0.08,
                      width: mediaQuery.size.width * 1,
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 15,
                            ),
                            child: Container(
                              width: mediaQuery.size.width * 0.6,
                              child: const Text(
                                'Social Network for doctors - A Special feature for Hidoc Dr.',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              right: 15,
                            ),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.greenAccent,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(12), // <-- Radius
                                ),
                              ),
                              child: const Text(
                                'Visit',
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    ),

                    //*************************** Visit Ends Here ************************


                    const SizedBox(
                      height: 20,
                    ),

                  ],
                ),
              ),
            ),
            //********************* Body Ends Here *******************
          ],
        ),
      ),
    );
  }
}

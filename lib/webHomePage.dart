import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class webHomePage extends StatefulWidget {
  const webHomePage({super.key, required this.title});
  final String title;

  @override
  State<webHomePage> createState() => _webHomePageState();
}

class _webHomePageState extends State<webHomePage> {
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
        backgroundColor: Colors.grey.shade100,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //********************* Body Start Here *******************

            Padding(
              padding: const EdgeInsets.only(
                left: 100,
                right: 100,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                ),
                child: Column(
                  children: [
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

                    // *********************critical care dropdown menu send****************

                    const SizedBox(
                      height: 80,
                    ),

                    // *****************Article Section Start here***************

                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                      ),
                      child: Row(
                        children: [
                          Container(
                            height: mediaQuery.size.height * 0.4,
                            child: Stack(
                              children: [
                                Image.asset('assets/image/noimagefound.png'),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Container(
                                    height: 70,
                                    width: 70,
                                    decoration: const BoxDecoration(
                                      color: Colors.lightBlueAccent,
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(40)),
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
                                            article['rewardPoints'].toString(),
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
                              ],
                            ),
                          ),
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Column(
                                children: [
                                  Container(
                                    width: mediaQuery.size.width * 0.4,
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
                                    width: mediaQuery.size.width * 0.4,
                                    child: Text(article['articleDescription']),
                                  ),
                                  const SizedBox(height: 35),
                                  Container(
                                    width: mediaQuery.size.width * 0.4,
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
                                  Container(
                                    width: mediaQuery.size.width * 0.4,
                                    child: Row(
                                      children: [
                                        Text(
                                          'Published Date: ',
                                          style: TextStyle(
                                              color: Colors.grey.shade500),
                                        ),
                                        Text(
                                            DateTime.parse(article['createdAt'])
                                                .toString()),
                                      ],
                                    ),
                                  ),
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

                    const Divider(),

                    const SizedBox(
                      height: 40,
                    ),

                    //*******************Bulletin Section Start from here******************

                    Container(
                      height: mediaQuery.size.height * 1,
                      width: mediaQuery.size.width * 1,
                      child: Row(
                        children: [
                          Container(
                            width: mediaQuery.size.width * 0.4,
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  child: const Text(
                                    'Hidoc Bulletin',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: bulletin.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        decoration: BoxDecoration(
                                            color: Colors.grey.shade200),
                                        child: Column(
                                          children: [
                                            const Divider(
                                              height: 20,
                                              thickness: 5,
                                              indent: 10,
                                              endIndent: 460,
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
                                              height: 20,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                left: 15,
                                              ),
                                              child: Container(
                                                width:
                                                    mediaQuery.size.width * 0.4,
                                                child: InkWell(
                                                  onTap: () {},
                                                  child: const Text(
                                                    'Read more',
                                                    style: TextStyle(
                                                      color: Colors.blue,
                                                      decoration: TextDecoration
                                                          .underline,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.grey.shade200),
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
                          Container(
                            width: mediaQuery.size.width * 0.4,
                            decoration: BoxDecoration(
                                color: Colors.blue.shade50,
                                borderRadius: BorderRadius.circular(30)),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  child: const Text(
                                    'Hidoc Trending Bulletin',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                Expanded(
                                  child: ListView.builder(
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
                                              title: Text(
                                                  trendingBulletin[index]
                                                      ['articleDescription']),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                left: 15,
                                              ),
                                              child: Container(
                                                width:
                                                    mediaQuery.size.width * 0.4,
                                                child: InkWell(
                                                  onTap: () {},
                                                  child: const Text(
                                                    'Read more',
                                                    style: TextStyle(
                                                      color: Colors.blue,
                                                      decoration: TextDecoration
                                                          .underline,
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
                        ],
                      ),
                    ),

                    //**********Bulletin Section Ends here***********

                    const SizedBox(
                      height: 40,
                    ),

                    //**************Read more Article Buttons***************

                    Container(
                      height: 50,
                      width: mediaQuery.size.width * 0.3,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightBlueAccent,
                          elevation: 0,
                        ),
                        onPressed: () {},
                        child: const Text(
                          "Read More Articles",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),

                    //**************Read more Article End Buttons***************

                    const SizedBox(
                      height: 40,
                    ),

                    //**************** More on Article****************

                    Container(
                      height: mediaQuery.size.height * 0.5,
                      width: mediaQuery.size.width * 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            // height: mediaQuery.size.height * 0.4,
                            width: mediaQuery.size.width * 0.25,
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
                                    itemCount: latestArticle.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        child: Column(
                                          children: [
                                            ListTile(
                                              title: Text(
                                                latestArticle[index]
                                                    ['articleTitle'],
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
                          Container(
                            // height: mediaQuery.size.height * 0.4,
                            width: mediaQuery.size.width * 0.25,
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
                                      )),
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
                          Container(
                            // height: mediaQuery.size.height * 0.4,
                            width: mediaQuery.size.width * 0.25,
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
                                    itemCount: exploreArticle.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        child: Column(
                                          children: [
                                            ListTile(
                                              title: Text(
                                                exploreArticle[index]
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
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),

                    //**************** More on Article End Here***************

                    //**************** Explore Hidoc Dr. Button***************

                    Container(
                      height: 50,
                      width: mediaQuery.size.width * 0.3,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightBlueAccent,
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
                      height: 30,
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
                      height: 30,
                    ),

                    //**************************News and Quiz *******************

                    Container(
                      width: mediaQuery.size.width * 1,
                      height: mediaQuery.size.height * 0.3,
                      decoration: BoxDecoration(),
                      child: Row(
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                            height: mediaQuery.size.height * 0.3,
                            width: mediaQuery.size.width * 0.3,
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
                              ],
                            ),
                          ),
                          Container(
                            height: mediaQuery.size.height * 0.3,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              border: Border.all(
                                width: 0.5,
                              ),
                            ),
                            child: Image.network(newsdata[1]['urlToImage']),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Container(
                            alignment: Alignment.topCenter,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              border: Border.all(
                                width: 0.5,
                              ),
                            ),
                            height: mediaQuery.size.height * 0.2,
                            width: mediaQuery.size.width * 0.3,
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
                                      width: mediaQuery.size.width * 0.06,
                                      child: const Text(
                                        'Medical Calculator: ',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 6,
                                    ),
                                    Container(
                                      width: mediaQuery.size.width * 0.1,
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
                        ],
                      ),
                    ),

                    //**************************News and Quiz Ends *******************

                    const SizedBox(
                      height: 40,
                    ),

                    //*************************** Visit **********************

                    Container(
                      height: mediaQuery.size.height * 0.1,
                      width: mediaQuery.size.width * 1,
                      decoration: const BoxDecoration(
                        color: Colors.lightBlueAccent,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(
                              left: 15,
                            ),
                            child: Text(
                              'Social Network for doctors - A Special feature for Hidoc Dr.',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
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
                      height: 40,
                    ),

                    // ******************** Two Images Section ********************

                    Container(
                      height: mediaQuery.size.height * 0.4,
                      width: mediaQuery.size.width * 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 40,
                            ),
                            child: Image.asset(
                              'assets/image/cipla1.jpg',
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              right: 40,
                            ),
                            child: Image.asset(
                              'assets/image/cipla2.jpg',
                            ),
                          ),
                        ],
                      ),
                    ),

                    // ******************** Two Images Section Ends here ********************

                    const SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ),
            ),
            //********************* Body Ends Here *******************

            //*********************** Footer Start here ******************

            Container(
              height: mediaQuery.size.height * 0.4,
              width: mediaQuery.size.width * 1,
              decoration: const BoxDecoration(
                color: Colors.indigo,
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 35, top: 35),
                    child: Container(
                      width: mediaQuery.size.width * 0.2,
                      child: Column(
                        children: [
                          const Text(
                            '#1 Medical App for Doctors in India with 800K Monthly Users',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            child: Row(
                              children: const [
                                CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: Icon(
                                    Icons.facebook_outlined,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: Icon(
                                    Icons.facebook_outlined,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: Icon(
                                    Icons.facebook_outlined,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: Icon(
                                    Icons.facebook_outlined,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 35, left: 35),
                    child: Column(
                      children: [
                        Container(
                          width: mediaQuery.size.width * 0.2,
                          child: const Text(
                            'Reach Us',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: mediaQuery.size.width * 0.2,
                          child: const Text(
                            'Please Contact Below Details',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Container(
                          width: mediaQuery.size.width * 0.2,
                          child: const Text(
                            'Email:',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.cyanAccent,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: mediaQuery.size.width * 0.2,
                          child: const Text(
                            'arbajrmacr786@gmail.com',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Container(
                          width: mediaQuery.size.width * 0.2,
                          child: const Text(
                            'Address:',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.cyanAccent,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: mediaQuery.size.width * 0.2,
                          child: const Text(
                            'Auraia, Aadapur, East Champaran, Bihar, 845301, whatsapp: +91-9650854697',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 35,
                      left: 35,
                    ),
                    child: Container(
                      height: mediaQuery.size.height * 2.5,
                      child: const Text(
                        'HIDOC DR. FEATURES',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            //*********************** Footer Ends here ******************
          ],
        ),
      ),
    );
  }
}

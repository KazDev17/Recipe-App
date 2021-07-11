import 'dart:convert';
//import 'dart:html';
//import 'dart:ui' as ui;
//import 'package:meet_network_image/meet_network_image.dart';
//import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/rendering.dart';
import 'package:recipeapp/views/recipe_view.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:recipeapp/models/recipe_model.dart';
// import 'package:provider/provider.dart';

// import '../Auth.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
//  List<RecipeModel> recipes = new List<RecipeModel>();

  List<RecipeModel> recipes = <RecipeModel>[];
  //for the input field to accept input
  TextEditingController textEditingController = new TextEditingController();
  // String applicationId = '266ae807';
  // String applicationKey = '';
  // // String applicationKey = '005af3ffc9e5791071f91676f83e740f';

  getRecipes(String query) async {
    String url =
        "https://api.edamam.com/search?q=$query&app_id=fc793c90&app_key=45de445ba91d5e3d598e0f49c7c9e288";

    var response = await http.get(Uri.parse(url));
    Map<String, dynamic> jsonData = jsonDecode(response.body);

    jsonData['hits'].forEach((element) {
      // print(element.toString());

      RecipeModel recipeModel = new RecipeModel(
          image: 'image',
          label: 'label',
          postUrl: 'postUrl',
          source: 'source',
          url: 'url');
      recipeModel = RecipeModel.fromMap(element['recipe']);
      recipes.add(recipeModel);
    });

    setState(() {});
    print('${recipes.toString()}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        //stack indicates since we won't be using an AppBar then it should
        //arrange our widgets accordingly from top to bottom
        body: Stack(
      children: <
          Widget> /*this is wdget 1 for the layout of the app containing just the background color */ [
        Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              //this linear gradient is from top to bottom it'd fade into the next color
              gradient: LinearGradient(colors: [
                const Color(0xff6c19b9),
                const Color(0xff300b51)
                //
              ]), //
            ) //
            ),
        SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(
                vertical: !kIsWeb ? 60 : 24, horizontal: 30),
            // this is to add spacing from the top of the project
            //vertical:Platform.isIOS? 60:30 says if it is IOS use a diff of 60 else 30
            /*Scrollability of the widget*/ child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: kIsWeb
                      ? MainAxisAlignment.start
                      : MainAxisAlignment.center,
                  //this is for web app dynamism, where 'kIsWeb ' means if it for a web use (?) ' MainAxisAlignment.start'
                  //else (:) MainAxisAlignment.center
                  children: <Widget>[
                    Text(
                      "Kelvin's ",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                    Text(
                      "CookBook",
                      style: TextStyle(
                        color: Color(0xff1b062f),
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    // RaisedButton(
                    //   padding: EdgeInsets.fromLTRB(20, 0, 0, 10),
                    //   onPressed: () {
                    //     context.read<AuthenticationService>().signOut();
                    //   },
                    //   child: Text('Sign Out'),
                    // ),
                  ],
                ),
                //to create that huge space between the title of the app and the wordings beneath it
                SizedBox(
                  height: 30,
                ),
                Text(
                  'What is your choice of dish for today?',
                  //i added this
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w100,
                      color: Colors.white),
                ),
                //i added this
                SizedBox(
                  height: 9,
                ),

                Text(
                  'Type it in the search bar and your recipe for today would be made available to you',
                  //i added this
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w100,
                      color: Colors.white),
                ),
                //THIS IS FOR TTHE SPACING
                SizedBox(
                  height: 30,
                ),
                //THIS IS FOR THE SEARCH BAR
                Container(
                  width: MediaQuery.of(context)
                      .size
                      .width, //to learn the size of the current media (e.g., the window containing your app)
                  child: Row(
                    children: <Widget>[
                      // Using an Expanded widget makes a child of a Row, Column, or Flex expand to fill the
                      //available space along the main axis (e.g., horizontally for a Row or vertically for a Column).
                      // If multiple children are expanded, the available space is divided among them according to
                      // flex factor
                      Expanded(
                        child: TextField(
                          controller: textEditingController,
                          decoration: InputDecoration(
                            hintText: 'Enter Ingredients',
                            /*this is like placeholder in html*/

                            hintStyle: TextStyle(
                                fontSize: 18,
                                color: Color(0xFFFFEA00).withOpacity(0.5),
                                //WORKING ON THE UNDERLINE
                                fontFamily: 'ShareTechMono'),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      //function to call the api when we click on search
                      InkWell(
                        onTap: () {
                          if (textEditingController.text.isNotEmpty) {
                            getRecipes(textEditingController.text);
                            print('Just Do it');
                          } else {
                            print('Just Don\'t it');
                          }
                        },
                        child: Container(
                          child: Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),

                Container(
                  child: GridView(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
/*makes the scrolling better*/ physics: ClampingScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200, mainAxisSpacing: 10.0),
                    children: List.generate(recipes.length, (index) {
                      return GridTile(
                          child: RecipeTile(
                        imgUrl: recipes[index].image,
                        title: recipes[index].label,
                        url: recipes[index].url,
                        desc: recipes[index].source,
                      ));
                    }),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ));
  }
}

// class MyImage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     String imgUrl = "image";
//     // https://github.com/flutter/flutter/issues/41563
//     // ignore: undefined_prefixed_name
//     ui.platformViewRegistry.registerViewFactory(
//       imgUrl,
//       (int _) => ImageElement()..src = imgUrl,
//     );
//     return HtmlElementView(
//       viewType: imgUrl,
//     );
//   }
// }

// FOR THE GRID VIEW AFTER RESULT HAS BEEN REACHED

class RecipeTile extends StatefulWidget {
  final String url, title, imgUrl, desc;
  //postUrl is for after we click a tile and it opens another window
  RecipeTile({
    required this.imgUrl,
    required this.title,
    required this.url,
    required this.desc,
  });

  @override
  _RecipeTileState createState() => _RecipeTileState();
}

class _RecipeTileState extends State<RecipeTile> {
  _launchURL(String url) async {
    print(url);
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            if (kIsWeb) {
              _launchURL(widget.url);
            } else {
              print(widget.url + " this is what we are going to see");
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RecipeView(
                            postUrl: widget.url,
                          )));
            }
          },
          child: Container(
            margin: EdgeInsets.all(8),
            child: Stack(
              children: <Widget>[
                Image.network(
                  widget.imgUrl,
                  height: 200,
                  width: 200,
                  fit: BoxFit.cover,
                ),
                Container(
                  width: 200,
                  alignment: Alignment.bottomLeft,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.white30, Colors.white],
                          begin: FractionalOffset.centerRight,
                          end: FractionalOffset.centerLeft)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.title,
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.black54,
                              fontFamily: 'Akaya'),
                        ),
                        Text(
                          widget.desc,
                          style: TextStyle(
                              fontSize: 10,
                              color: Colors.black54,
                              fontFamily: 'TechMono'),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/* class GradientCard extends StatelessWidget {
  final Color topColor;
  final Color bottomColor;
  final String topColorCode;
  final String bottomColorCode;

  GradientCard(
      {required this.topColor,
      required this.bottomColor,
      required this.topColorCode,
      required this.bottomColorCode});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        children: <Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                Container(
                  height: 160,
                  width: 180,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [topColor, bottomColor],
                          begin: FractionalOffset.topLeft,
                          end: FractionalOffset.bottomRight)),
                ),
                Container(
                  width: 180,
                  alignment: Alignment.bottomLeft,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.white30, Colors.white],
                          begin: FractionalOffset.centerRight,
                          end: FractionalOffset.centerLeft)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Text(
                          topColorCode,
                          style: TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                        Text(
                          bottomColorCode,
                          style: TextStyle(fontSize: 16, color: bottomColor),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
 */
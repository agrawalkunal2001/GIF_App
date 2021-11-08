import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:http/http.dart' as http;

class GIFPage extends StatefulWidget {
  const GIFPage({Key? key}) : super(key: key);

  @override
  State<GIFPage> createState() => _GIFPageState();
}

class _GIFPageState extends State<GIFPage> {
  final TextEditingController controller = new TextEditingController();
  var data;
  final String url =
      "https://api.giphy.com/v1/gifs/search?api_key=iB04ymlkqsaN2SyIQYFcWaosmKlgbaG6&limit=25&offset=0&rating=g&lang=en&q=";

  getData(String search) async {
    var res = await http.get(Uri.parse(url + search));
    data = jsonDecode(res.body)["data"];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Vx.gray800,
      appBar: AppBar(
        title: "GIF".text.make(),
        backgroundColor: Vx.gray900,
        centerTitle: true,
      ),
      body: Theme(
        data: ThemeData.dark(),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        label: "Search GIFs".text.make(),
                      ),
                    ),
                  ),
                  30.widthBox,
                  SizedBox(
                    height: 62,
                    child: ElevatedButton(
                      onPressed: () {
                        getData(controller.text);
                      },
                      child: Icon(Icons.search),
                    ),
                  ),
                ],
              ),
            ),
            VxConditional(
              condition: data != null,
              builder: (context) => "Data"
                  .text
                  .white
                  .make(), // If condition is true, builder is executed
              fallback: (context) => "Nothing"
                  .text
                  .blue300
                  .xl4
                  .make(), // If condition is false, fallback will be executed
            ),
          ],
        ),
      ),
    );
  }
}

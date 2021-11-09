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
  bool loading = false;
  final TextEditingController controller = new TextEditingController();
  var data;
  final String url =
      "https://api.giphy.com/v1/gifs/search?api_key=iB04ymlkqsaN2SyIQYFcWaosmKlgbaG6&limit=10&offset=0&rating=g&lang=en&q=";

  getData(String search) async {
    loading = true;
    var res = await http.get(Uri.parse(url + search));
    data = jsonDecode(res.body)["data"];
    setState(() {
      loading = false;
    });
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
      body: SingleChildScrollView(
        child: Theme(
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
              if (loading)
                CircularProgressIndicator().centered()
              else
                VxConditional(
                  condition: data != null,
                  builder: (context) => GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: context.isMobile ? 2 : 3,
                    ),
                    itemBuilder: (context, index) {
                      final url = data[index]["images"]["fixed_height"]["url"]
                          .toString();
                      return Image.network(url, fit: BoxFit.cover)
                          .card
                          .roundedSM
                          .make();
                    },
                    itemCount: data.length,
                  ), // If condition is true, builder is executed
                  fallback: (context) => "Nothing Found!"
                      .text
                      .blue300
                      .xl4
                      .make(), // If condition is false, fallback will be executed
                ).h(context.percentHeight * 70),
            ],
          ),
        ),
      ),
    );
  }
}

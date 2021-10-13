import 'dart:convert';

import 'package:dog_api/pets_api_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: const PetsApi(),
    );
  }
}

class PetsApi extends StatefulWidget {
  const PetsApi({Key? key}) : super(key: key);

  @override
  _PetsApiState createState() => _PetsApiState();
}

class _PetsApiState extends State<PetsApi> {
  Future<List<PetsApiModel>?> loadDataFromApi() async {
    try {
      Response res = await http
          .get(Uri.parse("https://api.agentpet.com/api/featured-pets"));
      // print(res.body);
      if (res.statusCode == 200) {
        List<Map<String, dynamic>> decodejson =
            jsonDecode(res.body).cast<Map<String, dynamic>>();
        print('this was called');
        print(decodejson.map((e) => PetsApiModel.fromJson(e)).toList());
        return decodejson.map((e) => PetsApiModel.fromJson(e)).toList();
      } else {
        throw Exception('Error');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: loadDataFromApi(),
        builder: (context, AsyncSnapshot<List<PetsApiModel>?> snapshot) {
          if(snapshot.hasError){
            return Text(snapshot.error.toString());
          }
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, i) {
                  return ListTile(
                    title:
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children:
                          snapshot.data![i].images.map((e) =>
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.network("https://api.agentpet.com/"+e.src),
                              )).toList(),
                      ),
                    ),
                    subtitle: Text(snapshot.data![i].description ?? ''),
                  );

                });
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}

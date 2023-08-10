import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ulkeler/ulke.dart';
import 'package:ulkeler/ulke_detay_page.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String _apiUrl =
      "https://restcountries.com/v3.1/all?fields=cca2,name,capital,region,population,flags,languages";

  // Ulke listesi
  List<Ulke> ulkeler = [];
  List<String> _favoriler = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getFavourites().then((_) {
        _getCountries();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ülkeler"),
      ),
      body: _buildCountryList(),
    );
  }

  Widget _buildCountryList() {
    return ListView.builder(
      itemCount: ulkeler.length,
      itemBuilder: _buildListItem,
    );
  }

  Widget _buildListItem(BuildContext context, int index) {
    Ulke ulke = ulkeler[index];
    return ListTile(
      title: Text(
        ulke.name,
      ),
      subtitle: Text("Başkent: ${ulke.capital}"),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(
          ulke.flag,
        ),
      ),
      trailing: IconButton(
        icon: Icon(
          _favoriler.contains(ulke.code)
              ? Icons.favorite
              : Icons.favorite_border,
        ),
        onPressed: () {
          _addFavourite(ulke);
        },
      ),
      onTap: () {
        _openCountryDetailPage(context, ulke);
      },
    );
  }

  Future<void> _getFavourites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _favoriler = prefs.getStringList("favoriler") ?? [];
  }

  void _getCountries() async {
    Uri uri = Uri.parse(_apiUrl);
    http.Response response = await http.get(uri);
    List<dynamic> countryList = jsonDecode(response.body);
    for (Map<String, dynamic> countryMap in countryList) {
      Ulke ulke = Ulke.fromMap(countryMap);
      ulkeler.add(ulke);
    }

    ulkeler.sort((a, b) => a.name.compareTo(b.name));

    setState(() {});
  }

  void _openCountryDetailPage(BuildContext context, Ulke ulke) {
    MaterialPageRoute route = MaterialPageRoute(builder: (context) {
      return UlkeDetayPage(ulke);
    });
    Navigator.push(context, route);
  }

  void _addFavourite(Ulke ulke) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      if (!_favoriler.contains(ulke.code)) {
        _favoriler.add(ulke.code);
      } else {
        _favoriler.remove(ulke.code);
      }
    });
    await prefs.setStringList("favoriler", _favoriler);
  }
}

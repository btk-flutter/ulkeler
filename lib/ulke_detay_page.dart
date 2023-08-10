import 'package:flutter/material.dart';
import 'package:ulkeler/ulke.dart';

class UlkeDetayPage extends StatelessWidget {
  final Ulke ulke;

  UlkeDetayPage(this.ulke, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ulke.name),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 48, left: 16, right: 16),
      child: Column(
        children: [
          _buildFlag(context),
          SizedBox(height: 16),
          _buildCountryName(),
          SizedBox(height: 48),
          _buildDetailText("Ülke ismi:", ulke.name),
          _buildDetailText("Başkent:", ulke.capital),
          _buildDetailText("Bölge:", ulke.region),
          _buildDetailText("Nüfus:", ulke.population.toString()),
          _buildDetailText("Dil", ulke.language),
        ],
      ),
    );
  }

  Widget _buildFlag(BuildContext context) {
    return Center(
      child: Image.network(
        ulke.flag,
        fit: BoxFit.cover,
        width: MediaQuery.of(context).size.width * 0.7,
      ),
    );
  }

  Widget _buildCountryName() {
    return Text(
      ulke.name,
      style: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildDetailText(String baslik, String deger) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              baslik,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 12),
            Text(
              deger,
              style: TextStyle(
                fontSize: 24,
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
      ],
    );
  }
}

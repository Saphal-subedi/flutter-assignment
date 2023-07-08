import 'package:flutter/material.dart';

class Product extends StatelessWidget {
  Product(
      {super.key,
      required this.image,
      required this.price,
      required this.title,
      required this.description});

  final String image;
  final String price;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: (() {
              Navigator.pop(context);
            }),
            icon: Icon(Icons.arrow_back)),
        title: Text(title),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            padding: EdgeInsets.all(10.0),
            width: double.infinity,
            child: Column(children: [
              Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: Image.network(image)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    "Rs: $price",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5.0),
              Divider(),
              Text(description),
            ]),
          ),
        ),
      ),
    );
  }
}

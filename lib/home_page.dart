import 'package:flutter/material.dart';

import 'package:onlinestore/individual_product.dart';
import 'package:onlinestore/provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Online Store"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ChangeNotifierProvider<AlDataList>(
            create: (context) => AlDataList(),
            child: Consumer<AlDataList>(builder: (context, value, child) {
              value.getAllProduct();
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: searchController,
                            decoration: InputDecoration(
                              hintText: "Search using Product name",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            final searchText = searchController.text;
                            Provider.of<AlDataList>(context, listen: false)
                                .onSearch(searchText);
                          },
                          child: const Text(
                            "search",
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    ListView.separated(
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 20.0),
                      shrinkWrap: true,
                      itemBuilder: ((context, index) {
                        final product = value.isSearchPerformed
                            ? value.filteredDetails[index]
                            : value.allDetails[index];
                        return Card(
                          color: Colors.pinkAccent,
                          elevation: 5,
                          child: ListTile(
                            title: Text(product.title),
                            leading: Image.network(product.image),
                            trailing: Text("Rs: ${product.price}"),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Product(
                                            image: product.image,
                                            price: product.price.toString(),
                                            title: product.title,
                                            description: product.description,
                                          )));
                            },
                          ),
                        );
                      }),
                      itemCount: value.isSearchPerformed
                          ? value.filteredDetails.length
                          : value.allDetails.length,
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

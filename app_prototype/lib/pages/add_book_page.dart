import 'package:flutter/material.dart';

class AddBookPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AddBookPageState();
}

class AddBookPageState extends State<AddBookPage> {
  List<String> genres = ['Action', 'Fantasy', 'Comedy'];
  String title = '';
  List<String> genresSelected = [];
  String author = '';

  void selectValue(String? string) {
    setState(() {
      genresSelected.add(string!);
    });
  }

  void removeValue(String? string) {
    setState(() {
      genresSelected.remove(string);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(
            top: 100,
            left: 25,
            right: 25
          ),
          child: Column(
            children: [
              const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Title',
                      style: TextStyle(fontSize: 20),
                    ),
                  ]
              ),
              TextField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                ),
                onChanged: (String string){author = string;},
              ),
              const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Genres',
                      style: TextStyle(fontSize: 20),
                    ),
                  ]
              ),
              Autocomplete<String>(
                onSelected: (String? value) {
                  selectValue(value);
                  value = '';
                },
                optionsBuilder: (TextEditingValue textEditingValue) {
                  return genres.where((String option) {return option.toLowerCase().contains(textEditingValue.text.toLowerCase());});
                }
              ),
              if (genresSelected.isNotEmpty) Row(
                  children: [
                    for (String string in genresSelected) Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Colors.red,
                      ),
                      child: Row(
                        children: [
                          Text(string),
                          IconButton(onPressed: (){removeValue(string);}, icon: Icon(Icons.close))
                        ],
                      ),
                    )
                  ],
              ),
              const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Author',
                      style: TextStyle(fontSize: 20),
                    ),
                  ]
              ),
              TextField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                ),
                onChanged: (String string){author = string;},
              )
            ],
          ),
        )
    );
  }
}
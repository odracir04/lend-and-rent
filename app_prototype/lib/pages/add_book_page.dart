import 'package:cloud_firestore/cloud_firestore.dart';
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
  String location = '';

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

  void addBook() {
    FirebaseFirestore db = FirebaseFirestore.instance;
    final book = {
      "author": author,
      "title": title,
      "title_lowercase": title.toLowerCase(),
      "location": location,
      "imagePath": "assets/images/book.jpg",
      "genres": genresSelected,
    };
    db.collection('books').doc().set(book);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset : false,
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
                onChanged: (String string){title = string;},
                textInputAction: TextInputAction.next
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
                textInputAction: TextInputAction.next
              ),
              const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Location',
                      style: TextStyle(fontSize: 20),
                    ),
                  ]
              ),
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                onChanged: (String string){location = string;},
                textInputAction: TextInputAction.done
              ),
              const SizedBox(height: 30),
              SizedBox(
                  width: 0.90 * MediaQuery.of(context).size.width,
                  height: 50,
                  child: (title.isEmpty || genresSelected.isEmpty || author.isEmpty || location.isEmpty) ? TextButton(
                    onPressed: null,
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                        return Colors.grey;
                      })
                    ),
                    child: const Text('Add book'),
                  )
                  : TextButton(
                    onPressed: addBook,
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                          return Colors.red;
                        })
                    ),
                    child: const Text('Add book'),
                  )
              )
            ],
          ),
        )
    );
  }
}
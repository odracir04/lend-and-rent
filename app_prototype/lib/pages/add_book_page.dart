import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddBookPage extends StatefulWidget {
  AddBookPage({super.key, required this.darkTheme});

  bool darkTheme;

  @override
  State<StatefulWidget> createState() => AddBookPageState();
}

class AddBookPageState extends State<AddBookPage> {
  List<String> genres = ['Action',
    'Adventure',
    'Comedy',
    'Crime',
    'Fantasy',
    'Horror',
    'Mystery',
    'Romance',
    'Sci-fi'
  ];
  String title = '';
  List<String> genresSelected = [];
  String author = '';
  String location = '';

  void selectValue(String? string) {
    setState(() {
      genresSelected.add(string!);
      genres.remove(string);
    });
  }

  void removeValue(String? string) {
    setState(() {
      genresSelected.remove(string);
      genres.add(string!);
      genres.sort();
    });
  }

  void addBook() {
    FirebaseFirestore db = FirebaseFirestore.instance;
    final book = {
      "user": FirebaseAuth.instance.currentUser?.email,
      "author": author,
      "title": title,
      "title_lowercase": title.toLowerCase(),
      "location": location,
      "imagePath": "assets/images/book.jpg",
      "genres": genresSelected,
    };
    db.collection('books').doc().set(book);
    Navigator.pop(context, "addedBook");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 50),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(width: 10),
                    IconButton(
                        onPressed: () {Navigator.pop(context);},
                        icon: const Icon(Icons.arrow_back, size: 30,)
                    )
                  ]
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 25,
                    right: 25,
                    bottom: MediaQuery.of(context).viewInsets.bottom
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 50,),
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
                        onChanged: (String string){setState(() {
                          title = string;
                        });},
                        textInputAction: TextInputAction.next
                    ),
                    const SizedBox(height: 10),
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
                        },
                        optionsBuilder: (TextEditingValue textEditingValue) {
                          return genres.where((String option) {return option.toLowerCase().contains(textEditingValue.text.toLowerCase());});
                        }
                    ),
                    if (genresSelected.isNotEmpty) Column(
                      children: [
                        for (int i = 0; i < genresSelected.length; i += 3) Row(
                          children: [
                            for (int j = i; j < i + 3 && j < genresSelected.length; j++) Column(
                              children: [
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Container(
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(Radius.circular(20)),
                                          color: widget.darkTheme ? Colors.white : Colors.grey.shade900,
                                        ),
                                        child: Row(
                                          children: [
                                            const SizedBox(width: 9),
                                            Text(genresSelected[j], style: TextStyle(color: widget.darkTheme ? Colors.black : Colors.white70),),
                                            IconButton(onPressed: (){removeValue(genresSelected[j]);}, icon: Icon(Icons.close, color: widget.darkTheme ? Colors.black : Colors.white70,))
                                          ],
                                        )
                                    ),
                                    if (j % 3 != 2) const SizedBox(width: 5)
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ]
                    ),
                    const SizedBox(height: 10),
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
                        onChanged: (String string){setState(() {
                          author = string;
                        });},
                        textInputAction: TextInputAction.next
                    ),
                    const SizedBox(height: 10),
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
                        onChanged: (String string){setState(() {
                          location = string;
                        });},
                        textInputAction: TextInputAction.done,
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
                                    return widget.darkTheme ? Colors.white : Colors.grey.shade900;
                                  })
                              ),
                              child: Text('Add book', style: TextStyle(color: widget.darkTheme ? Colors.black : Colors.white70),),
                            )
                    )
                  ],
                ),
              )
            ],
          )
        )
    );
  }
}
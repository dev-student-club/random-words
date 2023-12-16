import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const RandomWords(),
    );
  }
}

class RandomWords extends StatefulWidget {
  const RandomWords({super.key});

  @override
  State<RandomWords> createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  String randomWord = WordPair.random().asString;
  var savedWord = [];

  void _changeWord() {
    setState(() {
      randomWord = WordPair.random().asString;
    });
  }

  void _saveWord(String word) {
    if (!savedWord.contains(word)) {
      savedWord.add(word);
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                "Detail Words",
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.purple,
              iconTheme: const IconThemeData(color: Colors.white),
            ),
            body: _buildSavedWordsList(),
          );
        },
      ),
    );
  }

  Widget _buildSavedWordsList() {
    return ListView.builder(
      itemCount: savedWord.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildWordCard(savedWord[index]);
      },
    );
  }

  Widget _buildWordCard(String word) {
    return Container(
      height: 100,
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          word,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Random Words",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.purple,
      ),
      body: Center(
          child: Container(
        margin: const EdgeInsets.only(left: 24, right: 24),
        height: 150,
        // width: 200,
        child: Card(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                randomWord,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
              IconButton(
                  onPressed: () {
                    _saveWord(randomWord);
                  },
                  icon: const Icon(Icons.favorite_border))
            ],
          ),
        ),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _changeWord();
        },
        child: const Icon(Icons.play_arrow),
      ),
    );
  }
}

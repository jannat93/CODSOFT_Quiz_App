import 'package:flutter/material.dart';
import 'result_screen.dart';
import 'dart:async';

class QuizScreen extends StatefulWidget {
  final String category;
  QuizScreen({required this.category});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestionIndex = 0;
  int score = 0;
  int seconds = 10;
  Timer? timer;

  late List<Map<String, dynamic>> questions;

  // Questions for each category
  final Map<String, List<Map<String, dynamic>>> categoryQuestions = {
    "Science": [
      {"question": "What is the chemical symbol for gold?", "options": ["Ag", "Au", "Pb"], "answer": "Au"},
      {"question": "Which gas do plants absorb from the atmosphere?", "options": ["Oxygen", "Nitrogen", "Carbon dioxide"], "answer": "Carbon dioxide"},
      {"question": "What is the powerhouse of the cell?", "options": ["Nucleus", "Mitochondria", "Ribosome"], "answer": "Mitochondria"},
      {"question": "What is the speed of light?", "options": ["300,000 km/s", "150,000 km/s", "1,000 km/s"], "answer": "300,000 km/s"},
      {"question": "Which planet is known as the Red Planet?", "options": ["Mars", "Jupiter", "Venus"], "answer": "Mars"},
      {"question": "Which element is needed for breathing?", "options": ["Hydrogen", "Oxygen", "Carbon"], "answer": "Oxygen"},
      {"question": "Who developed the theory of relativity?", "options": ["Isaac Newton", "Albert Einstein", "Galileo"], "answer": "Albert Einstein"},
      {"question": "Which vitamin is produced when exposed to sunlight?", "options": ["Vitamin A", "Vitamin D", "Vitamin C"], "answer": "Vitamin D"},
      {"question": "What does DNA stand for?", "options": ["Deoxyribonucleic Acid", "Dynamic Neural Analysis", "Dual Nucleotide Arrangement"], "answer": "Deoxyribonucleic Acid"},
      {"question": "What is the smallest unit of matter?", "options": ["Atom", "Molecule", "Electron"], "answer": "Atom"},
    ],
    "Math": [
      {"question": "What is 12 × 8?", "options": ["80", "96", "102"], "answer": "96"},
      {"question": "What is the square root of 144?", "options": ["12", "14", "16"], "answer": "12"},
      {"question": "Solve: 25 + 5 × 2", "options": ["30", "35", "40"], "answer": "35"},
      {"question": "What is the value of π (pi) to two decimal places?", "options": ["3.14", "3.16", "3.18"], "answer": "3.14"},
      {"question": "Which shape has 5 sides?", "options": ["Pentagon", "Hexagon", "Octagon"], "answer": "Pentagon"},
      {"question": "What is 15% of 200?", "options": ["25", "30", "35"], "answer": "30"},
      {"question": "If a triangle has angles 90° and 45°, what is the third angle?", "options": ["30°", "45°", "60°"], "answer": "45°"},
      {"question": "What is 7 cubed (7³)?", "options": ["343", "247", "144"], "answer": "343"},
      {"question": "What is 2^5?", "options": ["10", "32", "64"], "answer": "32"},
      {"question": "What is 0 factorial (0!)?", "options": ["1", "0", "-1"], "answer": "1"},
    ],
    "History": [
      {"question": "Who was the first President of the United States?", "options": ["George Washington", "Abraham Lincoln", "Thomas Jefferson"], "answer": "George Washington"},
      {"question": "In which year did World War II end?", "options": ["1945", "1939", "1950"], "answer": "1945"},
      {"question": "Who discovered America in 1492?", "options": ["Christopher Columbus", "Vasco da Gama", "James Cook"], "answer": "Christopher Columbus"},
      {"question": "Which civilization built the pyramids?", "options": ["Romans", "Egyptians", "Greeks"], "answer": "Egyptians"},
      {"question": "What year did the Titanic sink?", "options": ["1912", "1922", "1905"], "answer": "1912"},
      {"question": "Who was the first man on the moon?", "options": ["Neil Armstrong", "Buzz Aldrin", "Yuri Gagarin"], "answer": "Neil Armstrong"},
      {"question": "Which country gifted the Statue of Liberty to the USA?", "options": ["France", "Germany", "UK"], "answer": "France"},
      {"question": "Who was known as the Iron Lady?", "options": ["Margaret Thatcher", "Indira Gandhi", "Angela Merkel"], "answer": "Margaret Thatcher"},
      {"question": "Which war lasted from 1955 to 1975?", "options": ["Vietnam War", "World War I", "Cold War"], "answer": "Vietnam War"},
      {"question": "Who wrote the Declaration of Independence?", "options": ["Thomas Jefferson", "George Washington", "Benjamin Franklin"], "answer": "Thomas Jefferson"},
    ],
    "Geography": [
      {"question": "What is the largest continent?", "options": ["Asia", "Africa", "Europe"], "answer": "Asia"},
      {"question": "Which country is home to the Great Barrier Reef?", "options": ["Australia", "United States", "South Africa"], "answer": "Australia"},
      {"question": "What is the longest river in the world?", "options": ["Amazon River", "Nile River", "Yangtze River"], "answer": "Nile River"},
      {"question": "Which mountain is the highest in the world?", "options": ["Mount Everest", "K2", "Mount Kilimanjaro"], "answer": "Mount Everest"},
      {"question": "In which country is the city of Cairo located?", "options": ["Egypt", "Turkey", "Greece"], "answer": "Egypt"},
      {"question": "Which country has the most islands?", "options": ["Sweden", "Indonesia", "Canada"], "answer": "Sweden"},
      {"question": "What is the capital city of Japan?", "options": ["Seoul", "Beijing", "Tokyo"], "answer": "Tokyo"},
      {"question": "Which desert is the largest in the world?", "options": ["Sahara Desert", "Gobi Desert", "Arabian Desert"], "answer": "Sahara Desert"},
      {"question": "What is the smallest country in the world?", "options": ["Monaco", "Vatican City", "San Marino"], "answer": "Vatican City"},
      {"question": "Which ocean is the largest?", "options": ["Atlantic Ocean", "Indian Ocean", "Pacific Ocean"], "answer": "Pacific Ocean"}
    ],
    "Sports": [
      {"question": "Who holds the record for the most goals in World Cup history?", "options": ["Marta", "Pele", "Miroslav Klose"], "answer": "Miroslav Klose"},
      {"question": "Which country hosted the 2016 Summer Olympics?", "options": ["China", "Brazil", "United States"], "answer": "Brazil"},
      {"question": "Who won the FIFA World Cup in 2018?", "options": ["France", "Germany", "Argentina"], "answer": "France"},
      {"question": "In which sport would you perform a slam dunk?", "options": ["Basketball", "Tennis", "Football"], "answer": "Basketball"},
      {"question": "Who is known as 'The King of Tennis'?", "options": ["Roger Federer", "Rafael Nadal", "Novak Djokovic"], "answer": "Rafael Nadal"},
      {"question": "Which country is the birthplace of the sport rugby?", "options": ["Australia", "New Zealand", "England"], "answer": "England"},
      {"question": "Who won the 2020 Formula 1 World Championship?", "options": ["Lewis Hamilton", "Sebastian Vettel", "Max Verstappen"], "answer": "Lewis Hamilton"},
      {"question": "Which athlete is known for the 'fastest man' title?", "options": ["Usain Bolt", "Michael Phelps", "Carl Lewis"], "answer": "Usain Bolt"},
      {"question": "Which country has won the most Olympic gold medals?", "options": ["United States", "Germany", "Russia"], "answer": "United States"},
      {"question": "What is the maximum number of players on a soccer field per team during a match?", "options": ["10", "11", "12"], "answer": "11"}
    ],
    "Technology": [
      {"question": "Who is known as the father of the computer?", "options": ["Charles Babbage", "Alan Turing", "Bill Gates"], "answer": "Charles Babbage"},
      {"question": "What does the acronym 'HTML' stand for?", "options": ["Hyper Text Markup Language", "High Text Markup Language", "Hyperlink Text Markup Language"], "answer": "Hyper Text Markup Language"},
      {"question": "Which company developed the first personal computer?", "options": ["Apple", "IBM", "Microsoft"], "answer": "IBM"},
      {"question": "What was the first video game ever made?", "options": ["Pong", "Space Invaders", "Tetris"], "answer": "Pong"},
      {"question": "Which programming language is primarily used for web development?", "options": ["Python", "JavaScript", "C++"], "answer": "JavaScript"},
      {"question": "What year was the first iPhone released?", "options": ["2005", "2007", "2010"], "answer": "2007"},
      {"question": "Which company created the Android operating system?", "options": ["Apple", "Google", "Microsoft"], "answer": "Google"},
      {"question": "What is the name of the first artificial satellite launched into space?", "options": ["Sputnik 1", "Explorer 1", "Hubble 1"], "answer": "Sputnik 1"},
      {"question": "Which company is behind the popular video-sharing platform YouTube?", "options": ["Google", "Microsoft", "Facebook"], "answer": "Google"},
      {"question": "What does 'AI' stand for in technology?", "options": ["Artificial Intelligence", "Automated Interface", "Advanced Innovation"], "answer": "Artificial Intelligence"}
    ],
    "Entertainment": [
      {"question": "Who won the Academy Award for Best Actor in 2020?", "options": ["Leonardo DiCaprio", "Joaquin Phoenix", "Brad Pitt"], "answer": "Joaquin Phoenix"},
      {"question": "What is the highest-grossing film of all time?", "options": ["Avengers: Endgame", "Titanic", "Avatar"], "answer": "Avengers: Endgame"},
      {"question": "Which singer is known as the 'Queen of Pop'?", "options": ["Madonna", "Lady Gaga", "Beyoncé"], "answer": "Madonna"},
      {"question": "Which animated movie features the characters Woody and Buzz Lightyear?", "options": ["Frozen", "Toy Story", "Shrek"], "answer": "Toy Story"},
      {"question": "What TV series features the characters Jon Snow and Daenerys Targaryen?", "options": ["Game of Thrones", "The Witcher", "Breaking Bad"], "answer": "Game of Thrones"},
      {"question": "Which actor played the role of Jack Dawson in 'Titanic'?", "options": ["Johnny Depp", "Brad Pitt", "Leonardo DiCaprio"], "answer": "Leonardo DiCaprio"},
      {"question": "What year did the first Harry Potter movie come out?", "options": ["1999", "2001", "2003"], "answer": "2001"},
      {"question": "Which video game franchise features characters like Mario, Luigi, and Princess Peach?", "options": ["The Legend of Zelda", "Super Mario", "Pokemon"], "answer": "Super Mario"},
      {"question": "Who is the author of the 'Lord of the Rings' series?", "options": ["George R.R. Martin", "J.R.R. Tolkien", "J.K. Rowling"], "answer": "J.R.R. Tolkien"},
      {"question": "What is the longest-running TV show in history?", "options": ["Friends", "The Simpsons", "The Office"], "answer": "The Simpsons"}
    ],
    "Literature": [
      {"question": "Who wrote the play 'Romeo and Juliet'?", "options": ["William Shakespeare", "Charles Dickens", "Jane Austen"], "answer": "William Shakespeare"},
      {"question": "What is the title of the first book in the 'Harry Potter' series?", "options": ["Harry Potter and the Chamber of Secrets", "Harry Potter and the Philosopher's Stone", "Harry Potter and the Goblet of Fire"], "answer": "Harry Potter and the Philosopher's Stone"},
      {"question": "Who wrote 'Pride and Prejudice'?", "options": ["Charlotte Brontë", "Jane Austen", "Emily Dickinson"], "answer": "Jane Austen"},
      {"question": "What is the name of the author of 'The Great Gatsby'?", "options": ["Ernest Hemingway", "F. Scott Fitzgerald", "Mark Twain"], "answer": "F. Scott Fitzgerald"},
      {"question": "Which novel begins with the line, 'Call me Ishmael'?", "options": ["Moby-Dick", "The Odyssey", "The Catcher in the Rye"], "answer": "Moby-Dick"},
      {"question": "Who wrote '1984'?", "options": ["George Orwell", "Aldous Huxley", "Ray Bradbury"], "answer": "George Orwell"},
      {"question": "In which novel would you find the character Atticus Finch?", "options": ["The Grapes of Wrath", "To Kill a Mockingbird", "Of Mice and Men"], "answer": "To Kill a Mockingbird"},
      {"question": "What is the title of the novel written by J.R.R. Tolkien that was later adapted into a movie series?", "options": ["The Hobbit", "The Fellowship of the Ring", "The Silmarillion"], "answer": "The Hobbit"},
      {"question": "Who wrote 'The Catcher in the Rye'?", "options": ["J.D. Salinger", "F. Scott Fitzgerald", "John Steinbeck"], "answer": "J.D. Salinger"},
      {"question": "Which novel is set in the dystopian world of Panem?", "options": ["The Hunger Games", "Divergent", "The Maze Runner"], "answer": "The Hunger Games"}
    ],
    "Music": [
      {"question": "Who is known as the 'King of Pop'?", "options": ["Michael Jackson", "Elvis Presley", "Prince"], "answer": "Michael Jackson"},
      {"question": "Which band released the album 'Abbey Road'?", "options": ["The Beatles", "The Rolling Stones", "Led Zeppelin"], "answer": "The Beatles"},
      {"question": "Who is the lead singer of the band Queen?", "options": ["Freddie Mercury", "Axl Rose", "Mick Jagger"], "answer": "Freddie Mercury"},
      {"question": "What year did Elvis Presley pass away?", "options": ["1977", "1980", "1990"], "answer": "1977"},
      {"question": "Which song is known for the line 'Is this the real life? Is this just fantasy?'", "options": ["Bohemian Rhapsody", "Stairway to Heaven", "Imagine"], "answer": "Bohemian Rhapsody"},
      {"question": "Which country is the band ABBA from?", "options": ["Sweden", "England", "United States"], "answer": "Sweden"},
      {"question": "What is the name of Taylor Swift's debut album?", "options": ["Fearless", "1989", "Taylor Swift"], "answer": "Taylor Swift"},
      {"question": "Which classical composer wrote the 'Ode to Joy'?", "options": ["Ludwig van Beethoven", "Wolfgang Amadeus Mozart", "Johann Sebastian Bach"], "answer": "Ludwig van Beethoven"},
      {"question": "Which artist is known for the hit song 'Rolling in the Deep'?", "options": ["Adele", "Beyoncé", "Rihanna"], "answer": "Adele"},
      {"question": "What instrument does Yo-Yo Ma play?", "options": ["Piano", "Violin", "Cello"], "answer": "Cello"}
    ],
    "Art": [
      {"question": "Who painted the 'Mona Lisa'?", "options": ["Vincent van Gogh", "Pablo Picasso", "Leonardo da Vinci"], "answer": "Leonardo da Vinci"},
      {"question": "Which artist is known for the 'Starry Night'?", "options": ["Claude Monet", "Vincent van Gogh", "Edvard Munch"], "answer": "Vincent van Gogh"},
      {"question": "In which art movement is Pablo Picasso considered a major figure?", "options": ["Surrealism", "Cubism", "Impressionism"], "answer": "Cubism"},
      {"question": "What is the name of the famous sculpture by Michelangelo depicting a biblical hero?", "options": ["David", "The Thinker", "Venus de Milo"], "answer": "David"},
      {"question": "Who painted 'The Persistence of Memory'?", "options": ["Salvador Dalí", "René Magritte", "Frida Kahlo"], "answer": "Salvador Dalí"},
      {"question": "Which artist created the 'Guernica' painting?", "options": ["Pablo Picasso", "Jackson Pollock", "Andy Warhol"], "answer": "Pablo Picasso"},
      {"question": "What style of art is Claude Monet associated with?", "options": ["Impressionism", "Realism", "Renaissance"], "answer": "Impressionism"},
      {"question": "Who painted the 'Last Supper'?", "options": ["Michelangelo", "Leonardo da Vinci", "Raphael"], "answer": "Leonardo da Vinci"},
      {"question": "Which artist is known for his colorful abstract paintings and influence on modern art?", "options": ["Jackson Pollock", "Georges Seurat", "Henri Matisse"], "answer": "Jackson Pollock"},
      {"question": "What is the art style associated with Andy Warhol?", "options": ["Abstract Expressionism", "Pop Art", "Cubism"], "answer": "Pop Art"}
    ]
  };


  @override
  void initState() {
    super.initState();
    questions = categoryQuestions[widget.category]!;
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (seconds > 0) {
        setState(() {
          seconds--;
        });
      } else {
        nextQuestion();
      }
    });
  }

  void nextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        seconds = 10; // Reset timer for next question
      });
    } else {
      timer?.cancel();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ResultScreen(score: score, )),
      );
    }
  }

  void checkAnswer(String selectedOption) {
    if (selectedOption == questions[currentQuestionIndex]['answer']) {
      setState(() {
        score++;
      });
    }
    nextQuestion();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue, Colors.purple],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          toolbarHeight: 80,
          backgroundColor: Colors.transparent,
          title: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(widget.category,style: TextStyle(color: Colors.white),),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Timer inside a circle
              Container(
                width: 100,  // Set the width of the circle
                height: 100, // Set the height of the circle
                decoration: BoxDecoration(
                  shape: BoxShape.circle, // Make it circular
                  color: Colors.blue,     // Background color of the circle
                ),
                child: Center(
                  child: Text(
                    "$seconds",  // Display timer value
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                questions[currentQuestionIndex]['question'],
                style: TextStyle(fontSize: 22, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              ...questions[currentQuestionIndex]['options'].map<Widget>((option) {
                return Column(
                  children: [
                    ElevatedButton(
                      onPressed: () => checkAnswer(option),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                      ),
                      child: Text(option, style: TextStyle(fontSize: 18)),
                    ),
                    SizedBox(height: 10), // Add space after each option
                  ],
                );
              }).toList(),
            ],

          ),
        ),

      ),
    );
  }
}


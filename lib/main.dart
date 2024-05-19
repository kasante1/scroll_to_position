import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SearchExample(),
    );
  }
}

class SearchExample extends StatefulWidget {
  @override
  _SearchExampleState createState() => _SearchExampleState();
}

class _SearchExampleState extends State<SearchExample> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  final GlobalKey _textKey = GlobalKey();
  List<MatchInfo> _matches = [];

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _searchAndHighlight() {
    String searchQuery = _searchController.text;
    RenderBox textBox = _textKey.currentContext?.findRenderObject() as RenderBox;
    double totalHeight = textBox.size.height;

    setState(() {
      _matches = [];
      if (searchQuery.isNotEmpty) {
        String text = _textContent;
        RegExp regExp = RegExp(searchQuery, caseSensitive: false);
        Iterable<RegExpMatch> regExpMatches = regExp.allMatches(text);
        _matches = regExpMatches.map((match) {
          final textBeforeMatch = text.substring(0, match.start);
          final textPainter = TextPainter(
            text: TextSpan(text: textBeforeMatch),
            textDirection: TextDirection.ltr,
          )..layout();
          final offset = textPainter.height.clamp(0.0, totalHeight - textBox.size.height);
          return MatchInfo(match.start, match.end, offset);
        }).toList();
      }
    });
  }

  void _scrollToMatch(int index) {
    if (_matches.isNotEmpty && index < _matches.length) {
      final match = _matches[index];
      _scrollController.animateTo(
        match.offset,
        duration: Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    }
  }

  String get _textContent => '''
and providing some short definitions, which we will expand on later. (If you feel your eyes are glazing
over, please skip this section and return to it later!) Yes, you may find the following descriptions a bit
perplexing, but bear with us—we’ll go into more detail in just a bit:
•••Currying is transforming an m-ary function (that is, a function of arity m) into a sequence of
m unary functions, each receiving one argument of the original function, from left to right.
(The first function receives the first argument of the original function and returns a second
function, which receives the second argument and returns a third function, which receives the
third argument, and so on.) Upon being called with an argument, each function produces the
next one in the sequence, and the last one does the actual calculations.
Partial application is providing n arguments to an m-ary function, with n less than or equal to m,
to transform it into a function with (m-n) parameters. Each time you provide some arguments,
a new function is produced, with smaller arity. When you provide the last arguments, the actual
calculations are performed.
Partial currying is a mixture of both preceding ideas: you provide n arguments (from left to
right) to an m-ary function and produce a new function of arity (m-n). When this new function
receives some other arguments, also from left to right, it will produce yet another function.
When the last parameters are provided, the function produces the correct calculations.
In this chapter, we will see these three transformations, what they require, and ways of implementing them.
and providing some short definitions, which we will expand on later. (If you feel your eyes are glazing
over, please skip this section and return to it later!) Yes, you may find the following descriptions a bit
perplexing, but bear with us—we’ll go into more detail in just a bit:
•••Currying is transforming an m-ary function (that is, a function of arity m) into a sequence of
m unary functions, each receiving one argument of the original function, from left to right.
(The first function receives the first argument of the original function and returns a second
function, which receives the second argument and returns a third function, which receives the
third argument, and so on.) Upon being called with an argument, each function produces the
next one in the sequence, and the last one does the actual calculations.
Partial application is providing n arguments to an m-ary function, with n less than or equal to m,
to transform it into a function with (m-n) parameters. Each time you provide some arguments,
a new function is produced, with smaller arity. When you provide the last arguments, the actual
calculations are performed.
Partial currying is a mixture of both preceding ideas: you provide n arguments (from left to
right) to an m-ary function and produce a new function of arity (m-n). When this new function
receives some other arguments, also from left to right, it will produce yet another function.
When the last parameters are provided, the function produces the correct calculations.
In this chapter, we will see these three transformations, what they require, and ways of implementing them

and providing some short definitions, which we will expand on later. (If you feel your eyes are glazing
over, please skip this section and return to it later!) Yes, you may find the following descriptions a bit
perplexing, but bear with us—we’ll go into more detail in just a bit:
•••Currying is transforming an m-ary function (that is, a function of arity m) into a sequence of
m unary functions, each receiving one argument of the original function, from left to right.
(The first function receives the first argument of the original function and returns a second
function, which receives the second argument and returns a third function, which receives the
third argument, and so on.) Upon being called with an argument, each function produces the
next one in the sequence, and the last one does the actual calculations.
Partial application is providing n arguments to an m-ary function, with n less than or equal to m,
to transform it into a function with (m-n) parameters. Each time you provide some arguments,
a new function is produced, with smaller arity. When you provide the last arguments, the actual
calculations are performed.
Partial currying is a mixture of both preceding ideas: you provide n arguments (from left to
right) to an m-ary function and produce a new function of arity (m-n). When this new function
receives some other arguments, also from left to right, it will produce yet another function.
When the last parameters are provided, the function produces the correct calculations.
In this chapter, we will see these three transformations, what they require, and ways of implementing them.
and providing some short definitions, which we will expand on later. (If you feel your eyes are glazing
over, please skip this section and return to it later!) Yes, you may find the following descriptions a bit
perplexing, but bear with us—we’ll go into more detail in just a bit:
•••Currying is transforming an m-ary function (that is, a function of arity m) into a sequence of
m unary functions, each receiving one argument of the original function, from left to right.
(The first function receives the first argument of the original function and returns a second
function, which receives the second argument and returns a third function, which receives the
third argument, and so on.) Upon being called with an argument, each function produces the
next one in the sequence, and the last one does the actual calculations.
Partial application is providing n arguments to an m-ary function, with n less than or equal to m,
to transform it into a function with (m-n) parameters. Each time you provide some arguments,
a new function is produced, with smaller arity. When you provide the last arguments, the actual
calculations are performed.
Partial currying is a mixture of both preceding ideas: you provide n arguments (from left to
right) to an m-ary function and produce a new function of arity (m-n). When this new function
receives some other arguments, also from left to right, it will produce yet another function.
When the last parameters are provided, the function produces the correct calculations.
In this chapter, we will see these three transformations, what they require, and ways of implementing them''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search and Highlight Example'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: _searchAndHighlight,
                ),
              ),
              onSubmitted: (_) => _searchAndHighlight(),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Container(
                key: _textKey,
                padding: const EdgeInsets.all(16.0),
                child: _buildHighlightedText(),
              ),
            ),
          ),
          if (_matches.isNotEmpty)
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _matches.length,
                itemBuilder: (context, index) {
                  return ElevatedButton(
                    onPressed: () => _scrollToMatch(index),
                    child: Text('Match ${index + 1}'),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildHighlightedText() {
    if (_searchController.text.isEmpty || _matches.isEmpty) {
      return Text(_textContent);
    }

    List<TextSpan> spans = [];
    int lastMatchEnd = 0;

    for (MatchInfo match in _matches) {
      if (lastMatchEnd < match.start) {
        spans.add(TextSpan(
          text: _textContent.substring(lastMatchEnd, match.start),
          style: TextStyle(color: Colors.black),
        ));
      }
      spans.add(TextSpan(
        text: _textContent.substring(match.start, match.end),
        style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
      ));
      lastMatchEnd = match.end;
    }

    spans.add(TextSpan(
      text: _textContent.substring(lastMatchEnd),
      style: TextStyle(color: Colors.black),
    ));

    return RichText(
      text: TextSpan(
        children: spans,
        style: TextStyle(fontSize: 16.0),
      ),
    );
  }
}

class MatchInfo {
  final int start;
  final int end;
  final double offset;

  MatchInfo(this.start, this.end, this.offset);
}



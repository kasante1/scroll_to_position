import 'package:flutter/material.dart';
import 'dart:async';

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
  var index = 0;

  Timer? _debounce;

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), _searchAndHighlight);
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

        double cumulativeHeight = 0.0;

        _matches = regExpMatches.map((match) {

          final textBeforeMatch = text.substring(0, match.start);

          final textPainter = TextPainter(
            text: TextSpan(text: textBeforeMatch),
            textDirection: TextDirection.ltr,
          )..layout(maxWidth: textBox.size.width);
          
          cumulativeHeight += textPainter.height;

          // final offset = cumulativeHeight.clamp(0.0, totalHeight - textBox.size.height);
          final offset = textPainter.height;
          return MatchInfo(match.start, match.end, offset);

        }).toList();
      }
    });
  }

  void _scrollToMatch() {
    if (_matches.isNotEmpty && index < _matches.length) {
      final match = _matches[index];
        
      _scrollController.animateTo(
        match.offset,
        duration: const Duration(milliseconds: 30),
        curve: Curves.easeInOut,
      );

    }
  }

    void _scrollToNext() {
    if (_matches.isNotEmpty && index < _matches.length) {
      final match = _matches[index];
      print('next matched queries, ${match.offset}');

      _scrollController.animateTo(
        match.offset,
        duration: const Duration(milliseconds: 30),
        curve: Curves.easeInOut,
      );
      index++;
    }
  }

      void _scrollToPrev() {
    if (_matches.isNotEmpty && index != 0) {
      index--;
      final match = _matches[index];
      print('prev matched queries, ${match.offset}');


      _scrollController.animateTo(
        match.offset,
        duration: const Duration(milliseconds: 30),
        curve: Curves.easeInOut,
      );

    }
  }

  String get _textContent => '''An interface is something really simple but powerful. It's usually defined as a contract
between the objects that implements it but this explanation isn't clear enough in my honest
opinion for newcomers to interface world.
A water-pipe is a contract too; whatever you pass through it must be a liquid. Anyone can
use the pipe, and the pipe will transport whatever liquid you put in it (without knowing the
content). The water-pipe is the Interface that enforces that the users must pass liquids (and
not something else).
Lets think in another example: a train. The railroads of a train are like an interface. A train
must construct (implement) its width with a specified value so that it can enter the railroad
but the railroad never knows exactly what's carrying (passengers or cargo). So for example
an interface of the railroad will have the following aspect:
Debugging pipelines
Now, let’s turn to a practical question: how do you debug your code? With pipelining, you can’t see
what’s passed on from function to function, so how do you do it? We have two answers for that: one
(also) comes from the Unix/Linux world, and the other (the most appropriate for this book) uses
wrappers to provide some logs.
Using tee
The first solution we’ll use implies adding a function to the pipeline, which will just log its input. We
want to implement something similar to the tee Linux command, which can intercept the standard
data flow in a pipeline and send a copy to an alternate file or device. Remembering that /dev/tty
is the usual console, we could execute something similar to the following and get an onscreen copy
of everything that passes using the tee command:
Debugging pipelines
Now, let’s turn to a practical question: how do you debug your code? With pipelining, you can’t see
what’s passed on from function to function, so how do you do it? We have two answers for that: one
(also) comes from the Unix/Linux world, and the other (the most appropriate for this book) uses
wrappers to provide some logs.
Using tee
The first solution we’ll use implies adding a function to the pipeline, which will just log its input. We
want to implement something similar to the tee Linux command, which can intercept the standard
data flow in a pipeline and send a copy to an alternate file or device. Remembering that /dev/tty
is the usual console, we could execute something similar to the following and get an onscreen copy
of everything that passes using the tee command:
constructed by ManufacturingDirector.
type BikeBuilder struct {
v VehicleProduct
}
func (b *BikeBuilder) SetWheels() BuildProcess {
b.v.Wheels = 2
return b
}
func (b *BikeBuilder) SetSeats() BuildProcess {
b.v.Seats = 2
return b
}
func (b *BikeBuilder) SetStructure() BuildProcess {
b.v.Structure = "Motorbike"
return b
}
func (b *BikeBuilder) GetVehicle() VehicleProduct {
return b.v
}
The Motorbike Builder is the same as the car builder. We defined a motorbike to have two
wheels, two seats, and a structure called Motorbike. It's very similar to the car object, but
imagine that you want to differentiate between a sports motorbike (with only one seat) and
a cruise motorbike (with two seats). You could simply create a new structure for sport
motorbikes that implements the build process.
You can see that it's a repetitive pattern, but within the scope of every method of the
BuildProcess interface, you could encapsulate as much complexity as you want such that
the user need not know the details about the object creation.
With the definition of all objects, lets run the tests again:
=== RUN
 TestBuilderPattern
--- PASS: TestBuilderPattern (0.00s)
PASS
ok _/home/mcastro/pers/go-design-patterns/creational 0.001s
Well done! Think how easy it could be to add new vehicles to the
ManufacturingDirector director just create a new class encapsulating the data for the
new vehicle. For example, let ́s add a BusBuilder struct:
type BusBuilder struct {
''';

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
              onChanged: (_) => _onSearchChanged(),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
               searchNavigationButton(()=>_scrollToPrev(), 'Previous'),
               sized
               searchNavigationButton(()=>_scrollToNext(), 'Next')

              ],
            )
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

ElevatedButton searchNavigationButton(void Function() onPressed, String buttonLabel) {
  return ElevatedButton(
    onPressed: onPressed,
    child: Text(buttonLabel),
  );
}

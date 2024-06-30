import 'package:flutter/material.dart';
import 'package:share/share.dart'; // Import the share package
import 'joke_service.dart';

class JokePage extends StatefulWidget {
  @override
  _JokePageState createState() => _JokePageState();
}

class _JokePageState extends State<JokePage> {
  final JokeService _jokeService = JokeService();
  String _setup = '';
  String _punchline = '';
  bool _isLoading = false;
  bool _showPunchline = false;

  @override
  void initState() {
    super.initState();
    _fetchJoke();
  }

  Future<void> _fetchJoke() async {
    setState(() {
      _isLoading = true;
      _showPunchline = false;
    });

    try {
      final joke = await _jokeService.getJoke();
      setState(() {
        _setup = joke['setup']!;
        _punchline = joke['punchline']!;
      });
    } catch (e) {
      setState(() {
        _setup = 'Failed to load joke';
        _punchline = '';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _togglePunchline() {
    setState(() {
      _showPunchline = !_showPunchline;
    });
  }

  void _shareJoke() {
    final String jokeText = '$_setup\n\n$_punchline';
    Share.share(jokeText);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daddy Jokes'),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: _togglePunchline,
        child: Center(
          child: _isLoading
              ? const CircularProgressIndicator()
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _showPunchline ? _punchline : _setup,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 24),
                      ),
                      if (!_showPunchline)
                        IconButton(
                          icon: const Text('👊🏻',
                              style: TextStyle(fontSize: 30)),
                          onPressed: _togglePunchline,
                        ),
                    ],
                  ),
                ),
        ),
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        color: Theme.of(context).primaryColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: _fetchJoke,
              child: const Text(
                'Next',
                style: TextStyle(color: Colors.white, fontSize: 18.0),
              ),
            ),
            if (_showPunchline)
              TextButton(
                onPressed: _shareJoke,
                child: const Text(
                  'Share',
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

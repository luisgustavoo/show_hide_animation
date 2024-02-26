import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double _height = 100;
  double _width = 100;
  double _bottom = 0;
  double _opacity = 1;
  Size? _size;
  bool isHide = false;

  String _textButton = 'Hide';

  void _hideContainer() {
    setState(() {
      _height = 0;
      _width = 0;
      _textButton = 'Show';
      _bottom = -100;
      isHide = !isHide;
      _opacity = 0;
    });
  }

  void _showContainer() {
    setState(() {
      _height = 100;
      _width = 100;
      _textButton = 'Hide';
      _bottom = (_size?.height ?? 0) / 2;
      isHide = !isHide;
      _opacity = 1;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        _size = MediaQuery.sizeOf(context);
        _bottom = (_size?.height ?? 0) / 2;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: SizedBox(
        height: _size?.height ?? 0,
        width: _size?.width ?? 0,
        child: Stack(
          alignment: Alignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  if (isHide) {
                    _showContainer();
                  } else {
                    _hideContainer();
                  }
                });
              },
              child: Text(_textButton),
            ),
            AnimatedPositioned(
              left: ((_size?.width ?? 0) / 2) - (_width / 2),
              bottom: _bottom,
              duration: const Duration(milliseconds: 500),
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 500),
                opacity: _opacity,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  color: Colors.red,
                  height: _height,
                  width: _width,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_scan_test/image_view.dart';

class Scanner extends StatefulWidget {
  const Scanner({super.key});

  @override
  State<Scanner> createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  MobileScannerController cameraController = MobileScannerController();
  final _debouncer = Debouncer(milliseconds: 500);
  var found = false;
  Map<String, List<Offset>> mapOffsetWithImage = {};
  List<List<Offset>> listOfOffset = [];
  List<String> listOfString = [];
  Uint8List? imageD;
  Timer? _timer;

  void showSnackbar(String data) {
    var snackBar = SnackBar(
      content: Text('Yay! QR!= $data'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  void initState() {
    // To fix on start error
    cameraController.stop();
    _startTimer();
    super.initState();
  }

  void _startTimer() {
    const duration = Duration(seconds: 2);
    _timer = Timer.periodic(duration, (Timer timer) {
      // Function to be executed every 5 seconds
      _myFunction();
    });
  }

  void _myFunction() {
    // Perform your task here
    mapOffsetWithImage.clear();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double screenWidth = screenSize.width;
    double screenHeight = screenSize.height;
    return Scaffold(
      appBar: AppBar(title: const Text('Mobile Scanner')),
      body: Stack(
        children: [
          SizedBox(
            height: screenHeight - 200,
            width: screenWidth,
            child: MobileScanner(
              fit: BoxFit.cover,
              controller: MobileScannerController(
                // facing: CameraFacing.back,
                // torchEnabled: false,
                detectionSpeed: DetectionSpeed.normal,
                returnImage: false,
              ),
              onDetect: (capture) {
                final List<Barcode> barcodes = capture.barcodes;
              
                final Uint8List? image = capture.image;
                for (final barcode in barcodes) {
                  if (barcode.corners != null && barcode.rawValue != null) {
                    mapOffsetWithImage[barcode.rawValue!] = barcode.corners!;
                    setState(() {
                      found = true;
                    });
                  }
                  debugPrint("Type found bardode : ${barcode.displayValue}");
                  // debugPrint('list of offset lengeth! ${listOfOffset.length}');

                  // debugPrint('Barcode found! ${barcode.corners}');
                }
              },
            ),
          ),
          for (var i in mapOffsetWithImage.values.toList())
            Positioned(
              top: i.first.dy -40,
              left: i.first.dx - 70,
              child: GestureDetector(
                  onTap: () {
                    debugPrint("Tapped area");
                    String valueData = mapOffsetWithImage.entries
                        .firstWhere((entry) => entry.value == i)
                        .key;
                    showSnackbar(valueData);
                  },
                  child: Builder(
                    builder: (context) {
                      var height = (i[0].dy-i[2].dy).abs()-20;
                      var width = (i[0].dx - i[1].dx).abs()-20;
                      if(width< 10){
                        width = 20;
                      }
                      if(height< 10){
                        height   = 20;
                      }
                      debugPrint("the height and width : $width,   $height");
                      return Container(
                        margin: const EdgeInsets.all(15.0),
                        padding: const EdgeInsets.all(3.0),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.red,width: 2)),
                            height: height,
                            width: width,
                      );
                    }
                  )
                  // CustomPaint(
                  //   painter: RectPainter(i, Size.infinite, 1, 1),
                  //   child: Container()
                  // ),
                  ),
            ),
        ],
      ),
    );
  }
}

class Debouncer {
  final int milliseconds;
  Timer? _timer;
  Debouncer({required this.milliseconds});
  void run(VoidCallback action) {
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}

import 'package:event_tracker/screens/models.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRScannerScreen extends StatefulWidget {
  final Function(String) onScan;

  const QRScannerScreen({super.key, required this.onScan});

  @override
  // ignore: library_private_types_in_public_api
  _QRScannerScreenState createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Map<String, int> mealCount = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
              overlay: QrScannerOverlayShape(
                borderColor: Colors.red,
                borderRadius: 10,
                borderLength: 30,
                borderWidth: 10,
                cutOutSize: 300,
                overlayColor: Colors.grey.withOpacity(0.5),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      if (scanData.code == null) {
        return;
      }
      String? mealName = scanData.code;
      int currentCount = await loadMealCount(mealName!);
      int updatedCount = currentCount + 1;
      await saveMealCount(mealName, updatedCount);

      setState(() {
        result = scanData;
        mealCount[mealName] = updatedCount;
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}

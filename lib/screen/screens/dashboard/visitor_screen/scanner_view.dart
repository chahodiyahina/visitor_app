import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrScannerPage extends StatelessWidget {
  const QrScannerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scan QR Code')),
      body: MobileScanner(
        controller: MobileScannerController(
          detectionSpeed: DetectionSpeed.noDuplicates,
        ),
        onDetect: (barcodeCapture) {
          final String? code = barcodeCapture.barcodes.first.rawValue;
          if (code != null) {
            debugPrint('QR Code: $code');

            // Stop scanner after detection
            Navigator.pop(context, code);
          }
        },
      ),
    );
  }
}

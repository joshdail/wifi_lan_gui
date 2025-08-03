import 'package:flutter/material.dart';
import '../models/device.dart';
import '../services/scanner_service.dart';
import '../ui/constants.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
} // ScanScreen

class _ScanScreenState extends State<ScanScreen> {
  final _scanner = ScannerService();
  List<Device> _devices = [];
  int _deviceCount = 0;
  bool _loading = false;
  String? _error;

  void _runScan() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final devices = await _scanner.scanNetwork();
      setState(() {
        _devices = devices;
        _deviceCount = devices.length;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  } // _runScan

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(UIConstants.appTitle)),
      body: Padding(
        padding: const EdgeInsets.all(UIConstants.screenPadding),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: _loading ? null : _runScan,
              child: _loading
                  ? const CircularProgressIndicator()
                  : const Text(UIConstants.scanButton),
            ),
            const SizedBox(height: UIConstants.height),
            if (_error != null)
              SelectableText(_error!, style: UIConstants.errorTextStyle),
            SelectableText('Devices found: $_deviceCount'),
            const SizedBox(height: UIConstants.height),
            Expanded(
              child: ListView.builder(
                itemCount: _devices.length,
                itemBuilder: (context, index) {
                  final d = _devices[index];
                  return ListTile(
                    title: SelectableText('${d.hostname ?? d.ip} (${d.mac})'),
                    subtitle: SelectableText(
                      d.vendor ?? UIConstants.unknownVendor,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    ); // Scaffold
  } // build
} // _scanScreenState

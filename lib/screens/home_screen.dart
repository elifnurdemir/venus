import 'package:flutter/material.dart';
import '../services/light_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isPinOn = false;
  bool loading = false;
  String error = '';

  @override
  void initState() {
    super.initState();
    _fetchPinStatus();
  }

  Future<void> _fetchPinStatus() async {
    try {
      final status = await LightService.getPinStatus();
      setState(() {
        isPinOn = status;
      });
    } catch (e) {
      setState(() {
        error = 'Işık durumu alınamadı!';
      });
    }
  }

  Future<void> _togglePin() async {
    setState(() => loading = true);
    try {
      final success = await LightService.togglePin();
      if (success) {
        setState(() => isPinOn = !isPinOn);
      }
    } catch (e) {
      setState(() {
        error = 'Işık değiştirilemedi!';
      });
    } finally {
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sinekkapan Işıkları')),
      body: Center(
        child:
            loading
                ? CircularProgressIndicator()
                : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      isPinOn ? 'Işık açık 🌞' : 'Işık kapalı 🌑',
                      style: TextStyle(fontSize: 24),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _togglePin,
                      child: Text(isPinOn ? 'Işığı Kapat' : 'Işığı Aç'),
                    ),
                    if (error.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Text(error, style: TextStyle(color: Colors.red)),
                      ),
                  ],
                ),
      ),
    );
  }
}

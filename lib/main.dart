import 'package:flutter/material.dart';

void main() {
  runApp(const VpnApp());
}

class VpnApp extends StatelessWidget {
  const VpnApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VPN Сервис',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF08080A),
        primaryColor: const Color(0xFF8B5CF6),
      ),
      home: const AuthScreen(),
    );
  }
}

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController _codeController = TextEditingController();
  String _errorMessage = '';

  void _login() {
    String code = _codeController.text.trim().toUpperCase();
    
    if (code == 'STIMMEVLONE') {
  Navigator.push(context, MaterialPageRoute(builder: (c) => const MainScreen(plan: 'СОЗДАТЕЛЬ', servers: 999)));
} else if (code == 'BASIC') {
    } else if (code == 'PREMIUM') {
      Navigator.push(context, MaterialPageRoute(builder: (c) => const MainScreen(plan: 'Премиум', servers: 65)));
    } else if (code == 'BEST') {
      Navigator.push(context, MaterialPageRoute(builder: (c) => const MainScreen(plan: 'Лучший', servers: 80)));
    } else {
      setState(() {
        _errorMessage = 'Неверный код. Проверьте сообщение от поддержки.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(Icons.security, size: 80, color: Color(0xFF8B5CF6)),
            const SizedBox(height: 30),
            const Text(
              'ВХОД В VPN',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, letterSpacing: 2),
            ),
            const SizedBox(height: 10),
            const Text(
              'Введите код доступа, полученный после оплаты',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 40),
            TextField(
              controller: _codeController,
              decoration: InputDecoration(
                hintText: 'Например: PREMIUM',
                filled: true,
                fillColor: const Color(0xFF121218),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
              ),
              style: const TextStyle(fontSize: 18, letterSpacing: 2),
              textAlign: TextAlign.center,
            ),
            if (_errorMessage.isNotEmpty) ...[
              const SizedBox(height: 15),
              Text(_errorMessage, style: const TextStyle(color: Colors.redAccent), textAlign: TextAlign.center),
            ],
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _login,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF8B5CF6),
                padding: const EdgeInsets.symmetric(vertical: 20),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              ),
              child: const Text('ВОЙТИ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  final String plan;
  final int servers;

  const MainScreen({super.key, required this.plan, required this.servers});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool isConnected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('БЕЗОПАСНЫЙ VPN'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF121218),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFF8B5CF6).withOpacity(0.5)),
              ),
              child: Column(
                children: [
                  const Text('ВАШ ТАРИФ', style: TextStyle(color: Colors.grey, fontSize: 12)),
                  const SizedBox(height: 5),
                  Text(widget.plan, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF8B5CF6))),
                  const Divider(color: Colors.black26, height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Доступно серверов:', style: TextStyle(color: Colors.grey)),
                      Text('${widget.servers}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                setState(() { isConnected = !isConnected; });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isConnected ? const Color(0xFF8B5CF6) : const Color(0xFF121218),
                  border: Border.all(color: const Color(0xFF8B5CF6), width: 4),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF8B5CF6).withOpacity(isConnected ? 0.5 : 0.1),
                      blurRadius: 30,
                      spreadRadius: 10,
                    )
                  ],
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.power_settings_new, size: 60, color: isConnected ? Colors.white : Colors.grey),
                      const SizedBox(height: 10),
                      Text(
                        isConnected ? 'ОТКЛЮЧИТЬ' : 'ПОДКЛЮЧИТЬ',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: isConnected ? Colors.white : Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Spacer(),
            Text(isConnected ? 'Статус: Защищено' : 'Статус: Отключено', style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

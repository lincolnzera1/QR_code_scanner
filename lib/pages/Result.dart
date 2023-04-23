import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:paciente_returns/pages/Home.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class ResultPage extends StatefulWidget {
  final String? link;
  final Function() closeScreen;

  ResultPage({super.key, required this.link, required this.closeScreen});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            widget.closeScreen();
            Navigator.pop(context);
            /* Navigator.push(
                context, MaterialPageRoute(builder: (a) => const Home())); */
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
        ),
        title: const Text(
          "Resultado do escaneamento",
          style: TextStyle(color: Colors.black, fontSize: 15),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /* const Text(
              "Link encontrado:",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ), */
            Image.asset(
              'assets/qrImage.png',
              height: 180,
            ),
            Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Clique no link para abrir: ",
                  style: TextStyle(fontSize: 18),
                ),
                GestureDetector(
                  onTap: () {
                    _launchUrl(widget.link);
                  },
                  child: Text(
                    '${widget.link}',
                    style: const TextStyle(
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {
                Clipboard.setData(ClipboardData(text: widget.link));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    duration: Duration(seconds: 2),
                    backgroundColor: Colors.lightGreen,
                    content: Text('Link copiado!'),
                  ),
                );
              },
              child: const Text('Copiar Link'),
            ),
            TextButton(
              onPressed: () {
                final String textToShare =
                    'Olá, estou compartilhando essa mensagem com você!';
                final String linkToShare = 'https://flutter.dev';

                // Você pode compartilhar texto ou um link
                Share.share(textToShare);
                // Share.share(linkToShare);
              },
              child: Text(
                'Compartilhar',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchUrl(String? urlString) async {
    if (await canLaunch(urlString!)) {
      await launch(
        forceSafariVC: false, // Para iOS
        forceWebView: false, // Para Android
        enableJavaScript: true,
        urlString,
      );
    } else {
      print("Can\'t Launch Url");
    }
  }
}

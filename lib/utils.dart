import 'package:demo/texttospeech.dart';
import 'package:url_launcher/url_launcher.dart';

class Command {
  static final all = [email, youtube, google, browse, greet];
  static final receiptents = [
    "kirankorada02@gmail.com",
    "ginnisandhya1611@gmail.com"
  ];
  static final contacts = ["+919666085546", "+918096189839", "+919515184418"];
  var ind = 0;
  static const greet = "start";
  static const email = 'write email';
  static const youtube = "open youtube";
  static const google = "open google";
  static const browse = "go to";
  static const whatsapp = "whatsapp";
  static const call = "call";
}

class Utils {
  static void read(String raw) {
    final text = raw.toLowerCase();

    if (text.contains(Command.greet)) {
      var time = DateTime.now().hour;
      if (time <= 12) {
        speak("");

        speak("hello i am soniyaa good morning");
      } else if (time > 12 && time < 16) {
        speak("hello i am soniyaa good afternoon");
      } else {
        speak("hello i am soniyaa good evening");
      }
    } else if (text.contains(Command.email)) {
      var content = _getContent(text: text, command: Command.email);
      content = _getContent(text: content, command: "to");

      openEmail(content: content);
    } else if (text.contains(Command.youtube)) {
      final url = _getContent(text: text, command: Command.youtube);
      speak("opening Youtube");

      openYoutube(url: url);
    } else if (text.contains(Command.google)) {
      final url = _getContent(text: text, command: Command.google);
      speak("opening Google");

      openGoogle(url: url);
    } else if (text.contains(Command.browse)) {
      final url = _getContent(text: text, command: Command.browse);
      speak("going to $url");

      openGoogle(url: url + ".com");
    } else if (text.contains(Command.whatsapp)) {
      final url = _getContent(text: text, command: Command.whatsapp);
      speak("opening whatsapp");

      openWhatspp(content: url);
    } else if (text.contains(Command.call)) {
      speak("Calling");
      final url = _getContent(text: text, command: Command.call);
      speak(url);
      speak("calling ${url.substring(0, url.indexOf(" "))}");

      call(content: url);
    }
  }

  static String _getContent({
    required String text,
    required String command,
  }) {
    final incommand = text.indexOf(command);
    final inAfter = incommand + command.length;

    if (incommand == -1) {
      return "null";
    } else {
      return text.substring(inAfter).trim();
    }
  }

  static Future openYoutube({
    required String url,
  }) async {
    if (url.trim().isEmpty) {
      await _launchUrl('https://youtube.com');
    } else {
      await _launchUrl('https://$url');
    }
  }

  static Future openGoogle({
    required String url,
  }) async {
    if (url.trim().isEmpty) {
      await _launchUrl('https://google.com');
    } else {
      await _launchUrl('https://$url');
    }
  }

  static Future openEmail({
    required String content,
  }) async {
    int idx = content.indexOf(" ");

    var to = [
      content.substring(0, idx).trim(),
      content.substring(idx + 1).trim()
    ];
    if (to[0] == "kiran") {
      idx = 0;
    } else if (to[0] == "sandya" || to[0] == "sandhya") {
      idx = 1;
    }
    final url =
        'mailto:${Command.receiptents[idx]}?body=${Uri.encodeFull(to[1])}';
    await _launchUrl(url);
  }

  static Future openWhatspp({
    required String content,
  }) async {
    int idx = content.indexOf(" ");

    var to = [
      content.substring(0, idx).trim(),
      content.substring(idx + 1).trim()
    ];
    if (to[0] == "kiran") {
      idx = 0;
    } else if (to[0] == "sandya" || to[0] == "sandhya") {
      idx = 1;
    }
    final url =
        'https://api.whatsapp.com/send?phone=${Command.contacts[idx]}&text=${to[1]}';
    await _launchUrl(url);
  }

  static Future call({
    required String content,
  }) async {
    int idx = content.indexOf(" ");

    var to = [
      content.substring(0, idx).trim(),
      content.substring(idx + 1).trim()
    ];
    if (to[0] == "kiran") {
      idx = 0;
    } else if (to[0] == "sandya" || to[0] == "sandhya") {
      idx = 1;
    }
    final url = 'tel:${Command.contacts[idx]}';
    await _launchUrl(url);
  }

  static Future _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }
}

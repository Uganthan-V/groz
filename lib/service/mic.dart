

import 'package:flutter/material.dart';

class MicService {
  String? intent;
  String? name;
  String? quantity;
  bool _isListening = false;
  DateTime? _lastInputTime;

  void setListening(bool value) {
    _isListening = value;
  }

  void showVoiceInputDialog(BuildContext context, Function() onItemAdded, VoidCallback onClose) {
    final TextEditingController voiceController = TextEditingController();
    _isListening = true;
    _lastInputTime = DateTime.now();

    showDialog(
      context: context,
      barrierDismissible: false, // Prevent manual dismissal
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            void checkInactivity() {
              if (_isListening && _lastInputTime != null) {
                final inactiveDuration = DateTime.now().difference(_lastInputTime!);
                if (inactiveDuration.inSeconds >= 3) {
                  _isListening = false;
                  onClose();
                  Navigator.of(context).pop();
                }
              }
            }

            // Check inactivity every second
            Future.doWhile(() async {
              await Future.delayed(Duration(seconds: 1));
              checkInactivity();
              return _isListening;
            });

            return AlertDialog(
              title: Text('Voice Input ${_isListening ? '(Listening...)' : ''}'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: voiceController,
                    decoration: InputDecoration(
                      hintText: 'Speak or type your command (e.g., "Add 2 kg apples")',
                    ),
                    onChanged: (value) {
                      _lastInputTime = DateTime.now(); // Reset timer on input
                    },
                  ),
                  if (intent == 'add' && name != null && quantity != null)
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Text('Added: $name - $quantity', style: TextStyle(color: Colors.green)),
                    ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    _isListening = false;
                    onClose();
                    Navigator.of(context).pop();
                  },
                  child: Text('Close'),
                ),
                TextButton(
                  onPressed: () {
                    if (voiceController.text.isNotEmpty) {
                      extractInfo(voiceController.text);
                      if (intent == 'add' && name != null && quantity != null) {
                        onItemAdded();
                        setState(() {}); // Refresh UI to show confirmation
                        _lastInputTime = DateTime.now(); // Reset timer after adding
                      } else {
                        _lastInputTime = DateTime.now(); // Reset timer for invalid input
                      }
                      voiceController.clear(); // Clear for next input
                    }
                  },
                  child: Text('Submit'),
                ),
              ],
            );
          },
        );
      },
    ).then((_) {
      _isListening = false; // Ensure listening stops when dialog is closed
    });
  }

  void extractInfo(String text) {
    String normalizedText = text.replaceAllMapped(
      RegExp(r'\btake\s+(out|away)\b', caseSensitive: false),
      (match) => 'remove',
    );

    String? intentResult;
    if (RegExp(r'\b(add|increase|increas|increseas|put|include|toss)\b', caseSensitive: false).hasMatch(normalizedText)) {
      intentResult = "add";
    } else if (RegExp(r'\b(remove|delete|cut|subtract|decrease|reduce|lower)\b', caseSensitive: false).hasMatch(normalizedText)) {
      intentResult = "remove";
    }

    RegExp quantityRegex = RegExp(
      r'(half\s+a\s+liter|\d+\s*(?:more\s+|additional\s+)?(?:kgs?|kilograms?|grams?|g|l|litres?|liters?|ml|pcs|pieces|items))',
      caseSensitive: false,
    );
    RegExpMatch? quantityMatch = quantityRegex.firstMatch(normalizedText);
    String? quantityResult;
    if (quantityMatch != null) {
      quantityResult = quantityMatch.group(0)?.trim();
      quantityResult = quantityResult?.replaceAll(RegExp(r'\b(more|additional)\b', caseSensitive: false), '');
      quantityResult = quantityResult?.replaceAll(RegExp(r'\s+'), ' ').trim();
    }

    String cleanedText = normalizedText;
    if (quantityMatch != null) {
      cleanedText = cleanedText.replaceFirst(quantityMatch.group(0)!, '');
      cleanedText = cleanedText.replaceAll(RegExp(r'\bof\b', caseSensitive: false), '');
    }

    Set<String> exclude = {
      'add', 'remove', 'of', 'to', 'the', 'list', 'by', 'about', 'please',
      'put', 'pls', 'kindly', 'would', 'like', 'increseas', 'increase',
      'can', 'i', 'you', 'could', 'include', 'some', 'asap', 'in', 'on',
      'more', 'additional', 'toss', 'want', 'my', 'a', 'into', 'from',
      'delete', 'cut', 'subtract', 'decrease', 'reduce', 'lower', 'out',
      'take', 'and', 'just', 'need', 'additionally', 'around', 'shopping',
      'basket', 'quantity', 'top'
    };

    Set<String> knownUnits = {
      'kg', 'kgs', 'kilograms', 'g', 'grams', 'l', 'litres', 'liters',
      'ml', 'pcs', 'pieces', 'items', 'liter', 'piece', 'part'
    };

    List<String> words = RegExp(r'\b\w+\b').allMatches(cleanedText).map((m) => m.group(0)!).toList();

    List<String> nameCandidates = words.where((w) {
      final lw = w.toLowerCase();
      return !exclude.contains(lw) && !knownUnits.contains(lw) && !RegExp(r'^\d+$').hasMatch(w);
    }).toList();

    String? nameResult = nameCandidates.isNotEmpty ? nameCandidates.last : null;

    intent = intentResult;
    name = nameResult;
    quantity = normalizeQuantity(quantityResult);
  }

  String normalizeQuantity(String? q) {
    if (q == null || q.trim().isEmpty) return '';
    q = q.toLowerCase().trim();
    q = q
        .replaceAll('kgs', 'kg')
        .replaceAll('kilograms', 'kg')
        .replaceAll('kilos', 'kg')
        .replaceAll('litres', 'l')
        .replaceAll('liters', 'l')
        .replaceAll('pieces', 'pcs')
        .replaceAll('piece', 'pcs')
        .replaceAll('part', 'pcs')
        .replaceAll('items', 'pcs');

    if (q == 'half a liter') return '500 ml';
    if (q.endsWith('s') && !q.endsWith('pcs')) {
      q = q.substring(0, q.length - 1);
    }
    return q.trim();
  }
}
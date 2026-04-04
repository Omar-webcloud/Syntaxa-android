import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_tts/flutter_tts.dart';

class DictionaryScreen extends StatefulWidget {
  const DictionaryScreen({super.key});

  @override
  State<DictionaryScreen> createState() => _DictionaryScreenState();
}

class _DictionaryScreenState extends State<DictionaryScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _dictionary = [];
  Map<String, dynamic>? _result;
  Map<String, dynamic>? _wordOfDay;
  bool _isLoading = false;
  String? _error;
  
  final AudioPlayer _audioPlayer = AudioPlayer();
  final FlutterTts _flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() => setState(() {}));
    _fetchDictionary();
  }

  Future<void> _fetchDictionary() async {
    setState(() => _isLoading = true);
    try {
      final response = await http.get(Uri.parse("https://raw.githubusercontent.com/MinhasKamal/BengaliDictionary/master/BengaliDictionary.json"));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        _dictionary = data.cast<Map<String, dynamic>>();

        if (_dictionary.isNotEmpty) {
          final randomIndex = Random().nextInt(_dictionary.length);
          setState(() {
            _wordOfDay = _dictionary[randomIndex];
            _error = null;
          });
        }
      } else {
        setState(() => _error = "Failed to fetch dictionary. Status: ${response.statusCode}");
      }
    } catch (e) {
      setState(() => _error = "Could not load dictionary data.\nPlease check your connection.");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _handleSearch() {
    final query = _searchController.text.trim().toLowerCase();
    if (query.isEmpty) {
      setState(() {
        _result = null;
        _error = null;
      });
      return;
    }
    
    // Unfocus keyboard
    FocusScope.of(context).unfocus();

    final found = _dictionary.where((entry) => 
        (entry['en'] ?? '').toString().trim().toLowerCase() == query
    ).toList();

    setState(() {
      if (found.isNotEmpty) {
        _result = found.first;
        _error = null;
      } else {
        _result = null;
        _error = 'No definition found for "$query"';
      }
    });
  }

  Future<void> _playSound(String word) async {
    try {
      final response = await http.get(Uri.parse('https://api.dictionaryapi.dev/api/v2/entries/en/$word'));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        String? audioUrl;
        
        final phonetics = data[0]['phonetics'] as List<dynamic>?;
        if (phonetics != null) {
          for (var p in phonetics) {
            final a = p['audio'];
            if (a != null && a.toString().isNotEmpty) {
              audioUrl = a.toString();
              break;
            }
          }
        }
        
        if (audioUrl != null && audioUrl.isNotEmpty) {
          await _audioPlayer.play(UrlSource(audioUrl));
          return;
        }
      }
    } catch (_) {}

    // Fallback to TTS
    await _flutterTts.setLanguage("en-US");
    await _flutterTts.setSpeechRate(0.5);
    await _flutterTts.speak(word);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _audioPlayer.dispose();
    _flutterTts.stop();
    super.dispose();
  }

  Widget _buildWordCard(Map<String, dynamic> data, {bool isWordOfDay = false}) {
    final String en = data['en'] ?? '';
    final String bn = data['bn'] ?? '';
    final String pron = (data['pron'] != null && data['pron'] is List && data['pron'].isNotEmpty) ? '/${data['pron'][0]}/' : '';
    final List<dynamic>? enSynsRaw = data['en_syns'];
    final List<dynamic>? sentsRaw = data['sents'];
    
    final String synonyms = (enSynsRaw != null && enSynsRaw.isNotEmpty) ? "Synonyms: ${enSynsRaw.take(3).join(', ')}" : "";
    final String sentence = (sentsRaw != null && sentsRaw.isNotEmpty) ? '"${sentsRaw[0]}"' : '';

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 5)),
        ],
        border: isWordOfDay ? Border.all(color: const Color(0xFFEBE4FF), width: 2) : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(en, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: Colors.black87)),
                    if (pron.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(pron, style: const TextStyle(fontSize: 16, color: Color(0xFF9C41BC), fontWeight: FontWeight.w600)),
                    ] else ...[
                      const SizedBox(height: 4),
                      Text("/$en/", style: const TextStyle(fontSize: 16, color: Color(0xFF9C41BC), fontWeight: FontWeight.w600)),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Text(bn, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF8A56A4))),
            ],
          ),
          if (synonyms.isNotEmpty) ...[
            const SizedBox(height: 16),
            Text(synonyms, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87)),
          ],
          if (sentence.isNotEmpty) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.only(left: 12),
              decoration: const BoxDecoration(
                border: Border(left: BorderSide(color: Color(0xFFEBE4FF), width: 4)),
              ),
              child: Text(sentence, style: const TextStyle(fontSize: 14, color: Colors.black54, fontStyle: FontStyle.italic, fontWeight: FontWeight.w500, height: 1.5)),
            ),
          ] else ...[
            const SizedBox(height: 16),
            const Text("No example sentences available.", style: TextStyle(fontSize: 14, color: Colors.black38)),
          ],
          const SizedBox(height: 32),
          GestureDetector(
            onTap: () => _playSound(en),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: isWordOfDay ? Colors.white : const Color(0xFF8A56A4),
                border: isWordOfDay ? Border.all(color: const Color(0xFFEBE4FF), width: 2) : null,
                borderRadius: BorderRadius.circular(16),
                boxShadow: isWordOfDay ? null : [
                  BoxShadow(color: const Color(0xFF8A56A4).withValues(alpha: 0.3), blurRadius: 10, offset: const Offset(0, 4)),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.volume_up_outlined, color: isWordOfDay ? Colors.black87 : Colors.white),
                  const SizedBox(width: 8),
                  Text('Listen Pronunciation', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: isWordOfDay ? Colors.black87 : Colors.white)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F0F6),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Dictionary', style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 32, color: Colors.black)),
              const SizedBox(height: 4),
              const Text('From English to Bangla', style: TextStyle(fontSize: 16, color: Colors.black54, fontWeight: FontWeight.w600)),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: Colors.transparent),
                        boxShadow: [
                          BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 5)),
                        ],
                      ),
                      child: TextField(
                        controller: _searchController,
                        onSubmitted: (_) => _handleSearch(),
                        decoration: InputDecoration(
                          hintText: 'Search an English word...',
                          border: InputBorder.none,
                          hintStyle: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
                          prefixIcon: const Icon(Icons.search, color: Colors.grey),
                          suffixIcon: _searchController.text.isNotEmpty ? IconButton(
                            icon: const Icon(Icons.close, color: Colors.grey),
                            onPressed: () {
                              _searchController.clear();
                              setState(() {
                                _result = null;
                                _error = null;
                              });
                            },
                          ) : null,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  GestureDetector(
                    onTap: _isLoading ? null : _handleSearch,
                    child: Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: const Color(0xFF8A56A4),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(color: const Color(0xFF8A56A4).withValues(alpha: 0.4), blurRadius: 10, offset: const Offset(0, 4)),
                        ],
                      ),
                      child: _isLoading 
                          ? const Center(child: SizedBox(width: 24, height: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)))
                          : const Icon(Icons.search, color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              if (_error != null)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.only(bottom: 24),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(_error!, style: TextStyle(color: Colors.red.shade700, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                ),

              if (_result != null)
                _buildWordCard(_result!),

              if (_result == null && _wordOfDay != null) ...[
                const Text('Word of The Day', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
                const SizedBox(height: 16),
                _buildWordCard(_wordOfDay!, isWordOfDay: true),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

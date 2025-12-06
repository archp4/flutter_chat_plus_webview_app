import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_app/models/message_bubble.dart';

// Keys for SharedPreferences
const String _kMessageKey = 'chat_messages';
const String _kPersistenceKey = 'chat_persistence_enabled';

class MessageStorageService {
  late final SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  bool getPersistenceEnabled() {
    return _prefs.getBool(_kPersistenceKey) ?? true;
  }

  Future<void> setPersistenceEnabled(bool value) async {
    await _prefs.setBool(_kPersistenceKey, value);
  }

  Future<List<MessageBubble>> loadMessages() async {
    final List<String>? messageJsonStrings = _prefs.getStringList(_kMessageKey);
    final List<MessageBubble> loadedMessages = [];

    if (messageJsonStrings != null) {
      for (var jsonString in messageJsonStrings) {
        try {
          final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
          loadedMessages.add(MessageBubble.fromJson(jsonMap));
        } catch (e) {
          debugPrint('Error decoding message: $e');
        }
      }
    }

    loadedMessages.sort();
    return loadedMessages;
  }

  Future<void> saveMessages(List<MessageBubble> messages) async {
    final List<String> messageJsonStrings =
        messages.map((m) {
          return jsonEncode(m.toJson());
        }).toList();

    await _prefs.setStringList(_kMessageKey, messageJsonStrings);
  }
}

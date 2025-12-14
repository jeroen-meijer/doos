<!-- omit in toc -->
# 📦 Doos

> /doːs/ ("dose")

**A type-safe local storage library for Dart and Flutter apps with reactive change streams.**

Doos provides an unopinionated type-safe API for storing and retrieving data locally. Values are automatically serialized to JSON and stored via a configurable storage adapter. Entries expose reactive streams that emit whenever values change.

- [🚀 Getting started](#-getting-started)
- [🔧 How it works](#-how-it-works)
- [⚙️ Storage adapters](#️-storage-adapters)

## 🚀 Getting started

```dart
import 'dart:io';
import 'package:doos/doos.dart';

// Create a storage adapter (e.g., JSON file-based)
final adapter = await DoosJsonStorageAdapter.create(
  file: File('storage.json'),
);

// Create a Doos instance
final doos = Doos(adapter: adapter);

// Get a typed entry
final entry = doos.getEntry<String>('username');

// Read a value
final result = await entry.readOrNull();
switch (result) {
  case DoosOk(value: final username):
    print('Username: $username');
  case DoosErr(error: final error):
    print('Error: $error');
}

// Write a value
await entry.write('johndoe');

// Listen to changes
entry.onChange().listen((username) {
  print('Username changed to: $username');
});

// Clean up
await entry.dispose();
await doos.dispose();
```

## 🔧 How it works

Doos uses a storage adapter pattern to abstract the underlying storage mechanism. Values are serialized to JSON before storage and deserialized on read. Each entry maintains a reactive stream (using RxDart's `BehaviorSubject`) that emits whenever the value changes, enabling reactive programming patterns.

Supported JSON types (`String`, `int`, `double`, `bool`, `List`, `Map`, `null`) work out of the box. Custom types require a deserializer function.

## ⚙️ Storage adapters

Storage adapters implement the `DoosStorageAdapter` mixin, which defines four methods:
- `write(key, value)` - Store a string value
- `read(key)` - Retrieve a string value
- `delete(key)` - Remove a key
- `clear()` - Remove all keys

The included `DoosJsonStorageAdapter` stores data in a JSON file with an in-memory cache. You can implement custom adapters for other backends (e.g., SharedPreferences, SQLite, secure storage).

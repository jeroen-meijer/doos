// ignore_for_file: avoid_print

import 'dart:io';

import 'package:doos/doos.dart';

Future<void> main() async {
  // Create a JSON file-based storage adapter
  final adapter = await DoosJsonStorageAdapter.create(
    file: File('example_storage.json'),
  );

  // Create a Doos instance
  final doos = Doos(adapter: adapter);

  // Example 1: Basic read/write operations
  print('=== Example 1: Basic operations ===');
  final usernameEntry = doos.getEntry<String>('username');

  // Write a value
  final writeResult = await usernameEntry.write('johndoe');
  switch (writeResult) {
    case DoosOk():
      print('✓ Username written successfully');
    case DoosErr(error: final error):
      print('✗ Error writing username: $error');
  }

  // Read the value
  final readResult = await usernameEntry.readOrNull();
  switch (readResult) {
    case DoosOk(value: final username):
      print('✓ Username: $username');
    case DoosErr(error: final error):
      print('✗ Error reading username: $error');
  }

  // Example 2: Reactive change streams
  print('\n=== Example 2: Change streams ===');
  final counterEntry = doos.getEntry<int>('counter');

  // Set initial value
  await counterEntry.write(0);

  // Listen to changes
  final subscription = counterEntry.onChange().listen((value) {
    print('Counter changed to: $value');
  });

  // Update the value multiple times
  await counterEntry.write(1);
  await counterEntry.write(2);
  await counterEntry.write(3);

  // Wait a bit for stream emissions
  await Future<void>.delayed(const Duration(milliseconds: 100));
  await subscription.cancel();

  // Example 3: Complex types
  print('\n=== Example 3: Complex types ===');
  final settingsEntry = doos.getEntry<Map<String, dynamic>>('settings');

  await settingsEntry.write({
    'theme': 'dark',
    'notifications': true,
    'language': 'en',
  });

  final settingsResult = await settingsEntry.readOrNull();
  switch (settingsResult) {
    case DoosOk(value: final settings):
      print('✓ Settings: $settings');
    case DoosErr(error: final error):
      print('✗ Error reading settings: $error');
  }

  // Example 4: Conditional writes
  print('\n=== Example 4: Conditional writes ===');
  final tokenEntry = doos.getEntry<String>('api_token');

  // Write only if absent
  final writeIfAbsentResult = await tokenEntry.writeIfAbsent('secret_token');
  switch (writeIfAbsentResult) {
    case DoosOk(value: final written):
      print('✓ Token written: $written');
    case DoosErr(error: final error):
      print('✗ Error: $error');
  }

  // Try again (should not write)
  final writeIfAbsentResult2 = await tokenEntry.writeIfAbsent('another_token');
  switch (writeIfAbsentResult2) {
    case DoosOk(value: final written):
      print('✓ Token written: $written');
    case DoosErr(error: final error):
      print('✗ Error: $error');
  }

  // Example 5: Error handling
  print('\n=== Example 5: Error handling ===');
  final missingEntry = doos.getEntry<String>('nonexistent_key');

  final missingResult = await missingEntry.read();
  switch (missingResult) {
    case DoosOk(value: final value):
      print('✓ Value: $value');
    case DoosErr(error: final error):
      print('✗ Expected error: $error');
  }

  // Example 6: Remove operations
  print('\n=== Example 6: Remove operations ===');
  final removeResult = await usernameEntry.remove();
  switch (removeResult) {
    case DoosOk(value: final removed):
      print('✓ Key removed: $removed');
    case DoosErr(error: final error):
      print('✗ Error removing key: $error');
  }

  // Verify it's gone
  final verifyResult = await usernameEntry.readOrNull();
  switch (verifyResult) {
    case DoosOk(value: final value):
      print('Value after remove: $value');
    case DoosErr(error: final error):
      print('✗ Error: $error');
  }

  // Clean up
  await usernameEntry.dispose();
  await counterEntry.dispose();
  await settingsEntry.dispose();
  await tokenEntry.dispose();
  await missingEntry.dispose();
  await doos.dispose();

  print('\n=== Done ===');
}

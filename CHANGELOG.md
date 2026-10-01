## Upcoming

- docs: require every PR to update Upcoming; prefer end-user wording when the change is visible, and write what the UI does instead of soft wrappers

- chore: import tests and the JSON adapter through the package:doos/doos.dart barrel

## 0.0.1

- Initial release of Doos:
  - Type-safe storage API with reactive change streams
  - JSON storage adapter with file-based persistence
  - Support for JSON-serializable types (String, int, double, bool, List, Map, null)
  - Custom type support with deserializer functions
  - Result-based error handling with `DoosResult` type

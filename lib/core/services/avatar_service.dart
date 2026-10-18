import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../utils/platform_support.dart';

/// Picks the profile photo and keeps a private copy inside app storage.
///
/// The picked image is downscaled and copied into the documents directory so
/// the profile survives app restarts without depending on the gallery.
class AvatarService {
  /// Creates the avatar service.
  const AvatarService();

  static const String _folder = 'profile';
  static const String _fileName = 'avatar.jpg';

  /// Opens [source] and stores a downscaled copy, returning its absolute path.
  ///
  /// Returns `null` when the user cancels or the platform has no picker.
  Future<String?> pick(ImageSource source) async {
    if (!PlatformSupport.avatarPicker) return null;
    try {
      final picked = await ImagePicker().pickImage(
        source: source,
        maxWidth: 512,
        maxHeight: 512,
        imageQuality: 85,
      );
      if (picked == null) return null;
      final documents = await getApplicationDocumentsDirectory();
      final folder = Directory('${documents.path}/$_folder');
      await folder.create(recursive: true);
      final saved = await File(picked.path).copy('${folder.path}/$_fileName');
      return saved.path;
    } on Object {
      return null;
    }
  }

  /// Deletes the stored copy, if any.
  Future<void> remove(String? path) async {
    if (path == null) return;
    final file = File(path);
    if (await file.exists()) {
      await file.delete();
    }
  }
}

package utils;

import sys.FileSystem;

class FileSystemExt {
  public static function deleteDirectoryContents(path: String): Void {
    if (FileSystem.exists(path) && FileSystem.isDirectory(path)) {
      var entries = FileSystem.readDirectory(path);

      for (entry in entries) {
        var entryPath = '${path}/${entry}';

        if (FileSystem.isDirectory(entryPath)) {
          deleteDirectoryContents(entryPath);
          FileSystem.deleteDirectory(entryPath);
        } else {
          try {
            FileSystem.deleteFile(entryPath);
          } catch (error) {
            // hacky way to avoid some exception with deleting files with utest
            // Method is only used for teardown, so its ok I guess :shrugs:
          }
        }
      }
    }
  }
}

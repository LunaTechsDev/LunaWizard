package wizard.utils;

import sys.FileSystem;
import js.node.Path;

using Lambda;

class HxmlDiscovery {
  public static function walk(path: String, ?onFile: String->Void, ?onDirectory: String->Void): Array<String> {
    var result: Array<String> = [];
    var nodes: Array<String> = FileSystem.readDirectory(path);
    var ignoreList = ['node_modules', '.git', 'haxe_libraries', '.github'];

    while (nodes.length > 0) {
      var node = nodes.shift();

      if (ignoreList.contains(node)) {
        continue;
      }

      result.push(Path.resolve(path, node));

      if (FileSystem.isDirectory(node)) {
        if (onDirectory != null) {
          onDirectory(Path.resolve(path, node));
        }
        nodes = nodes.concat(walk(node));
      } else if (onFile != null) {
        onFile(Path.resolve(path, node));
      }
    }
    return result;
  }

  public static function discover(): Array<String> {
    var discovered: Array<String> = [];

    function onFile(path) {
      var ereg = new EReg('.hxml', 'g');
      if (ereg.match(path)) {
        discovered.push(path);
      }
    }

    walk(Sys.getCwd(), onFile);

    return discovered;
  }
}
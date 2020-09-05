package wizard;

import haxe.Json;
import js.node.Path;
import sys.io.File;
import sys.FileSystem;

class Builder {
  public static var path: String = Sys.getCwd();
  public static var programDir = Path.dirname(Sys.programPath());
  private static var _scaffoldDir = '${Path.dirname(programDir)}/scaffold'; 

  public static function newProject(?path: String) {
    if (path != null && path != '') {
      Sys.setCwd(Path.resolve(path));
    }

    addSrcDirectory(Sys.getCwd());
    addGamesDirectory(Sys.getCwd());
    addCheckstyleJson(Sys.getCwd());
    addHaxeFormatJson(Sys.getCwd());
  }

  public static function addSrcDirectory(path: String) {
    if (!FileSystem.exists('${path}/src')) {
      FileSystem.createDirectory('${path}/src');
    }
  }

  public static function addGamesDirectory(path: String) {
    if (!FileSystem.exists('${path}/games')) {
      FileSystem.createDirectory('${path}/games');
      FileSystem.createDirectory('${path}/games/mv');
      FileSystem.createDirectory('${path}/games/mz');
    }
  }

  public static function addCheckstyleJson(path: String) {
    if (!FileSystem.exists('${path}/checkstyle.json')) {
      var jsonPath = '${_scaffoldDir}/checkstyle.json';
      var fileData: String = File.getContent(jsonPath).toString();

      File.write('${path}/checkstyle.json', Json.parse(fileData));
    }
  }

  public static function addHaxeFormatJson(path: String) {
    if (!FileSystem.exists('${path}/hxformat.json')) {
      var jsonPath = '${_scaffoldDir}/hxformat.json';
      var fileData: String = File.getContent(jsonPath).toString();

      File.write('${path}/hxformat.json', Json.parse(fileData));
    }
  }

  public static function installLix(path: String) {
    NodePackage.install('lix');
  }
}

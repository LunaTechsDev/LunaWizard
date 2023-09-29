package wizard.js;

import js.node.Path;
import sys.io.File;
import sys.FileSystem;
import napkin.Napkin;
import wizard.utils.Logger;

using StringTools;

class Builder {
  private static var _log: Logger = new Logger();
  public static var path: String = Sys.getCwd();
  public static var programDir = Path.dirname(Sys.programPath());
  private static var _scaffoldDir = '${Path.dirname(programDir)}/scaffold/js/';

  public static function newProject(?path: String, compatability: Bool) {
    if (path != null && path != '') {
      Sys.setCwd(Path.resolve(path));
    }

    addSrcDirectory(Sys.getCwd());
    addFile(Sys.getCwd(), 'main');
    addFile(Sys.getCwd(), 'Params');
    addGamesDirectory(Sys.getCwd(), compatability);
    _log.info('Static project files successfully created');
  }

  public static function addSrcDirectory(path: String) {
    if (!FileSystem.exists('${path}/src')) {
      FileSystem.createDirectory('${path}/src');
    }
  }

  public static function addFile(path: String, filename: String) {
    var filePath = '${path}/src/${filename}.js';
    if (!FileSystem.exists(filePath)) {
      var mainPath = '${_scaffoldDir}/${filename}.js';
      var fileData: String = File.getContent(mainPath);
      File.saveContent(filePath, fileData);
    }
  }

  public static function addGamesDirectory(path: String, compatability: Bool) {
    if (!compatability) {
      FileSystem.createDirectory('${path}/game');
      return;
    }
    if (!FileSystem.exists('${path}/games')) {
      FileSystem.createDirectory('${path}/games');
      FileSystem.createDirectory('${path}/games/mv');
      FileSystem.createDirectory('${path}/games/mz');
    }
  }

  public static function fileBanner(filename) {
    var date = Date.now();
    return '/** ============================================================================
 *
 *  ${filename}
 * 
 *  Build Date: ${date.getMonth() + 1}/${date.getDate()}/${date.getFullYear()}
 * 
 *  Made with LunaTea -- Haxe
 *
 * =============================================================================
*/
';
  };

  public static function installRequiredPackages() {}

  public static function compileFromSource() {}
}

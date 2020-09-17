package wizard;

import js.node.Path;
import sys.io.File;
import sys.FileSystem;
import napkin.Napkin;

using StringTools;

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
    addCompileHxml(Sys.getCwd());
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

      File.saveContent('${path}/checkstyle.json', fileData);
    }
  }

  public static function addHaxeFormatJson(path: String) {
    if (!FileSystem.exists('${path}/hxformat.json')) {
      var jsonPath = '${_scaffoldDir}/hxformat.json';
      var fileData: String = File.getContent(jsonPath).toString();

      File.saveContent('${path}/hxformat.json', fileData);
    }
  }

  public static function addCompileHxml(path: String) {
    if (!FileSystem.exists('${path}/compile.hxml')) {
      var jsonPath = '${_scaffoldDir}/compile.hxml';
      var fileData: String = File.getContent(jsonPath);

      File.saveContent('${path}/compile.hxml', fileData);
    }
  }

  public static function fileBanner(filename) {
    var date = Date.now();
    return '/** ============================================================================
 *
 *  ${filename}
 * 
 *  Build Date: ${date.getDay()}/${date.getMonth()}/${date.getFullYear()}
 * 
 *  Made with LunaTea -- Haxe
 *
 * =============================================================================
*/
';
  };

  public static function installRequiredPackages() {
    var napkin = NodePackage.install('@lunatechs/lunatea-napkin', true);
    var lix = NodePackage.install('lix');
    trace(napkin.message);
    trace(lix.message);
    if (!napkin.status) {
      trace('Unable to install LunaTea Napkin, try manually installing using npm install --save-dev @lunatechs/lunatea-napkin');
    }
    if (lix.status) {
      LixPackage.init();
      var lunaTea = LixPackage.installFromGithub('LunaTechsDev', 'LunaTea');
      trace(lunaTea.message);
    }
  }

  public static function compileFromSource(?hxmlPath: String, ?usePrettier = true) {
    var lix = LixPackage.compile(hxmlPath);
    trace(lix.message);
    if (!lix.status) {
      trace('failed to compile project from ${hxmlPath}');
    } else {
      var hxmlData = File.getContent(hxmlPath);
      var ereg = new EReg('(-js|--js)(.*)', 'g');
      var matches = Utils.getMatches(ereg, hxmlData, 2);
      var jsTargetPaths = matches.map((path: String) -> {
        return path.trim();
      });

      for (path in jsTargetPaths) {
        var code = File.getContent(Path.resolve(path));
        try {
          var filename = Path.parse(path).name;
          File.saveContent(path, '${fileBanner(filename)} ${Napkin.parse(code, usePrettier)}');
        } catch (error) {
          trace(error.message);
        }
      }
    }
  }
}

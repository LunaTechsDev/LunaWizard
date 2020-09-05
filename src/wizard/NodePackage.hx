package wizard;

import haxe.Json;
import sys.FileSystem;
import sys.io.File;
import js.node.StringDecoder;
import js.node.ChildProcess;

class NodePackage {
  private static var _command = Sys.systemName() == 'Windows' ? 'npm.cmd' : 'npm';
  private static var _stringDecoder = new StringDecoder('utf8');

  private static function _run(args: Array<String>): Bool {
    return try {
      var npm = ChildProcess.spawnSync('${_command}', args);

      if (npm.status == 0) {
        if (npm.stdout != null) {
          trace(_stringDecoder.end(npm.stdout));
        }
        return true;
      } else {
        if (npm.stderr != null) {
          trace(_stringDecoder.end(npm.stderr));
        }
        return false;
      }
    } catch (error) {
      throw error.message;
    }
  }

  public static function createPackageJson() {
    var path: String = '${Sys.getCwd()}/package.json';
    var packageData = {
      name: 'luna-plugin',
      version: '1.0.0'
    };

    if (!FileSystem.exists(path)) {
      File.saveContent(path, Json.stringify(packageData));
    }
  }

  public static function install(name: String, ?asDev: Bool = false): Bool {
    var args = ['install', '--save', name];
    if (asDev) {
      args.push('-D');
    }
    return _run(['install', '--save', name]);
  }
}

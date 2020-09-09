package wizard.utils;

import js.node.ChildProcess;
import js.node.StringDecoder;

typedef SpawnResult = {
  var error: js.lib.Error;
  var message: String;
  var status: Bool;
}

class ChildSpawn {
  private static var _stringDecoder = new StringDecoder('utf8');

  public static function run(command: String, args: Array<String>): SpawnResult {
    return try {
      var status: Bool = false;
      var message: String = '';
      var child = ChildProcess.spawnSync('${command}', args);

      if (child.status == 0) {
        status = true;
        message = _stringDecoder.end(child.stdout);
      } else if (child.status == 1) {
        status = false;
        message = _stringDecoder.end(child.stderr);
      }

      return {
        error: child.error,
        message: message,
        status: status
      }
    } catch (error) {
      throw error.message;
    }
  }

}
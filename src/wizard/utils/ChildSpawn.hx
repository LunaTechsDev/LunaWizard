package wizard.utils;

import js.node.ChildProcess;
import js.node.StringDecoder;

typedef SpawnResult = {
  var message: String;
  var status: Bool;
}

class ChildSpawn {
  private static var _stringDecoder = new StringDecoder('utf8');

  public static function run(command: String, args: Array<String>): SpawnResult {
    var command = Sys.systemName() == 'Windows' ? '${command}.cmd' : command;

    return try {
      var status: Bool = false;
      var message: String = '';
      var child = ChildProcess.spawnSync('${command}', args);

      status = child.status == 0;
      message = _stringDecoder.end(child.stdout);

      if (child.stderr != null) {
        message = _stringDecoder.end(child.stderr);
      }

      if (child.error != null) {
        message = child.error.message;
      }

      return {
        message: message,
        status: status,
      }
    } catch (error) {
      throw error.message;
    }
  }

}
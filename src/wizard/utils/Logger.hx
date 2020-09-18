package wizard.utils;

import js.node.stream.Writable.IWritable;
import wizard.utils.ChildSpawn.SpawnResult;
import hxlog.Logger as HxLogger;

class Logger extends HxLogger {
  public function new() {
    super({
      displayFunctionName: false,
      displayDateTime: false,
      displayFilePath: ''
    });
  }

  public function clearScreen() {
    var stdout: IWritable = cast settings.stdOut;
    stdout.write('\u001B[2J\u001B[0;0f');
  }

  public function spawnResult(result: SpawnResult, acceptMsg: String, refuseMsg: String) {
    if (result.message != '') {
      info(result.message);
    }
    if (!result.status) {
      warn(refuseMsg);
    }
    info(acceptMsg);
  }
}
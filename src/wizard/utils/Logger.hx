package wizard.utils;

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
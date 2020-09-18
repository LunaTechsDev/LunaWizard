package wizard.utils;

import hxlog.Logger as HxLogger;

class Logger extends HxLogger {
  public function new() {
    super({
      displayFunctionName: false,
      displayDateTime: false,
      displayFilePath: ''
    });
  }
}
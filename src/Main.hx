import mcli.Dispatch;
import wizard.GuidedSetup;
import mcli.CommandLine;

import commands.Build;

class Main extends CommandLine {
  public var watch: Bool;

  public function help() {
    // print usage details
  }

  public function runDefault() {
    // GuidedSetup.start();
  }

  public function build(d: Dispatch) {
    d.dispatch(new Build());
  }

  public static function main() {
    new mcli.Dispatch(Sys.args()).dispatch(new Main());
  }
}

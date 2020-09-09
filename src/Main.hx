import wizard.GuidedSetup;
import mcli.CommandLine;

class Main extends CommandLine {
  public var watch: Bool;

  public function help() {
    // print usage details
  }

  public function runDefault() {
    // run the wizard setup guide
    init();
  }

  public function init(?path: String) {
    // run the wizard setup guide
    GuidedSetup.start();
  }

  public function build(path: String) {
    // Build from source files
  }

  public static function main() {
    new mcli.Dispatch(Sys.args()).dispatch(new Main());
  }

}
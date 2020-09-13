import mcli.Dispatch;
import wizard.GuidedSetup;
import mcli.CommandLine;

import commands.Build;

/**
  Run a setup guide to get started in creating a new project.
**/
class Main extends CommandLine {
  public function help() {
    Sys.println(this.showUsage());
    Sys.exit(0);
  }

  public function runDefault() {
    if (Sys.args().length > 0) {
      return;
    }
    GuidedSetup.start();
  }

  /**
    Build your project from the hxml file given. If no path was given
    then LunaWizard will find all .hxml files in your project and prompt you
    to use which ones for compilation.
  **/
  public function build(d: Dispatch) {
    d.dispatch(new Build());
  }

  public static function main() {
    new mcli.Dispatch(Sys.args()).dispatch(new Main());
  }
}

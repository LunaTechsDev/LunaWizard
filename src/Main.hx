import prompts.Prompter;
import wizard.utils.HxmlDiscovery;
import wizard.Builder;
import wizard.GuidedSetup;
import mcli.CommandLine;

class Main extends CommandLine {
  public var watch: Bool;

  public function help() {
    // print usage details
  }

  public function runDefault() {}

  public function init(?path: String) {
    // run the wizard setup guide
    GuidedSetup.start();
  }

  public function build(?hxml: String) {
    // Build from source files
    if (hxml == null) {
      var hxmlPaths = HxmlDiscovery.discover();
      var choices = hxmlPaths.map(path -> {
        return {
          title: path,
          value: path,
          description: '',
          disabled: false,
          selected: false
        }
      });
      Prompter.call({
        type: 'multiselect',
        name: 'hxmlPaths',
        message: 'Choose an hxml to build from',
        choices: choices
      }).then((response: Dynamic) -> {
        var paths: Array<String> = response.hxmlPaths;
        for (path in paths) {
          Builder.compileFromSource(path);
        }
      });
      return;
     }
    Builder.compileFromSource(hxml);
  }

  public static function main() {
    new mcli.Dispatch(Sys.args()).dispatch(new Main());
  }
}

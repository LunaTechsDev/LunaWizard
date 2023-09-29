import utils.Fn;
import rm.Globals;

using Lambda;
using core.StringExtensions;
using core.NumberExtensions;

class Main {
  /**
   * Main entry point of your application.
   */
  public static function main() {
    /**
     * This allows you to get the plugin parameters using the description regardless of the file name.
     * Works across both MV and MZ.
     */
    var params = Globals.Plugins.filter((plugin) -> ~/<TestPlugin>/ig.match(plugin.description))[0].parameters;
  }
}

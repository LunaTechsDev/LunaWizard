import wizard.NodePackage;
import wizard.Builder;

class Main {
  public static function main() {
    Builder.newProject('./tests/temp/');
    NodePackage.install('is-sorted');
  }
}
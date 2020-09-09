import utest.Runner;
import utest.ui.Report;

class TestAll {
  public static function main() {
    var runner = new Runner();
    runner.addCase(new TestBuilder());
    runner.addCase(new TestNodePackage());
    runner.addCase(new TestLixPackage());
    Report.create(runner);
    runner.run();
  }
}
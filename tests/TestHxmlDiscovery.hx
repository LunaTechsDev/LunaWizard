import wizard.utils.HxmlDiscovery;
import utest.utils.TestBuilder;
import js.node.Path;
import utest.Test;
import utest.Assert;
import sys.io.File;
import sys.FileSystem;
import utils.FileSystemExt;

using StringTools;

class TestHxmlDiscovery extends Test {
  function setupClass() {
    Sys.setCwd(Path.resolve('./'));
  }

  function testHxmlDsicovery() {
    var hxmlFiles = HxmlDiscovery.discover();
    Assert.isTrue(hxmlFiles.length > 0);
  }
}

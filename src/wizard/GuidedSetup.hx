package wizard;

import sys.FileSystem;
import prompts.Prompter;
import js.node.Path;

class GuidedSetup {
  public static function start() {
    Prompter.call([
      {
        type: 'text',
        name: 'cwd',
        message: 'Where would you like to create the project?',
        initial: './',
        format: (v) -> Path.resolve(v)
      },
      {
        type: 'text',
        name: 'projectName',
        message: 'Project name',
        initial: 'generated-project'
      },
      {
        type: 'text',
        name: 'projectName',
        message: 'Project description'
      },
      {
        type: 'text',
        name: 'projectAuthor',
        message: 'Author name',
        initial: 'LunaTechs Contributors'
      },
      {
        type: 'confirm',
        name: 'autoInstall',
        message: 'Would you like LunaWizard to auto install required packages?'
      }
    ]).then((answers: Dynamic) -> {
      if (!FileSystem.exists(answers.cwd)) {
        FileSystem.createDirectory(answers.cwd);
      }
      if (answers.cwd != null) {
        Sys.setCwd(answers.cwd);
      }
      Builder.newProject(Sys.getCwd());
      NodePackage.createPackageJson();
      if (answers.autoInstall) {
        Builder.installRequiredPackages();
      }
    });
  }
}

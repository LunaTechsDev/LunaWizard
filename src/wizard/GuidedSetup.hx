package wizard;

import prompts.Prompter;

// import haxe.io.Path;
// import sys.FileSystem;
class GuidedSetup {
  public static function start() {
    Prompter.call([
      {
        type: 'text',
        name: 'cwd',
        message: 'Where would you like to create the project?',
        initial: './'
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
      Builder.newProject(answers.cwd);
      if (answers.autoInstall) {
        NodePackage.install('lix');
      }
    });
  }
}

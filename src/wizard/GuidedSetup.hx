package wizard;

import wizard.NodePackage;
import sys.FileSystem;
import prompts.Prompter;
import js.node.Path;

import wizard.js.Builder as JsBuilder;
import wizard.haxe.Builder as HaxeBuilder;

class GuidedSetup {
  public static function start() {
    Prompter.call([
      {
        type: 'select',
        name: 'target',
        message: 'What is the target for your project',
        choices: [
          {
            value: 'js',
            title: 'JavaScript - A project setup for use with JavaScript using Rollup',
            disabled: false
          },
          {
            value: 'haxe',
            title: 'Haxe - A project setup for use with Haxe using LunaTea',
            disabled: false
          }
        ]
      },
      {
        type: (prev, values, prompt) -> values.target == 'js' ? 'confirm' : null,
        name: 'compatability',
        message: 'Is this project to be backwards compatible with RPG Maker MV?',
        choices: [
          {
            value: 'js',
            title: 'JavaScript - A project setup for use with JavaScript using Rollup',
            disabled: false
          },
          {
            value: 'haxe',
            title: 'Haxe - A project setup for use with Haxe using LunaTea',
            disabled: false
          }
        ]
      },
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
        type: (prev, values, prompt) -> values.target == 'haxe'? 'confirm' : null,
        name: 'autoInstall',
        message: 'Would you like LunaWizard to auto install required packages?'
      },
      {
        type: (prev, values, prompt) -> values.target == 'js' ? 'select' : null,
        name: 'linter',
        message: 'Choose a linter for error detection and style rules',
        choices: [
          {
            value: 'eslint',
            title: 'ESLint',
          },
          {
            value: 'xo',
            title: 'XO'
          },
          {
            value: 'jshint',
            title: 'JSHint'
          },
          {
            value: 'none',
            title: 'none'
          }
        ]
      },
      {
        type: (prev, values, prompt) -> prev == 1 ? 'multiselect' : null,
        name: 'eslintPlugins',
        message: 'Which ESLint plugins would you like to install',
        choices: [
          {
            value: 'eslint-plugin-rpgmaker',
            title: 'RPG Maker MV Global Variables'
          },
          {
            value: 'standard',
            title: 'StandardJS Config'
          },
          {
            value: 'semistandard',
            title: 'StandardJS Config w/ Semicolons'
          },
          {
            value: 'airbnb',
            title: 'Airbnb Style'
          }
        ]
      },
      {
        type: 'multiselect',
        name: 'optionalPackages',
        message: 'Would you like to install other useful packages',
        choices: [
          {
            value: 'fenix-tools',
            title: 'FeniXTools - A modular RPG Maker MV plugin library'
          },
          {
            value: 'ava',
            title: 'AVA - Futuristic test runner'
          },
          {
            value: 'flow-bin',
            title: 'Flow - A static type checker for JavaScript'
          }
        ]
      }
    ]).then((answers: Dynamic) -> {
      if (!FileSystem.exists(answers.cwd)) {
        FileSystem.createDirectory(answers.cwd);
      }
      if (answers.cwd != null) {
        Sys.setCwd(answers.cwd);
      }

      if (answers.target == 'haxe') {
        HaxeBuilder.newProject(Sys.getCwd());
        NodePackage.createPackageJson();
        if (answers.autoInstall) {
          HaxeBuilder.installRequiredPackages();
        }
        return;
      }

      if (answers.target == "js") {
        JsBuilder.newProject(Sys.getCwd(), answers.compatability);
        NodePackage.createPackageJson();
      }
    });
  }
}

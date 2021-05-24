export const rawParameters = $plugins.filter(
  plugin => plugin.description.contains('<X_PluginName>')
)[0].parameters

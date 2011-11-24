require 'redmine'

require 'projects_helper_patch'

Redmine::Plugin.register :redmine_qgis_hub do
  name 'QGIS Hub plugin'
  author 'Mathias Walker'
  description 'A Redmine plugin for the QGIS Hub'
  version '0.1'
end

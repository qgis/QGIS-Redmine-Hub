require_dependency 'projects_helper'

module ProjectsHelperPatch
  def self.included(base) # :nodoc:
    base.send(:include, InstanceMethods)

    base.class_eval do
      alias_method_chain :parent_project_select_tag, :default
    end
  end

  module InstanceMethods
    def parent_project_select_tag_with_default(project, &block)
      # based on ProjectsHelper::parent_project_select_tag

      selected = project.parent
      # retrieve the requested parent project
      parent_id = (params[:project] && params[:project][:parent_id]) || params[:parent_id]
      if parent_id
        selected = (parent_id.blank? ? nil : Project.find(parent_id))
      else
        # select default parent project
        selected = Project.find('qgis-user-plugins')
      end

      options = ''
      options << "<option value=''></option>" if project.allowed_parents.include?(nil)
      options << project_tree_options_for_select(project.allowed_parents.compact, :selected => selected)
      content_tag('select', options, :name => 'project[parent_id]', :id => 'project_parent_id')
    end
  end
end

require 'dispatcher'
Dispatcher.to_prepare do
  unless ProjectsHelper.included_modules.include? ProjectsHelper
    ProjectsHelper.send(:include, ProjectsHelperPatch)
  end
end

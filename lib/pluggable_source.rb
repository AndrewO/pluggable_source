require "pluggable_source/version"

module PluggableSource
  module ClassMethods
    def define_pluggable_source(name, choices = {})
      @pluggable_source_definitions ||= {}
      @pluggable_source_definitions[name] = choices
    end

    def pluggable_source_for(name, choice)
      choices = @pluggable_source_definitions[name] and choices[choice]
    end
  end

  def self.included(base)
    base.extend ClassMethods
  end

  def set_source!(name, choice = nil, &block_source)
    @pluggable_sources ||= {}
    if source = self.class.pluggable_source_for(name, choice) || block_source
      @pluggable_sources[name] = source
    else
      raise ArgumentError, "Unknown source choice #{choice.to_s} and no block given"
    end
  end

  protected
  def using_source(name)
    @pluggable_sources ||= {}
    @pluggable_sources[name]
  end
end

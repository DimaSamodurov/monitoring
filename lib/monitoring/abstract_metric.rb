module Monitoring
  class AbstractMetric
    # Metric name derived from class name by default, but can be overridden.
    def self.metric_name
      self.name.split('::').last
    end

    # Namespace can be defined individually for each metric or
    # client's default namespace will be used.
    def namespace
      nil
    end

    def metric_name
      self.class.metric_name
    end

    def unit
      'Count'
    end

    def dimensions
      nil
    end

    def value
      raise NotImplementedError.new('Please implement "value" method of the specific metric.')
    end
  end
end
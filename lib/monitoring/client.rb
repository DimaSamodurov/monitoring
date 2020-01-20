require 'aws-sdk-cloudwatch'
require_relative 'abstract_metric'

module Monitoring
  # Simplifies sending metrics to the store abstracting out AWS API.
  module Client

    class Config
      attr_accessor :default_namespace
    end

    def self.configure(&block)
      @config ||= Config.new
      yield @config
    end

    def self.put_metric(metric)
      put_metric_data(namespace:   metric.namespace,
                      metric_name: metric.metric_name,
                      value:       metric.value,
                      dimensions:  metric.dimensions,
                      unit:        metric.unit)
    end

    def self.put_metric_data(metric_name:, value:,
        unit: 'Count', namespace: nil, dimensions: nil)

      client = Aws::CloudWatch::Client.new(
          # http_wire_trace: true,
          # log_level:       :debug
      )

      metric_data = {
          namespace:   namespace || @config.default_namespace,
          metric_data: [
                           {
                               metric_name: metric_name,
                               dimensions:  dimensions,
                               value:       value,
                               unit:        unit
                           }
                       ]
      }

      client.put_metric_data(metric_data)
    end
  end
end

RSpec.describe Monitoring::Client do
  subject(:client) { Monitoring::Client }

  describe '.put_metric_data', vcr: {cassette_name:     'put_metric_data',
                                     match_requests_on: [:uri, :body]} do
    it 'sends data to store' do
      result = client.put_metric_data(namespace: 'Test Namespace', metric_name: 'Test Metric', value: 1)
      expect(result).to be_successful
    end

    context 'without parameter namespace' do
      it "sends the client's default namespace" do
        Monitoring::Client.configure do |config|
          config.default_namespace = 'Default Namespace'
        end

        result = client.put_metric_data(metric_name: 'Test Metric', value: 1)
        expect(result).to be_successful
      end

      context 'and without client default namespace' do
        it "raises error" do
          Monitoring::Client.configure do |config|
            config.default_namespace = nil
          end

          expect { client.put_metric_data(metric_name: 'Test Metric', value: 1) }.
              to raise_error(ArgumentError)
        end
      end
    end
  end

  describe '.put_metric', vcr: {cassette_name:     'put_metric',
                                match_requests_on: [:uri, :body]} do
    it 'does not fail' do
      client.configure do |config|
        config.default_namespace = 'Test'
      end

      metric = Monitoring::AbstractMetric.new
      expect(metric).to receive(:value).and_return(1)

      expect { client.put_metric(metric) }.to_not raise_error
    end
  end
end

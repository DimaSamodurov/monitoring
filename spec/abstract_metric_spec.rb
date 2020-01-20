RSpec.describe Monitoring::AbstractMetric do
  it 'requires to override .value' do
    metric = Monitoring::AbstractMetric.new
    expect{metric.value}.to raise_error(NotImplementedError)
  end
end

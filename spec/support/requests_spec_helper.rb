module RequestSpecHelper
  RSpec.configure do |config|
    config.before(:example, :type => :request) do
      allow(Rails.application.config.action_dispatch).to receive(:show_exceptions)
      allow(Rails.application.config).to receive(:consider_all_requests_local).and_return(false)
    end
  end

  # Parse JSON response to ruby hash
  def json
    JSON.parse(response.body)
  end

  def first_error_detail
    json['errors'][0]['detail']
  end
end

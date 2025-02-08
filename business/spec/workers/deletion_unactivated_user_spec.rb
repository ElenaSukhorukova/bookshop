require 'rails_helper'

RSpec.describe DeletionUnactivatedUserWorker, type: :job do
  it { is_expected.to be_processed_in :default }
end

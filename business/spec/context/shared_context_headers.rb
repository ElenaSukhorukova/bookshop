RSpec.shared_context 'when it needed headers' do
  let(:header) do
    {
      'HTTP_ACCEPT_LANGUAGE': 'fr-CH, fr;q=0.9, en;q=0.8, de;q=0.7, *;q=0.5'
    }
  end
end

  require 'spec_helper'

describe AffiliateHub do
  it 'has a version number' do
    expect(AffiliateHub::Awin::VERSION).not_to be nil
  end

  describe AffiliateHub::Awin::Settings do
    it 'has a base_uri' do
      expect(AffiliateHub::Awin::Settings.new).to respond_to(:base_uri)
    end

    it 'has an api_token' do
      expect(AffiliateHub::Awin::Settings.new).to respond_to(:api_token)
    end

    it 'has an publisher_id' do
      expect(AffiliateHub::Awin::Settings.new).to respond_to(:publisher_id)
    end
  end

  describe AffiliateHub::Awin::Connection do
    let(:base_uri)     { "https://api.awin.com" }
    let(:api_token)    { "KVBcCy1MgWli+Ui64v+6RenJspG1b8DXg7BeHFXf/yw=" }
    let(:publisher_id) { 10 }
    let(:connection)   { AffiliateHub.initialize_connection(:awin) }

    before do
      eval <<~COMMISSION_HUB_SETUP
        AffiliateHub.setup do |config|
          config.setup :awin do |c|
            c.base_uri     = "#{base_uri}"
            c.api_token    = "#{api_token}"
            c.publisher_id = "#{publisher_id}"
          end
        end
      COMMISSION_HUB_SETUP
    end

    describe '#advertisers' do
      let(:advertisers_url) { "#{base_uri}/publishers/#{publisher_id}/programmes" }

      before do
        stub_request(:get, advertisers_url).
          with(headers: { "Authorization" => "Bearer #{api_token}" }).
          to_return(status: 200, body: "", headers: {})
      end

      it 'calls for GET /publishers/:id/programmes' do
        connection.advertisers
        expect(a_request(:get, "https://api.awin.com/publishers/10/programmes")).
          to have_been_made
      end
    end

    describe '#advertiser_details' do
      let(:advertisers_url) { "#{base_uri}/publishers/#{publisher_id}/programmedetails" }

      before do
        stub_request(:get, advertisers_url).
          with(
            headers: { "Authorization" => "Bearer #{api_token}" },
            query: { "advertiserId" => "4275" }
        ).
          to_return(status: 200, body: "", headers: {})
      end

      it 'calls for GET /publishers/:id/programmedetails' do
        connection.advertiser_details(nil, request_params: { query: { "advertiserId" => "4275" }})
        expect(
          a_request(:get, "https://api.awin.com/publishers/10/programmedetails").
          with(query: { "advertiserId" => "4275" })
        ).to have_been_made
      end
    end

    describe '#commissions' do
      let(:commissions_url) { "#{base_uri}/publishers/#{publisher_id}/transactions" }
      # transactions/?startDate=2017-02-20T00%3A00%3A00&endDate=2017-02-21T01%3A59%3A59&timezone=UTC

      before do
        stub_request(:get, commissions_url).
          with(
            headers: { "Authorization" => "Bearer #{api_token}" },
            query: {
              "startDate" => "2017-02-20",
              "endDate"   => "2017-02-21",
              "timezone"  => "UTC"
            }
          ).to_return(status: 200, body: "", headers: {})
      end

      it 'calls for GET /publishers/:id/transactions' do
        connection.commissions(nil, request_params: {
          query: {
            "startDate" => "2017-02-20",
            "endDate"   => "2017-02-21",
            "timezone"  => "UTC"
          }
        })
        expect(
          a_request(:get, "https://api.awin.com/publishers/10/transactions").
          with(query: {
            "startDate" => "2017-02-20",
            "endDate"   => "2017-02-21",
            "timezone"  => "UTC"
          })
        ).to have_been_made
      end
    end
  end
end

require 'spec_helper'

describe SLSP::Connector, :if => false do

  before(:all) do
    @slsp = SLSP::Connector.new(ENV["GMAIL_USERNAME"], ENV["GMAIL_PASSWORD"], ENV["ARCHIVE_PASSWORD"])
    @emails = @slsp.find_emails
  end

  it "finds emails" do
    @emails.length.should > 1
  end

  it "extracts email" do
    email = @emails.first
    file = @slsp.extract_archive(email)
    file[:filename].should == "V000002.zip"
  end

  it "reads archive" do
    email = @emails.first
    file = @slsp.extract_archive(email)

    str = @slsp.read_archive(file[:data])

    str.should_not be(:empty)
  end

  it "parses transactions" do
    pending "Waiting for data"
    email = @emails.last
    file = @slsp.extract_archive(email)
    str = @slsp.read_archive(file[:data])
  end


end

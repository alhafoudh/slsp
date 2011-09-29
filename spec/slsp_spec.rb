require 'spec_helper'

describe SLSP do

  before(:all) do
    @slsp = SLSP.new(ENV["GMAIL_USERNAME"], ENV["GMAIL_PASSWORD"], ENV["ARCHIVE_PASSWORD"])
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

    tlog = @slsp.read_archive(file[:data])

    tlog.should_not be(:empty)
  end


end

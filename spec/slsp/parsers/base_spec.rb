require 'spec_helper'

describe SLSP::Parsers::Base do

  before(:all) do
    @str = File.read(File.join("spec", "fixtures", "parsers", "base.txt"))
    @parser = SLSP::Parsers::Base.new(@str)
  end

  it "loads input" do
    @parser.input.should == "Hello world!\n"
  end

  it "parses nothing" do
    @parser.parse.should == nil
  end


end

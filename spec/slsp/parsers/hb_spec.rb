require 'spec_helper'

describe SLSP::Parsers::HB do

  before(:all) do
    @str = File.read(File.join("spec", "fixtures", "parsers", "hb.txt"))
    @parser = SLSP::Parsers::HB.new(@str)
  end

  it "parses HB format" do
    ts = @parser.parse
    ts.length.should == 4
  end

  it "parses statement" do
    ts = @parser.parse
    # 30.10.2003;000000;0011622358;000000;0011622366;0900;Ustredie 2, Testovaci ucet;+1.00;SKK;+000000000000.000;+345.78;Bezhotovostny vklad;0123123123;0000000808;0456456456;0;;0;;;;;Pokusny merchant AG;;;
    t = ts.first

    t[:date].year.should == 2003
    t[:date].month.should == 10
    t[:date].day.should == 30

    t[:src_account_prefix].should == "000000"
    t[:src_account_number].should == "0011622358"
    t[:dst_accont_prefix].should == "000000"
    t[:dst_account_number].should == "0011622366"
    t[:dst_bank_code].should == "0900"
    t[:dst_account_name].should == "Ustredie 2, Testovaci ucet"
    t[:amount].should == 1.0
    t[:currency].should == "SKK"
    t[:conversion_rate].should == 0.0
    t[:balance_after].should == 345.78
    t[:turnover_name].should == "Bezhotovostny vklad"
    t[:variable_symbol].should == "0123123123"
    t[:constant_symbol].should == "0000000808"
    t[:specific_symbol].should == "0456456456"
    t[:cancel_flag].should == 0
    t[:note].should == ""
    t[:log_id].should == "0"
    t[:description].should == ["", "", "", "", "Pokusny merchant AG"]
    t[:reciever_note].should == []
  end

end

require 'slsp/parsers/base'

module SLSP

  module Parsers

    class HB < Base
      
      def parse
        input.split("\n").map do |line|
          obj = line.split(";")

          {
            :date => Date.parse(obj[0]),
            :src_account_prefix => obj[1],
            :src_account_number => obj[2],
            :dst_accont_prefix => obj[3],
            :dst_account_number => obj[4],
            :dst_bank_code => obj[5],
            :dst_account_name => obj[6],
            :amount => obj[7].to_f,
            :currency => obj[8],
            :conversion_rate => obj[9].to_f,
            :balance_after => obj[10].to_f,
            :turnover_name => obj[11],
            :variable_symbol => obj[12],
            :constant_symbol => obj[13],
            :specific_symbol => obj[14],
            :cancel_flag => obj[15].to_i,
            :note => obj[16],
            :log_id => obj[17],
            :description => obj[18..22],
            :reciever_note => obj[23..26]
          }
        end
      end

    end

  end

end

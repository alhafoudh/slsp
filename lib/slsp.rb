require 'gmail'
require 'zipruby'
require 'mt940'

require 'awesome_print'
require 'pry'

class SLSP

  attr_accessor :gmail_username, :gmail_password, :archive_password

  def initialize(gmail_username, gmail_password, archive_password)
    @gmail_username = gmail_username
    @gmail_password = gmail_password
    @archive_password = archive_password
  end

  def find_emails
    valid_emails = []

    Gmail.new(gmail_username, gmail_password) do |gmail|

      cond = { :from => "vypis@slsp.sk" }
      count = gmail.inbox.count(cond)

      emails = gmail.inbox.emails(cond)
      
      for email in emails
        cd = email.header["Content-Disposition"]
        next unless cd.field.disposition_type == "attachment"
        next unless (cd.field.filename =~ /V[0-9]{6}.zip/) == 0

        valid_emails << email.send(:message)
      end
    end

    valid_emails
  end

  def extract_archive(email)
    cd = email.header["Content-Disposition"]
    { :filename => cd.field.filename, :data => email.body.decoded }
  end

  def read_archive(data)
    contents = nil
    Zip::Archive.open_buffer(data) do |ar|
      ar.decrypt archive_password
      ar.each do |f|
        contents = f.read
      end
    end

    contents
  end

end

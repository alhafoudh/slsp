# SLSP

## Usage

There are 2 ways how to get HB formatted file.

1. In SLSP internet banking choose "turnovers" and there you can export actual view. It will download HB formatted report.

2. Creating scheduled daily / monthly email reports in HB format. Email will include attached password encrypted file which will contain the HB formatted file .txt. Encryption password can be set in personal preferences.

### Parse HB formatted report
    
    str = File.read("hb_formatted_file.txt"))

    parser = SLSP::Parsers::HB.new(str)
    transactions = parser.parse

    puts transactions.inspect

### Retrieve HB formatted report from email (GMail only)

    slsp = SLSP::Connector.new("email", "password", "archive password")
    emails = slsp.find_emails

    for email in emails
      file = slsp.extract_archive(email)
      str = slsp.read_archive(file[:data])

      parser = SLSP::Parsers::HB.new(str)
      transactions = parser.parse

      puts transactions.inspect

    end


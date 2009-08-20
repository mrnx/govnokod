#MSpookie for govnokod.ru
#MSpookie is a simple mail pool server

#Required
require "mysql"
require "net/smtp"

#Connects to server
connection = Mysql.connect "localhost", "root", "***", "govnokod"

#Gets set of elements
set = connection.query "SELECT * FROM `mailer_mail`"

if set != nil and set.num_rows > 0
    smtp = Net::SMTP.start('localhost', 25)

    while row = set.fetch_hash do
        smtp.send_message "From: #{row['fromName']} <#{row['from']}>\nTo: #{row['toName']} <#{row['to']}>\nSubject:#{row['subject']}\n\n#{row['body']}", #Message text
            row["from"], #From field
            [row["to"]] #To array (may be many entries)
    end
    smtp.finish()
end

connection.close
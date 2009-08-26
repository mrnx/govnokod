#MSpookie for govnokod.ru
#MSpookie is a simple mail pool server
#really

#Required
require "mysql"
require "base64"
require "net/smtp"

#Connects to server
connection = Mysql.connect "localhost", "root", "", "govnokod"

connection.query "SET NAMES `utf8`"

#Gets set of elements
set = connection.query "SELECT * FROM `mailer_mail` WHERE `id`"

if set != nil and set.num_rows > 0
    smtp = Net::SMTP.start('localhost', 25)
    while row = set.fetch_hash do
        fromHeader = row['fromName'] ? row['fromName'] + ' <' + row['from'] + '>' : row['from'];
        toHeader = row['toName'] ? row['toName'] + ' <' + row['to'] + '>' : row['to']
        subjectHeader = '=?UTF-8?B?' + Base64.encode64(row['subject']) + '?='
    
        body = Base64.encode64(row['body'])
    
        smtp.send_message "From: #{fromHeader}\nTo: #{toHeader}\nSubject: #{subjectHeader}\nContent-type: text/html;charset=UTF-8\nContent-Transfer-Encoding: base64\n\n#{body}", #Message text
            row["from"], #From field
            [row["to"]] #To array (may be many entries)
    end
    smtp.finish()
end

connection.close
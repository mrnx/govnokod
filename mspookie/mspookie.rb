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
set = connection.query "SELECT * FROM `mailer_mail`"

def encodeString s
    '=?UTF-8?B?' + Base64.encode64(s).strip + '?='
end

if set != nil and set.num_rows > 0
    smtp = Net::SMTP.start('localhost', 25)
    
    if smtp.started?
        while row = set.fetch_hash do
            fromHeader = row['fromName'].length > 0 ? encodeString(row['fromName']) + ' <' + row['from'] + '>' : row['from'];
            toHeader = row['toName'].length > 0 ? encodeString(row['toName']) + ' <' + row['to'] + '>' : row['to']
            subjectHeader = encodeString(row['subject']);
        
            body = "From: #{fromHeader}\n" + 
            "To: #{toHeader}\n" +
            "Subject: #{subjectHeader}\n" +
            "Content-type: text/html;charset=UTF-8\n" +
            "Content-Transfer-Encoding: base64\n\n" + 
            Base64.encode64(row['body'])
        
            smtp.send_message body, #Message text
                row["from"], #From field
                [row["to"]] #To array (may be many entries)
                
            connection.query "DELETE FROM `mailer_mail` WHERE `id` = " + row['id'] + " LIMIT 1"
        end
        smtp.finish()
    end
end

connection.close
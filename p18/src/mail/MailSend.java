package mail;

import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.Properties;
 
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeUtility;
 
public class MailSend {
    
    public MailSend(String to2, String from, String subject, String content) {
    	
        Properties prop = System.getProperties();
        prop.put("mail.smtp.starttls.enable", "true");
        prop.put("mail.smtp.host", "smtp.gmail.com");
        prop.put("mail.smtp.auth", "true");
        prop.put("mail.smtp.port", "587");
        

        
        Authenticator auth = new MailAuth();
        
        
        Session session = Session.getDefaultInstance(prop, auth);
        
        MimeMessage msg = new MimeMessage(session);
    
        try {
            msg.setSentDate(new Date());
            
            msg.setFrom(new InternetAddress("ssddii7@gmail.com", "송정동사무소"));
            InternetAddress to = new InternetAddress(to2);         
            msg.setRecipient(Message.RecipientType.TO, to);            
            msg.setSubject(subject);                
            msg.setSubject(MimeUtility.encodeText(subject, "EUC-KR", "B"));
            msg.setSubject(MimeUtility.encodeText(subject, "UTF-8", "B"));
            msg.setContent(content, "text/html; charset=UTF-8");
            msg.setContent(content, "text/html; charset=EUC-KR");
            
            Transport.send(msg);
            
        } catch(AddressException ae) {            
            System.out.println("AddressException : " + ae.getMessage());           
        } catch(MessagingException me) {            
            System.out.println("MessagingException : " + me.getMessage());
        } catch(UnsupportedEncodingException e) {
            System.out.println("UnsupportedEncodingException : " + e.getMessage());			
        }
                
    }
}

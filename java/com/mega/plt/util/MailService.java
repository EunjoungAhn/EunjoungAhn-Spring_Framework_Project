package com.mega.plt.util;

import javax.mail.internet.MimeMessage;

import org.aspectj.lang.annotation.Aspect;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

@Aspect
@Service("mail")
public class MailService {
	
	@Autowired
	private JavaMailSender mailSender; // context에다 bean으로 만들어 둠

	public void mailSend() {
		System.out.println("메일 전송 시작");
		String body = "누군가 해킹하려고 합니다!!!!\n";
		try {
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
			messageHelper.setFrom("보내는사람이메일(구글)"); // ★★넣으세요 안 넣으면 에러★★
			messageHelper.setTo("받는사람"); // ★★넣으세요 안 넣으면 에러★★
			messageHelper.setSubject("서버에 문제 발생");
			messageHelper.setText(body);
			mailSender.send(message);
			System.out.println("메일 전송 완료");
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("메일 전송 실패");
		}
	}
}

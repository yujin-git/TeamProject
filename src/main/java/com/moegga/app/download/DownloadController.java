package com.moegga.app.download;

import java.io.File;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class DownloadController {
	
	@RequestMapping("/FileUpDown/Download.do")
	//1]스프링에서 제공하는 API 미 사용
	/*
	 * 반환타입:void
	 * 다운로드 원리를 적용해서 직접 웹브라우저로 출력
	 */
//	public void download(HttpServletRequest req,HttpServletResponse resp,@RequestParam String filename) {
//		FileUpDownUtils.download(req, resp, filename, "/upload");
//	}//////////////
	//2]스프링 API사용-반환타입은 반드시 String(문자열은 빈 설정파일에 등록할 뷰객체의 id값이다)
	public String downlaod(Model model,HttpServletRequest req) {
		/*컨트롤러 메소드에서는 다운로드할 파일을 
		모델에 저장만 하면됨]
		File객체를 생성해서 모델계열에 저장만 하면
		컨트롤러의 역할은 끝남.
		즉 Model이나 Map이나 ModelMap으로만.*/
		//1]파일 객체 생성
		String path = req.getSession().getServletContext().getRealPath("/images");
		String cno = req.getParameter("cno");
		String filename = req.getParameter("filename");
		File file = new File(path + File.separator + "chat_no" + cno + File.separator + filename);
		//2]모델에 파일객체 저장-다운로드 처리용 View객체의 메소드의 매개변수인 Map으로 전달됨
		model.addAttribute("file", file);
		model.addAttribute("cno", cno);
		//3]반환값은 빈 설정파일에 등록한 다운로드 처리용 View객체의 id속성에 지정한 값.
		System.out.println("DownloadController return만 남음");
		return "downloadView";
	}
}

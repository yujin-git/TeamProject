package com.moegga.app.web;

import java.text.DateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.moegga.app.service.AdminService;
import com.moegga.app.service.KakaoService;
import com.moegga.app.service.impl.MemberDAO;
import com.moegga.app.service.impl.TownDAO;


@Controller
public class KakaoController {
   
   @Resource(name="kakaoService")
    private KakaoService kakaoService;
   
   @RequestMapping("/kakaoLogin")
   public String login(@RequestParam("code") String code, HttpSession session) {
      System.out.println("code:"+code);
      String access_Token = kakaoService.getAccessToken(code);
       
       HashMap<String, Object> userInfo = kakaoService.getUserInfo(access_Token);
       System.out.println("토큰:"+access_Token);
       session.setAttribute("access_Token", access_Token);
       
       System.out.println("login Controller : " + userInfo);
       
       //    클라이언트의 이메일이 존재할 때 세션에 해당 이메일과 토큰 등록
      
          session.setAttribute("userId", userInfo.get("nickname"));
           
       System.out.println("카카오톡 로그인 성공!");
       return "index.tiles";
   }

   
   @RequestMapping("/kakaoLogout")
   public String logout(HttpSession session) {
      System.out.println("logout here");
      System.out.println(session.getAttribute("access_Token"));
      kakaoService.kakaoLogout((String)session.getAttribute("access_Token"));
      session.removeAttribute("access_Token");
      System.out.println(session.getAttribute("userId"));
       session.removeAttribute("userId");
       System.out.println("카카오톡 로그아웃!");
       return "index.tiles";
   }

   

}
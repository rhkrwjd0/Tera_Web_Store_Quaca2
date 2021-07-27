package com.quaca.tera.login.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.quaca.common.vo.UserVO;

@Controller
public class LoginController {
	private static final String SERVER_URL = "https://tera-energy.github.io/Tera_Quaca_Common/server.json";
	// 로그인 화면
	@RequestMapping(value = "/quaca/login", method = RequestMethod.GET)
	public String login() {
		return "/quaca/login/login";
	}
	
	// 로그인 처리 api 활용
	@RequestMapping(value = "/quaca/loginCheck", method = RequestMethod.POST)
	public String loginCheck(HttpSession session, RedirectAttributes ra, UserVO userVO
			, HttpServletResponse response
			//, @CookieValue(value="count", defaultValue="1", required=true) String value
			) throws MalformedURLException, IOException {
		
		
		String returnURL = "";
		UserVO vo = new UserVO();
		
		if(session.getAttribute("userInfo") != null) {
			// 기존에 login이란 세션 값이 존재 한다면... 
			session.removeAttribute("userInfo"); // 기존 값을 제거 해준다.
		}
		
		
		

        HttpURLConnection conn = null;
        JSONObject responseJson = null;
        JSONObject store_WEB = null;		// STORE_WEB JSON INFO
        String serverUrl = "";				// WEB API URL 
        
        try {
        	// STORE_WEB API 정보 가져오기 
            URL url = new URL(SERVER_URL);

            conn = (HttpURLConnection)url.openConnection();
            conn.setConnectTimeout(5000);
            conn.setReadTimeout(5000);
            conn.setRequestMethod("GET");

            int responseCode = conn.getResponseCode();
            if (responseCode == 400 || responseCode == 401 || responseCode == 500 ) {
                System.out.println(responseCode + " Error!");
            } else {
            	BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
                StringBuilder sb = new StringBuilder();
                String line = "";
                while ((line = br.readLine()) != null) {
                    sb.append(line);
                }
                
                responseJson = new JSONObject(sb.toString());
                store_WEB = new JSONObject(responseJson.get("store_WEB").toString());
                serverUrl = store_WEB.get("serverUrl").toString();
                
                
                // 로그인 유저 정보 json 파일 가져오기 
                //JSONObject userInfo = new JSONObject(responseBf.toString());
                JSONObject userInfo = userInfoFunction(userVO, serverUrl);
                //System.out.println("!@"+userInfoFunction(userVO, serverUrl).length());
                if(userInfo.length() == 0) {
                	userInfo = userInfoFunction(userVO, "http://192.168.0.3:10030/");
                }
                boolean success = (boolean) userInfo.get("success");
                // 정보를 가져올 경우 
                if(success) {
                	JSONObject info = new JSONObject(userInfo.get("info").toString());
                	vo = new UserVO();
                	vo.setSeq(info.get("Seq").toString());
                	vo.setSid(info.get("SID").toString());
                	vo.setPassword(info.get("PassWord").toString());
                	vo.setStoreId(info.get("StoreId").toString());
                	vo.setToken(info.get("Token").toString());
                	vo.setTelNo(info.get("TelNo").toString());
                	vo.setUseYn(info.get("UseYn").toString());
                	vo.setInsertDt(info.get("InsertDt").toString());
                	vo.setTheme(info.get("Theme").toString());
                	vo.setStoreName(info.get("StoreName").toString());
                	
                	session.setAttribute("userInfo", vo); // 세션에 login인이란 이름으로 UsersVO 객체를 저장해 놈.
                	session.setMaxInactiveInterval(60*60*24);	// 세션 시간 유지(24시간) 
                	
                	
                    returnURL = "redirect:/quaca/main"; // 로그인 성공시 메인페이지로 이동하고
                }else {
                	// 로그인 실패 할 경우 
                	ra.addFlashAttribute("msg", "로그인 실패하였습니다.");
                	ra.addFlashAttribute("url", "/quaca/login");
                	
                	return "redirect:/quaca/alert";
                }

            }
        } catch (MalformedURLException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } catch (JSONException e) {
            System.out.println("not JSON Format response");
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }

		return returnURL;
	}
	
	// 비밀번호 화면
	@RequestMapping(value = "/quaca/passwordFind", method = RequestMethod.GET)
	public String passwordFind(Locale locale, Model model) {
		return "/quaca/login/passwordFind";
	}
	
	
    // 로그아웃 하는 부분
    @RequestMapping(value="/quaca/logout")
    public String logout(HttpSession session) {
        session.invalidate(); // 세션 초기화
        return "redirect:/quaca/login"; // 로그아웃 후 로그인화면으로 이동
    }
    
	// 함수 구간(유저 정보 가져오기)
    public JSONObject userInfoFunction(UserVO userVO, String serverUrl) throws IOException{
    	System.out.println("!@!@접속 url :: "+serverUrl);
    	//serverUrl = "http://192.168.0.3:10030/";
        // 로그인 API 처리 
    	JSONObject userInfoData= new JSONObject();
    	try {
    		Map<String, Object> params = new HashMap<String, Object>();
    		params.put("SID", userVO.getSid());
    		params.put("PassWord", userVO.getPassword());
    		
    		StringBuilder postData = new StringBuilder();
    		for(Map.Entry<String,Object> param : params.entrySet()) {
    			if(postData.length() != 0) postData.append('&');
    			postData.append(param.getKey());
    			postData.append('=');
    			postData.append(param.getValue());
    		}
    		
    		byte[] postDataBytes = postData.toString().getBytes("UTF-8");
    		URL loginUrl = new URL(serverUrl+"users/login");
    		
    		HttpURLConnection con = (HttpURLConnection)loginUrl.openConnection();
    		con.setRequestMethod("POST");
    		con.setRequestProperty("Content-Length", String.valueOf(postDataBytes.length));
    		con.setDoOutput(true);
    		con.getOutputStream().write(postDataBytes);
    		
    		BufferedReader in = new BufferedReader(
    				new InputStreamReader(con.getInputStream(), "UTF-8")
    				);
    		String inputLine;
    		StringBuffer responseBf = new StringBuffer();
    		while((inputLine = in.readLine()) != null){
    			responseBf.append(inputLine);
    		}
    		in.close();
    		//return new JSONObject(responseBf.toString());
    		userInfoData = new JSONObject(responseBf.toString());
    	} catch (Exception e) {
    		System.out.println("!@!@"+e);
		}
    	return userInfoData;
    	
    }
}

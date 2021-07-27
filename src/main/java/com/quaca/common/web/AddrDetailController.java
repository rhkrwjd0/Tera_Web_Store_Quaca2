package com.quaca.common.web;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class AddrDetailController {

	
	//String kakaoRestAppKey = "1c9d57bfdb8c196983503366b7b0d719";
	// 주소로 위도 경도, 지역 명 구하는 api
	@RequestMapping(value={"/getAddrDetail"}, method={RequestMethod.GET})
	public @ResponseBody Object getAddrDetail(String addr, String kakaoRestAppKey) throws Exception {
		String token =  kakaoRestAppKey;
		String header = "KakaoAK "+token;
		StringBuffer response = new StringBuffer();
		try {
			
			String apiURL = "http://dapi.kakao.com/v2/local/search/address.json";
			URL url = new URL(apiURL);
			HttpURLConnection con = (HttpURLConnection)url.openConnection();
			con.setRequestMethod("GET");
		    con.setRequestProperty("Authorization", header);
		    
		    String params = "query="+URLEncoder.encode(addr, "UTF-8");
		    con.setDoOutput(true);
		    DataOutputStream wr = new DataOutputStream(con.getOutputStream());
		    wr.writeBytes(params);
		    wr.flush();
		    wr.close();
		    int responseCode = con.getResponseCode();
		    BufferedReader br;
		    if(responseCode==200) { // 정상 호출
		        br = new BufferedReader(new InputStreamReader(con.getInputStream()));
		    } else {  // 에러 발생
		            br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
		        }
		        String inputLine;
		        while ((inputLine = br.readLine()) != null) {
		            response.append(inputLine);
		        }
		        br.close();
		} catch (Exception e) {
				e.printStackTrace();
				
		} 
		return response.toString();
	}
	
}

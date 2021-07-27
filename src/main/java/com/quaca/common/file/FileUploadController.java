package com.quaca.common.file;
import java.io.File;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.quaca.common.vo.FileVO;

@Controller
public class FileUploadController {
	// 파일 테스트 page(20210602)
    @RequestMapping(value = "/textFileUpLoad", method = RequestMethod.GET)
    public ModelAndView getFilePage() {
        ModelAndView mav = new ModelAndView();
        return mav;
    }
    
    // 파일 업로드 기능 & 정보 추출(20210602)
	@RequestMapping(value = "/file/upload", produces="application/json", method = RequestMethod.POST)
	@ResponseBody 
	public Map<String, Object> upload(FileVO fileVO, HttpServletRequest request){
		
		FileVO vo = new FileVO();
		Map<String, Object> map = new HashMap<String, Object>();

		map.put("return", false);	// 초기 설정(false)
		MultipartFile mf = fileVO.getFile();
		
		try {
				
			if(!mf.isEmpty()){
				vo = new FileVO();
						
				long fileSize = mf.getSize();									// 사이즈
				String fileOrgNm = mf.getOriginalFilename();					// 실제 파일명 
				String ext = fileOrgNm.substring(fileOrgNm.lastIndexOf("."));	// 확장자
				String fileEncNm = UUID.randomUUID().toString().replaceAll("-", "") + ext;			// 저장 파일명
				String path  = "resources/upload/"+fileVO.getStoreId()+"/"+fileVO.getType()+"/";	// 저장할 위치 경로 
				String root_path = request.getSession().getServletContext().getRealPath("/");		// 상대 경로 
				String filePath = root_path+path;													// 전체 경로
				
				vo.setStoreId(fileVO.getStoreId());			// 매장 Id
				vo.setType(fileVO.getType());				// 구분(M : 메뉴, S : 매장)
				vo.setFileEncNm(fileEncNm);					// 저장 파일 명
				vo.setFileOrgNm(fileOrgNm);					// 실제 파일 명
				vo.setFilePath(path);						// 파일 저장 경로
				vo.setFileSize(String.valueOf(fileSize));	// 파일 사이즈
				vo.setFileType(ext);						// 파일 확장자
				System.out.println("***************************");
				System.out.println("size = "+ fileSize);
				System.out.println("realFileName = "+ fileOrgNm);
				System.out.println("fileExt = "+ ext);
				System.out.println("saveFileName = "+ fileEncNm);
				System.out.println("filePath = "+ filePath);
				System.out.println("***************************");
				File file = new File(filePath);
				
				//경로가 존재하지 않을 경우 디렉토리를 만든다.
				if(file.exists() == false){
					file.mkdirs();
				}
				// 상대 경로에 저장파일명으로 save 처리
				mf.transferTo(new File(filePath + fileEncNm));  
				
				map.put("return", true);
				map.put("vo", vo);
			}
		} catch (Exception e) {
			// TODO: handle exception
			//map.put("return", false);
			System.out.println(e.getMessage());
		}
		return map;
	}
    
}

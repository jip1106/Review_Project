package memberReviewBoard.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import memberReviewBoard.model.service.ReviewBoardService;
import memberReviewBoard.model.vo.ReviewBoard;

/**
 * Servlet implementation class ReviewUpdateServlet
 */
@WebServlet("/reviewUpdate")
public class ReviewUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReviewUpdateServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//원글 수정 처리용 컨트롤러
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8"); 
		
		//업로드할 파일의 용량 제한 : 10Mbyte 로 제한한다면
		int maxSize = 1024 * 1024 * 10;
		
		//enctype="multipart/form-data" 로 전송되었는지 확인
		RequestDispatcher view = null; 
		
		//해당 컨테이너에서 구동중인 웹 애플리케이션의 루트 경로 알아냄
		String root = request.getSession().getServletContext().getRealPath("/");
		//업로드되는 파일이 저장될 폴더명과 루트 경로 연결 처리
		String savePath = root + "uploadfile";
		//web/buploadfiles 로 지정됨
		
		//request 를 MultipartRequest 객체로 변환함
		//자동 지정된 경로에 파일 저장됨
		MultipartRequest mrequest = new MultipartRequest(request, savePath,
				maxSize, "UTF-8", new DefaultFileRenamePolicy());
		
		int reviewNo = Integer.parseInt(mrequest.getParameter("no"));
		String writer = mrequest.getParameter("writer");
		String title = mrequest.getParameter("title");
		String content = mrequest.getParameter("content");
		String address = mrequest.getParameter("address");
		String location = mrequest.getParameter("location");
		String category = mrequest.getParameter("category");
		String storename = mrequest.getParameter("storename");
		int evaluation = Integer.parseInt(mrequest.getParameter("star-input"));
		String oFileName = mrequest.getParameter("ofile"); 
		String rFileName = mrequest.getParameter("rfile");
		int currentPage = Integer.parseInt(mrequest.getParameter("page"));
		String originalFileName = mrequest.getFilesystemName("image");
		
		ReviewBoard review = null;
		ReviewBoardService rservice = new ReviewBoardService();
		int result = 0;
		if(originalFileName != null && !oFileName.equals(originalFileName)){
			//업로드된 파일이 있을 경우, 파일명을 "년월일시분초.확장자"로 변경함
			SimpleDateFormat sdf = 
					new SimpleDateFormat("yyyyMMddHHmmss");
			String renameFileName = sdf.format(
					new java.sql.Date(System.currentTimeMillis())) + "."
					+ originalFileName.substring(
							originalFileName.lastIndexOf(".") + 1);
			
			//업로드되어 있는 원래 파일의 이름을 새 이름으로 바꾸기
			File originalFile = new File(savePath + "\\" + originalFileName);
			File renameFile = new File(savePath + "\\" + renameFileName);
			
			//파일이름 바꾸기 실행 >> 실패시 직접 바꾸기함
			//새 파일 만들고, 원래 파일의 내용 읽어서 복사 기록하고
			//원 파일 삭제함
			if(!originalFile.renameTo(renameFile)){
				int read = -1;
				byte[] buf = new byte[1024];
				
				FileInputStream fin = new FileInputStream(originalFile);
				FileOutputStream fout = new FileOutputStream(renameFile);
				
				while((read = fin.read(buf, 0, buf.length)) != -1)
					fout.write(buf, 0, read);
				
				fin.close();
				fout.close();
				originalFile.delete();
				new File(savePath + "/" +rFileName).delete();
			}
			review = new ReviewBoard(reviewNo,writer,title,content,location,category,address,storename,originalFileName,renameFileName,evaluation);
			
		}else{  //첨부 파일이 없거나, 첨부파일이 변경되지 않았다면
			review = new ReviewBoard(reviewNo,writer,title,content,location,category,address,storename,oFileName,rFileName,evaluation);
			
		}
		
		result = rservice.reviewUpdate(review); 
		
		if(result > 0){
			response.sendRedirect("/review/reviewList?page="+currentPage);
		}
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}

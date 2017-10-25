package adminSharedComment.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import adminSharedComment.model.service.SharedCommentService;
import memberSharedComment.model.vo.SharedComment;

/**
 * Servlet implementation class AdminDeleteShareCommentServlet
 */
@WebServlet("/admindeletesc")
public class AdminDeleteShareCommentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminDeleteShareCommentServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("application/json; charset=utf-8");
		
		int commentNo = Integer.parseInt(request.getParameter("cNo"));
		int shareNo = Integer.parseInt(request.getParameter("shareNo"));
		SharedCommentService service = new SharedCommentService();
		
		int result = service.deleteSharedComment(commentNo,shareNo);  
		
		ArrayList<SharedComment> list = null;
		
		if(result > 0){
			list = service.selectSharedComment(shareNo);
		}
		
		//json 객체 하나만 내보낼 수 있음
		//json 배열을 json 객체에 저장함
		//내보낼 json 객체 선언
		JSONObject job = new JSONObject();
		//list 옮겨담을 json 배열 선언
		JSONArray jarr = new JSONArray(); 
		
		for(SharedComment comment : list){
			//user 객체 한 개를 저장할 json 객체 선언
			JSONObject j = new JSONObject(); 
			j.put("commentNo", comment.getCommentNo());
			j.put("postingNo", comment.getPostingNo()); 
			j.put("userId", URLEncoder.encode(comment.getId(),"UTF-8"));
			j.put("content",URLEncoder.encode(comment.getCommentContent(),"UTF-8"));
			Date from = new Date(); 
			SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String to = transFormat.format(from);
			j.put("timePosted", to);
			
			jarr.add(j);
		}
		
		job.put("list",jarr);
		System.out.println("job : " +job.toJSONString()); 
		PrintWriter pw = response.getWriter();
		pw.print(job.toJSONString());
		pw.flush();
		pw.close(); 
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}

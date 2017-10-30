package memberSharedComment.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import adminComplainComment.model.service.ComplainCommentService;
import memberComplainComment.model.vo.ComplainComment;
import memberSharedComment.model.service.SharedCommentService;
import memberSharedComment.model.vo.SharedComment;

/**
 * Servlet implementation class SharedCommentListViewServlet
 */
@WebServlet("/shareComment.do")
public class SharedCommentListViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SharedCommentListViewServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 정보공유 게시판 댓글 ajax로 보여주기 위한 서블릿
				request.setCharacterEncoding("utf-8");
				response.setContentType("aplication/json; charset=utf-8");
				
				int postNum = Integer.parseInt(request.getParameter("postNum"));
				
				SharedCommentService scommentService = new SharedCommentService();
				
				ArrayList<SharedComment> list = scommentService.viewSharedComment(postNum);
				
				JSONObject job = new JSONObject();
				
				JSONArray jarr = new JSONArray();
				
				for(SharedComment comment : list){
					JSONObject j = new JSONObject();
					j.put("commentNo", comment.getCommentNo());
					j.put("postNo", comment.getPostingNo());
					j.put("id", URLEncoder.encode(comment.getId(),"UTF-8"));
					j.put("content", URLEncoder.encode(comment.getCommentContent(),"UTF-8"));
					j.put("date", URLEncoder.encode(comment.getCommentStringDate(),"UTF-8"));
					
					jarr.add(j);
					
				}
				
				job.put("list", jarr);
				
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

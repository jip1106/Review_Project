package memberReviewComment.controller;

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

import memberReviewComment.model.service.ReviewCommentService;
import memberReviewComment.model.vo.ReviewComment;


/**
 * Servlet implementation class ReviewCommentListServlet
 */
@WebServlet("/reviewcomment.do")
public class ReviewCommentListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReviewCommentListServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 리뷰게시판 댓글 보여주기 위한 서블릿
				request.setCharacterEncoding("utf-8");
				response.setContentType("aplication/json; charset=utf-8");
			
				int postNum = Integer.parseInt(request.getParameter("postNum"));
			
				ReviewCommentService rcommentService = new ReviewCommentService();
				
				ArrayList<ReviewComment> list = rcommentService.viewReviewComment(postNum);
				
				JSONObject job = new JSONObject();
				JSONArray jarr = new JSONArray();
				
				for(ReviewComment comment : list){
					JSONObject j = new JSONObject();
					j.put("commentNo", comment.getCommentNo());
					j.put("postNo", comment.getPostingNo());
					j.put("id", URLEncoder.encode(comment.getId(),"UTF-8"));
					j.put("content", URLEncoder.encode(comment.getCommentContent(),"UTF-8"));
					j.put("date", URLEncoder.encode(comment.getDate(),"UTF-8"));
					
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

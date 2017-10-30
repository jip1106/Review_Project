package memberReviewBoard.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import member.model.vo.Member;
import memberReviewBoard.model.service.ReviewBoardService;
import memberReviewBoard.model.vo.ReviewBoard;
import memberReviewComment.model.vo.ReviewComment;

/**
 * Servlet implementation class ReviewLikeUpServlet
 */
@WebServlet("/reviewLikeUp")
public class ReviewLikeUpServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReviewLikeUpServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		ReviewBoardService rservice = new ReviewBoardService();
		int reviewNo = Integer.parseInt(request.getParameter("no"));
		String writer = request.getParameter("writer");
		int currentPage = Integer.parseInt(request.getParameter("page"));
	
		int result = rservice.reviewLikeUp(reviewNo,writer);
	    
		ReviewBoard review1 = rservice.reviewDetail(reviewNo); 
		
		ArrayList<ReviewComment> list = rservice.selectCommentList(reviewNo);
		
		RequestDispatcher view = null;
		if(result == 1){
			view = request.getRequestDispatcher("views/reviewboard/reviewboardDetail.jsp");
			request.setAttribute("review",review1);
			request.setAttribute("currentPage", currentPage);
			request.setAttribute("commentList", list);
			view.forward(request, response);
		}
		
		if(result == 2){
			view = request.getRequestDispatcher("views/reviewboard/likeUpFail.jsp");
			request.setAttribute("reviewNo", review1.getPosting_no());
			request.setAttribute("currentPage", currentPage);
			view.forward(request, response);
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

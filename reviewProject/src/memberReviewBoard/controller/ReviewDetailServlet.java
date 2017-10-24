package memberReviewBoard.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import memberReviewBoard.model.service.ReviewBoardService;
import memberReviewBoard.model.vo.ReviewBoard;
import memberReviewComment.model.vo.ReviewComment;

/**
 * Servlet implementation class ReviewDetailServlet
 */
@WebServlet("/ReviewDetail")
public class ReviewDetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReviewDetailServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html charset=utf-8");
		
		int reviewNo = Integer.parseInt(request.getParameter("no"));
		int currentPage = Integer.parseInt(request.getParameter("page"));
		
		ReviewBoardService rservice = new ReviewBoardService(); 
		
		int result = rservice.reviewHitUp(reviewNo);  
		
		ReviewBoard review = rservice.reviewDetail(reviewNo);
		ArrayList<ReviewComment> list = rservice.selectCommentList(reviewNo);
		
		if(review != null && result > 0){
			RequestDispatcher view = request.getRequestDispatcher("views/reviewboard/reviewboardDetail.jsp");
			request.setAttribute("review", review);
			request.setAttribute("currentPage", currentPage);
			request.setAttribute("commentList", list);
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

package adminReviewBoard.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import adminReviewBoard.model.service.ReviewBoardService;
import memberReviewBoard.model.vo.ReviewBoard;

/**
 * Servlet implementation class AdminReviewLikeUpServlet
 */
@WebServlet("/adminReviewLikeUp")
public class AdminReviewLikeUpServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminReviewLikeUpServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//좋아요 수 증가
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		String id = request.getParameter("id"); //좋아요를 누른 로그인한 회원
		int postNo = Integer.parseInt(request.getParameter("postNo")); //리뷰게시판 게시글 번호
		int currentPage = Integer.parseInt(request.getParameter("page"));
		
		ReviewBoardService rservice = new ReviewBoardService();
				
		//likes 테이블에 있는지 확인 하기위한 변수
		int checkLikesInsert= rservice.checkLikesInsert(id,postNo);
		
		
		RequestDispatcher view =null;
		
		if(checkLikesInsert==1){ //좋아요 테이블에 있으면
			//알터창
			view = request.getRequestDispatcher("views/admin/board/reviewboard/adminLikeUpFail.jsp");
			request.setAttribute("page", currentPage);
			request.setAttribute("postNo", postNo);
			view.forward(request, response);

		}else{//없으면
			int checkLike = rservice.likeCheck(id,postNo); //좋아요테이블에 insert
				
			if(checkLike >0){//insert가 됬으면
				rservice.addLikeCount(postNo); //좋아요 증가
				ReviewBoard board= rservice.getReviewBoard(postNo);
				view = request.getRequestDispatcher("views/admin/board/reviewboard/adminreviewDetail.jsp");
				request.setAttribute("board", board);
				
				view.forward(request, response);
			}
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

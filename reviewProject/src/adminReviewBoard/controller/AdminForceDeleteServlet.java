package adminReviewBoard.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import adminReviewBoard.model.service.ReviewBoardService;

/**
 * Servlet implementation class AdminForceDeleteServlet
 */
@WebServlet("/adminForceDelete")
public class AdminForceDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminForceDeleteServlet() {
        super();
      
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 관리자가 리뷰게시판 게시물 삭제하기 위한 메서드
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		ReviewBoardService rservice = new ReviewBoardService();
		int currentPage = Integer.parseInt(request.getParameter("page"));	
		int limit = Integer.parseInt(request.getParameter("limit"));
		
		int postNo = Integer.parseInt(request.getParameter("postNo"));
		int listCount = (rservice.getReviewListCount())%limit;	//한 페이지에 있는 게시글의 갯 수
		
		int result = rservice.forceDeleteReviewBoard(postNo);
			
		
		if(result>0){
			if(listCount ==1 && currentPage!=1){	//현재 페이지가 1페이지가 아니고, 게시물이 1개 남았으면 이전 페이지로
				response.sendRedirect("/review/adminReviewList?page="+(currentPage-1));
				
			}else{ //게시물이 1개 안남아있으면 원래 페이지로
				response.sendRedirect("/review/adminReviewList?page="+(currentPage));				
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

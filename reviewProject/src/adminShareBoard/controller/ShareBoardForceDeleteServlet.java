package adminShareBoard.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import adminComplainBoard.model.service.ComplainBoardService;
import adminShareBoard.model.service.ShareBoardService;

import javax.servlet.*;

import memberSharedBoard.model.service.SharedBoardService;

/**
 * Servlet implementation class ShareBoardForceDelete
 */
@WebServlet("/adminsbfdelete")
public class ShareBoardForceDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ShareBoardForceDeleteServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//정보공유게시판 글 삭제 처리용 컨트롤러
		response.setContentType("text/html; charset=utf-8");
		
		int postingNum = Integer.parseInt(request.getParameter("no"));
		int currentPage = Integer.parseInt(request.getParameter("currentPage"));
		int limit = Integer.parseInt(request.getParameter("limit"));
		int endPage = Integer.parseInt(request.getParameter("endPage"));
		
		ShareBoardService sb = new ShareBoardService();
		
		int listCount = sb.getShareBoardListCount();
		int pagelistCount = 0;
		
		if(currentPage == endPage){
			pagelistCount = listCount % limit;
		}else{
			pagelistCount = limit;
		}
		
		int result = sb.deleteShareBoard(postingNum);
		
		if(result>0){
			if((pagelistCount)==1 && currentPage!=1)
				response.sendRedirect("/review/adminsblist?page="+(currentPage-1));
			else
				response.sendRedirect("/review/adminsblist?page=" + currentPage);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}

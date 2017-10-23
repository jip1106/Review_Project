package adminComplainBoard.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import adminComplainBoard.model.service.ComplainBoardService;


/**
 * Servlet implementation class ComplainBoardForceDelete
 */
@WebServlet("/cbfdelete")
public class ComplainBoardForceDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ComplainBoardForceDeleteServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 신고 게시판 메인쪽 에서 삭제하기 위한 서블릿
		response.setContentType("type/html; charset=utf-8");
		
		int postingNum = Integer.parseInt(request.getParameter("postno"));
		int currentPage = Integer.parseInt(request.getParameter("currentPage"));
		int limit = Integer.parseInt(request.getParameter("limit"));
		int endPage = Integer.parseInt(request.getParameter("endPage"));
		
		ComplainBoardService cbservice = new ComplainBoardService();
		
		
		
		int listCount = cbservice.getComplainBoardListCount(); //전체 글수
		int pagelistCount = 0;
		
		if(currentPage == endPage){
			pagelistCount = listCount % limit;	//페이지 글 수
		}else{
			pagelistCount = limit;
		}
		
		
		int result = cbservice.deleteComplainBoard(postingNum);
		
		if(result>0){
			if((pagelistCount)==1 && currentPage!=1){	//전체 삭제했을때 페이지 바 가 -1로 가면 안됨
				response.sendRedirect("/review/cblist?page="+(currentPage-1));
				
			}
			else{				
				response.sendRedirect("/review/cblist?page=" + currentPage);
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

package adminComplainBoard.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import adminComplainBoard.model.service.ComplainBoardService;
import memberComplainBoard.model.vo.ComplainBoard;



/**
 * Servlet implementation class ComplainBoadDetailForceDeleteServlet
 */
@WebServlet("/cbdfDelete")
public class ComplainBoadDetailForceDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ComplainBoadDetailForceDeleteServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//상세보기 에서 삭제하기 위한 서블릿
		//2,3페이지에서 전부 삭제하면 전 페이지로 돌아가게 하는거 아직 못했음......ㅠㅠ
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html5;charset=utf-8");
		
		int postNo = Integer.parseInt(request.getParameter("postno"));
		int currentPage = Integer.parseInt(request.getParameter("currentPage"));
		int limit = Integer.parseInt(request.getParameter("limit"));
		int endPage = Integer.parseInt(request.getParameter("endPage"));
		
		ComplainBoardService cbservice = new ComplainBoardService();
		
		int listCount = cbservice.getComplainBoardListCount();
		int pagelistCount = 0;
		
		if(currentPage == endPage){
			pagelistCount = listCount%limit;
			System.out.println("현재 페이지 : " + currentPage);
			System.out.println("마지막 페이지 : " + endPage);
			System.out.println("상세보기 강제삭제 서블릿 에서 pagelist는 1이 나와야되는 상황 : " + pagelistCount);
		}else{
			pagelistCount = limit;
		}
		
		int result = cbservice.deleteComplainBoard(postNo);
		
	
		if(result>0){
			if( (pagelistCount)==1 && currentPage!=1){
				response.sendRedirect("/review/cblist?page="+(currentPage-1));
			}
			else{
				response.sendRedirect("/review/cblist?page="+currentPage);
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

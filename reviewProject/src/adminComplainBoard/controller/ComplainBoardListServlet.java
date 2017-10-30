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
import memberComplainBoard.model.vo.ComplainBoard;

/**
 * Servlet implementation class NoticeListServlet
 */
@WebServlet("/cblist")
public class ComplainBoardListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ComplainBoardListServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//page를 변수로 받음.. page 없으면 널포인트 에러
		
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		String searchValue = request.getParameter("searchValue");
		String searchMenu = request.getParameter("searchMenu");
			
		int currentPage = 1;
		int limit =5;
		
		//페이지 숫자가 전송이 왔을 경우
		if(request.getParameter("page") !=null){
			currentPage = Integer.parseInt(request.getParameter("page"));
			
		}
		
		ComplainBoardService cbservice = new ComplainBoardService();
		
		int listCount = 0;
		//게시글 갯수 조회
		
		if(request.getParameter("searchValue")==null){
			listCount = cbservice.getComplainBoardListCount();
		}else{
			System.out.println("searchValue 값 : "+searchValue);
			listCount = cbservice.getSearchCount(searchValue, searchMenu);			
		}		
		
		//해당 페이지용 목록 조회
		ArrayList<ComplainBoard> list = cbservice.viewComplainBoardList(currentPage,limit);
		
		if(request.getParameter("searchValue")==null){
			list = cbservice.viewComplainBoardList(currentPage, limit);
		}else{
			if(searchMenu.equals("findByWriter")){ 			
				list = cbservice.viewSearchById(searchValue,currentPage,limit);
			}
			else if(searchMenu.equals("findByTitle")){
				list = cbservice.viewSearchByTitle(searchValue,currentPage,limit);
			}
			
		}				
		int maxPage = (int)((double)(listCount)/limit+0.9); //총 페이지 수
		
		int startPage = ((int)((double)currentPage/limit + 0.9)-1)*limit +1 ;
		
		int endPage = startPage + limit-1;
		
		if(maxPage<endPage){
			endPage = maxPage;
		}
		
		RequestDispatcher view = null;	
		
		//System.out.println("list!!!!============"+list);
		if(list!=null){
			view = request.getRequestDispatcher("views/admin/board/complainboard/admincomplainboard.jsp");
			request.setAttribute("list", list);
			request.setAttribute("currentPage", currentPage);
			request.setAttribute("startPage", startPage);
			request.setAttribute("endPage", endPage);
			request.setAttribute("maxPage", maxPage);
			request.setAttribute("listCount", listCount);
			request.setAttribute("limit", limit);
			
			if(request.getParameter("searchValue")!=null){
				request.setAttribute("searchValue", searchValue);
			}
			
			if(request.getParameter("searchMenu")!=null){
				request.setAttribute("searchMenu", searchMenu);
			}
			
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

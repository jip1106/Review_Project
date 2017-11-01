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
 * Servlet implementation class AdminSearchServlet
 */
@WebServlet("/adminSearch")
public class AdminSearchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminSearchServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//검색 서블릿
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		String searchLocation = request.getParameter("searchLocation");		
		String searchCategory = request.getParameter("searchCategory");	
		String storeName =request.getParameter("storeName"); 
		System.out.println("써치 서블릿 장소 " + searchLocation);
		System.out.println("써치 서블릿 카테고리 " + searchCategory);
		System.out.println("써치 서블릿 가게명 " + storeName);
				
		System.out.println("장소검색 : " + searchLocation + " 장소검색 길이 : " + searchLocation.length());

		
		int listCount =0;
		
		int currentPage =Integer.parseInt(request.getParameter("page"));
		
		int limit = 9;
						
		ReviewBoardService rservice = new ReviewBoardService();
		ArrayList<ReviewBoard> list = new ArrayList<ReviewBoard>();
		
		if(searchCategory ==null || searchCategory.trim()=="" ){	//장소검색
			listCount = rservice.getSearchByLocationCount(searchLocation,storeName);
			list = rservice.getSearchByLocationList(currentPage,limit,searchLocation, storeName);
			System.out.println("써치 서블릿 장소 검색 리스트 : " + list);
			System.out.println("써치 서블릿 장소 검색 카운트 : " + listCount);
		}
		
		if(searchLocation==null || searchLocation.trim()=="" ){	//카테고리 검색
			listCount = rservice.getSearchByCategoryCount(searchCategory,storeName);
			list = rservice.getSearchByCategoryList(currentPage,limit,searchCategory, storeName);
			System.out.println("써치 서블릿 카테고리 검색 리스트 : " + list);
			System.out.println("써치 서블릿 카테고리 검색 카운트 : " + listCount);
		}
		
		if(searchLocation.trim()!="" && searchCategory.trim()!=""){
			listCount = rservice.getSearchAllCount(searchCategory, searchLocation, storeName);
			list = rservice.getSearchByAllList(currentPage, limit, searchCategory, searchLocation, storeName);
			System.out.println("둘다 검색 : " + list);
			System.out.println("둘다 검색 카운트: " + listCount);
		}
			
			
		int maxPage = (int)((double)listCount/limit + 0.9);
		
		int startPage = ((int)((double)currentPage / limit + 0.9) - 1) * limit + 1;
	
		int endPage = startPage + limit - 1;
		
		if(maxPage < endPage){
			endPage = maxPage;
		}
			
		if(list!=null){
			RequestDispatcher view = request.getRequestDispatcher("views/admin/board/reviewboard/adminreviewboard.jsp");
			request.setAttribute("list", list);
			request.setAttribute("listCount", listCount);
			request.setAttribute("currentPage", currentPage);
			request.setAttribute("startPage", startPage);
			request.setAttribute("endPage", endPage);
			request.setAttribute("maxPage", maxPage);
			
			request.setAttribute("searchLocation", searchLocation);
			request.setAttribute("searchCategory", searchCategory);
			request.setAttribute("storeName", storeName);
			
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

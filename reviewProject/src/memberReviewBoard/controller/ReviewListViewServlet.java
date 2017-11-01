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

/**
 * Servlet implementation class ReviewListViewServlet
 */
@WebServlet("/reviewList")
public class ReviewListViewServlet extends HttpServlet {
   private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReviewListViewServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

   /**
    * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
    */
   protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      request.setCharacterEncoding("utf-8");
      response.setContentType("text/html; charset=utf-8");
      // 페이지 처리용
      int currentPage = 1;
      // 한 페이지에 출력할 페이지 갯수 지정
      int limit = 9; 

      // 페이지 숫자가 전송이 왔을 경우
      if (request.getParameter("page") != null) {
         currentPage = Integer.parseInt(request.getParameter("page"));
      }
      
      ReviewBoardService rservice = new ReviewBoardService();
      ArrayList<ReviewBoard> list = new ArrayList<ReviewBoard>();
      //전체 목록 갯수 조회함
      int listCount = 0; 
      
      String location = request.getParameter("findLocationType");
      System.out.println(location);
      String category = request.getParameter("findCategoryType");
      System.out.println(category);
      String searchKeyWord = request.getParameter("searchKeyWord");
      System.out.println(searchKeyWord);
      
      //해당 페이지용 목록 조회
      if(location == null && category == null){
          listCount = rservice.getReviewListCount();
          System.out.println(listCount);
          list = rservice.selectReview(currentPage, limit);
      }else if(category == null || category.trim() == ""){
          listCount = rservice.getReviewLocationListCount(location,searchKeyWord);
          System.out.println(listCount);
          list = rservice.reviewSearchList(currentPage,limit,location,category,searchKeyWord);  
      }else if(location == null || location.trim() == ""){
         listCount = rservice.getReviewCategoryListCount(category,searchKeyWord);
         System.out.println(listCount);
         list = rservice.reviewSearchList(currentPage,limit,location,category,searchKeyWord);
      }else if(location != null && category != null){
         listCount = rservice.getReviewAllListCount(category,location,searchKeyWord);
         System.out.println(listCount);
         list = rservice.reviewSearchList(currentPage,limit,location,category,searchKeyWord);
      }
      
      //총 페이지 수 계산 : 목록이 최소 1개일 때는 한 페이지로 처리함
      //페이지 1이 되려면 = 목록 0.1 개  + 0.9 계산되게 함
      int maxPage = (int)((double)listCount / limit + 0.9);
      //현재 페이지가 13이면 화면에 보여줄 시작 페이지는 11로 지정
      //(1, 11, 21, 31 ....)
      int startPage = ((int)((double)currentPage / limit + 0.9) - 1) * limit + 1;
      //만약, 목록 아래에 보여질 페이지 갯수가 10개이면 
      //현재 페이지가 13 이면 끝 페이지수는 20페이지가 되어야 함
      int endPage = startPage + limit - 1;
      if(maxPage < endPage){
         endPage = maxPage;
      }
      
      if(list != null){
         RequestDispatcher view = request.getRequestDispatcher("views/reviewboard/reviewboard.jsp");
         request.setAttribute("list", list);
         request.setAttribute("currentPage", currentPage);
         request.setAttribute("maxPage", maxPage);
         request.setAttribute("startPage", startPage);
         request.setAttribute("endPage", endPage);
         request.setAttribute("listCount", listCount);
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
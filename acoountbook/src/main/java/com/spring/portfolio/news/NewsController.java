package com.spring.portfolio.news;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.portfolio.HomeController;

@Controller
public class NewsController {

	private static final Logger logger = LoggerFactory.getLogger(NewsController.class);

	Map<String, List> newslist = new HashMap<String, List>();

	@RequestMapping(value = "crawling", method = RequestMethod.GET)
	public String startCrawl(Model model) throws IOException {

//		SimpleDateFormat formatter = new SimpleDateFormat("yyyy.MM.dd", Locale.KOREA);
//		Date currentTime = new Date();
//		
//		String dTime = formatter.format(currentTime);
//		String e_date = dTime; // 원하는포맷으로 출력한 현재시간
//		
//		currentTime.setDate(currentTime.getDate() - 1);
//		String s_date = formatter.format(currentTime);

		String address = "https://news.naver.com/main/list.nhn?mode=LSD&mid=sec&sid1=001&listType=title&date=20210628";
		
		Document rawData = Jsoup.connect(address).timeout(5000).get();
		
		System.out.println(address);		
		
		//Elements articles = rawData.select("ul.type02");
		Elements articles = rawData.select("ul.type02 > li");
		
		List<String> hreflist = new ArrayList<String>();
		List<String> titlelist = new ArrayList<String>();
		List<String> writerlist = new ArrayList<String>();
		List<String> writeDatelist = new ArrayList<String>();
		
		for(Element e : articles) {
			System.out.println(e.toString());
			 
			String href = e.select("a").attr("href");
			String title = e.select("a").text();
			String writer = e.select("span.writing").text();
			String writeDate = e.select("span.date").text();
			
			hreflist.add(href);
			titlelist.add(title);
			writerlist.add(writer);
			writeDatelist.add(writeDate);
			
		}
		
		
		System.out.println("writeDatelist----------------------");
		for(String str : writeDatelist) {
			System.out.println(str);
		}
		System.out.println("----------------------");
		
		newslist.put("href", hreflist);
		newslist.put("title", titlelist);
		newslist.put("writer", writerlist);
		newslist.put("writeDate", writeDatelist);
		
		System.out.println(newslist);
		
		model.addAttribute("articles", articles);
		
		return "/home";
		

		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		

	}

}

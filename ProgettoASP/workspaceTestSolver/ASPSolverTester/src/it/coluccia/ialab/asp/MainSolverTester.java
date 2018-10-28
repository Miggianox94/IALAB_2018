package it.coluccia.ialab.asp;

import java.io.File;
import java.io.IOException;
import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import org.apache.commons.io.FileUtils;

public class MainSolverTester {

	public static void main(String[] args){
		File file = new File("./inputFiles/fileToTest");

        try {
            String content = FileUtils.readFileToString(file,Charset.defaultCharset());
            String[] lines = content.split(" ");
            List<Result> parsedResult = new ArrayList<>();
            for(String line : lines){
            	int endIndex = line.indexOf(",");
            	String teamHomeName = line.substring(line.indexOf("(")+1, endIndex);
            	endIndex = line.indexOf(",",endIndex+1);
            	String teamGuestName = line.substring(line.indexOf(",")+1, endIndex);
            	endIndex = line.indexOf(",",endIndex+1);
            	String city = line.substring(line.indexOf(",",line.indexOf(",")+1)+1, endIndex);
            	endIndex = line.indexOf(",",endIndex+1);
            	Integer day = Integer.parseInt(line.substring(line.lastIndexOf(",")+1, line.indexOf(")")));
            	parsedResult.add(new MainSolverTester().new Result(teamHomeName,teamGuestName,city,day));
            }
            checkIfIsCorrect(parsedResult);
            System.out.println("######### THE OUTPUT IS CORRECT ########");
            printResultOrdered(parsedResult);
        } catch (IOException e) {
            e.printStackTrace();
        }
	}
	
	private static void printResultOrdered(List<Result> resultList){
		Collections.sort(resultList, new Comparator<Result>(){

			@Override
			public int compare(Result arg0, Result arg1) {
				return arg0.getDay().compareTo(arg1.getDay());
			}
			
		});
		
		for(Result result : resultList){
			System.out.println(result);
		}
	}
	
	
	private static void checkIfIsCorrect(List<Result> resultList){
		//In ogni giornata ci deve essere una sola partita
		checkMoreMatchDay(resultList);
		//Ogni squadra deve affrontare una volta in casa ogni altra squadra
		//TODO: checkHomeMatch(resultList);
		//Ogni squadra deve affrontare una volta in trasferta ogni altra squadra
		//TODO: checkGuestMatch(resultList);
		//Non ci possono essere due match uguali
		checkEqualsMatch(resultList);
		//Una squadra non può giocare con se stessa
		checkSameTeam(resultList);
		//Una squadra non può giocare tre partite consecutive in casa
		//TODO: checkThreeHomeMatch(resultList);
		//Una squadra non può giocare tre partite consecutive in trasferta
		//TODO: checkThreeGuestMatch(resultList);
		//Una squadra che gioca in casa deve giocare sempre nella sua città
		//TODO: checkHomeMatchLocation(resultList);
	}
	
	
	/*private static void checkThreeHomeMatch(List<Result> resultList){
		for(Result result : resultList){
			Collection<Result> smallList = CollectionUtils.select(resultList, o -> {
				Result c = (Result)o;
			    return c.getTeamHomeName().equals(result.getTeamHomeName());
			});
			if(smallList.size() > 2){
				throw new RuntimeException("Una squadra gioca più di due volte in casa! " + result);
			}
		}
	}
	
	private static void checkThreeGuestMatch(List<Result> resultList){
		for(Result result : resultList){
			Collection<Result> smallList = CollectionUtils.select(resultList, o -> {
				Result c = (Result)o;
			    return c.getTeamGuestName().equals(result.getTeamGuestName());
			});
			if(smallList.size() > 2){
				throw new RuntimeException("Una squadra gioca più di due volte fuoriCasa! " + result);
			}
		}
	}*/
	
	private static void checkSameTeam(List<Result> resultList){
		for(Result result : resultList){
			if(result.getTeamHomeName().equalsIgnoreCase(result.getTeamGuestName())){
				throw new RuntimeException("Evento nel quale una squadra gioca con se stessa! " + result);
			}
		}
	}
	
	
	private static void checkEqualsMatch(List<Result> resultList){
		for(Result result : resultList){
			List<Result> copyOfResultList = new ArrayList<>(resultList);
			copyOfResultList.remove(result);
			if(copyOfResultList.contains(result)){
				throw new RuntimeException("Due eventi uguali! " + result);
			}
		}
	}
	
	
	private static void checkMoreMatchDay(List<Result> resultList){
		for(Result result : resultList){
			for(Result result2 : resultList){
				if(!result2.equals(result) && result2.getDay().equals(result.getDay())){
					throw new RuntimeException("Due eventi nello stesso giorno! " + result + " / "+ result2);
				}
			}
		}
	}
	
	private class Result{
		private String teamHomeName;
		private String teamGuestName;
		private String city;
		private Integer day;
		
		public Result(String teamHomeName, String teamGuestName, String city, Integer day) {
			super();
			this.teamHomeName = teamHomeName;
			this.teamGuestName = teamGuestName;
			this.city = city;
			this.day = day;
		}

		public String getTeamHomeName() {
			return teamHomeName;
		}

		public void setTeamHomeName(String teamHomeName) {
			this.teamHomeName = teamHomeName;
		}

		public String getTeamGuestName() {
			return teamGuestName;
		}

		public void setTeamGuestName(String teamGuestName) {
			this.teamGuestName = teamGuestName;
		}

		public String getCity() {
			return city;
		}

		public void setCity(String city) {
			this.city = city;
		}

		public Integer getDay() {
			return day;
		}

		public void setDay(Integer day) {
			this.day = day;
		}

		@Override
		public int hashCode() {
			final int prime = 31;
			int result = 1;
			result = prime * result + getOuterType().hashCode();
			result = prime * result + ((teamGuestName == null) ? 0 : teamGuestName.hashCode());
			result = prime * result + ((teamHomeName == null) ? 0 : teamHomeName.hashCode());
			return result;
		}
		
		

		@Override
		public String toString() {
			return "Result [teamHomeName=" + teamHomeName + ", teamGuestName=" + teamGuestName + ", city=" + city
					+ ", day=" + day + "]";
		}

		@Override
		public boolean equals(Object obj) {
			if (this == obj)
				return true;
			if (obj == null)
				return false;
			if (getClass() != obj.getClass())
				return false;
			Result other = (Result) obj;
			if (!getOuterType().equals(other.getOuterType()))
				return false;
			if (teamGuestName == null) {
				if (other.teamGuestName != null)
					return false;
			} else if (!teamGuestName.equals(other.teamGuestName))
				return false;
			if (teamHomeName == null) {
				if (other.teamHomeName != null)
					return false;
			} else if (!teamHomeName.equals(other.teamHomeName))
				return false;
			return true;
		}

		private MainSolverTester getOuterType() {
			return MainSolverTester.this;
		}
		
		
		
		
		
		
	}
	
}

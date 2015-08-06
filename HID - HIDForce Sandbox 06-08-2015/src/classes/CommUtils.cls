public class CommUtils {
    public static List<Integer> getPaginationList (Integer curPageNo, Integer totalResults, Integer pagesize) {
        List<Integer> paginationList = new List<Integer>(); 
        Double totalNumOfPages = math.ceil(Double.valueof(totalResults)/Double.valueof(pagesize));
        Integer index;
        If(curPageNo <= 4 ){
            for (index=curPageNo-3;index<curPageNo;index+=1) {//Enter Here for first 3 pages
                if(index<=0) {
                    continue;  
                }
                paginationList.add(index);
            }
            paginationList.add(curPageNo);
            Integer jindex;      
            for (jindex=curPageNo+1;jindex<=7;jindex+=1) {
                If(jindex >= totalNumOfPages+1){
                    break;
                }
                paginationList.add(jindex);
            }
        }else If(curPageNo >= 4 && curPageNo < totalNumOfPages-3){//Enter here for Pages In Between
                for (index=curPageNo-3;index<curPageNo;index+=1) {
                    if(index<=0) {
                        continue;  
                    }
                    paginationList.add(index);
                }
                paginationList.add(curPageNo);
                Integer jindex;      
                for (jindex=curPageNo+1;jindex<=curPageNo+3;jindex+=1) {
                    if(jindex > totalResults/pageSize){
                        break;
                    }
                    paginationList.add(jindex);
                }
        } else {//Enter Here for last 3 pages
                System.Debug('Entered here for last three numbers'+curPageNo);
                Integer tempNum;//Number of digits before last three digits to keep the list count(7) for last three digits
                System.Debug(''+totalNumOfPages);
                If(curPageNo == totalNumOfPages-3){tempNum = 3;}
                If(curPageNo == totalNumOfPages-2){tempNum = 4;}
                If(curPageNo == totalNumOfPages-1){tempNum = 5;}
                If(curPageNo == totalNumOfPages)  {tempNum = 6;}
                for (index=curPageNo-tempNum;index<curPageNo;index+=1) {
                    if(index<=0) {
                        continue;  
                    }
                    paginationList.add(index);
                }
                paginationList.add(curPageNo);
                Integer jindex;      
                for (jindex=curPageNo+1;jindex<=totalNumOfPages+2;jindex+=1) {
                    if(jindex > totalNumOfPages){
                    break;
                    }
                    paginationList.add(jindex);
                }
        }
        System.Debug('++paginationList++'+paginationList);
        return paginationList;
    } 
}